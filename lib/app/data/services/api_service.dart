import 'package:one_request/one_request.dart';
import 'dart:io';
import 'dart:convert';
import '../models/task_model.dart';
import '../models/dashboard_stats_model.dart';
import '../models/balance_model.dart';
import '../models/task_submission_model.dart';
import '../../core/config/app_config.dart';
import 'storage_service.dart';

class ApiService {
  static final OneRequest _request = OneRequest();


  // Auth APIs
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final result = await _request.send<Map<String, dynamic>>(
        url: '/auth/login/',
        method: RequestType.POST,
        body: {'username': email, 'password': password},
        loader: true,
        maxRetries: 2,
        retryDelay: const Duration(seconds: 1),
      );

      return result.fold(
        (data) {
          // Extract user ID from token if available
          String userId = '1';
          try {
            // Try to decode JWT token to get user_id
            final token = data['token'] ?? '';
            if (token.isNotEmpty) {
              final parts = token.split('.');
              if (parts.length == 3) {
                // Decode payload (second part)
                final payload = parts[1];
                // Add padding if needed
                String normalizedPayload = payload;
                switch (payload.length % 4) {
                  case 1:
                    normalizedPayload += '===';
                    break;
                  case 2:
                    normalizedPayload += '==';
                    break;
                  case 3:
                    normalizedPayload += '=';
                    break;
                }
                try {
                  final decoded = Uri.decodeComponent(
                    String.fromCharCodes(
                      List<int>.from(
                        base64.decode(normalizedPayload),
                      ),
                    ),
                  );
                  final jsonData = jsonDecode(decoded);
                  userId = jsonData['user_id']?.toString() ?? 
                          jsonData['id']?.toString() ?? 
                          '1';
                } catch (e) {
                  // If decoding fails, use default
                }
              }
            }
          } catch (e) {
            // If token parsing fails, use default
          }
          
          // Transform backend response to match Flutter app's expected format
          return {
            'success': true,
            'token': data['token'] ?? data['refresh'], // Use token field
            'user': {
              'id': userId,
              'name': data['username'] ?? 'User',
              'email': data['email'] ?? email,
              'user_id': userId,
              'balance': 0.0, // Will be fetched from dashboard
            },
          };
        },
        (error) {
          String errorMsg = 'Login failed';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else if (error is SocketException) {
            errorMsg = 'Network error: ${error.toString()}';
          } else {
            errorMsg = error.toString();
            if (errorMsg.isEmpty || errorMsg == 'null') {
              errorMsg = 'Login failed. Please check your credentials.';
            }
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await _request.send<Map<String, dynamic>>(
        url: '/auth/app-users/register',
        method: RequestType.POST,
        body: {
          'user': {
            'username': email, // Use email as username
            'password': password,
            'email': email,
          },
          'phone_number': '',
          'address': '',
        },
        loader: true,
      );

      return result.fold(
        (data) => {
          'success': true,
          'message': 'Registration successful',
          'data': data,
        },
        (error) {
          String errorMsg = 'Registration failed';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else {
            errorMsg = error.toString();
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    // Mock response for demo
    await Future.delayed(const Duration(seconds: 1));
    return {
      'success': true,
      'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      'user': {
        'id': '1',
        'name': 'NAFSIN RAHMAN',
        'email': email,
        'user_id': '34874',
        'balance': 12000.0,
      },
    };
  }

  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'success': true, 'message': 'OTP sent to your email'};
  }

  static Future<Map<String, dynamic>> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'success': true, 'message': 'Password reset successful'};
  }

  // Dashboard APIs
  static Future<DashboardStatsModel> getDashboardStats() async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);
      
      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/dashboard/stats/',
        method: RequestType.GET,
        maxRedirects: 5,
        loader: true,
      );

      return result.fold(
        (data) {
          return DashboardStatsModel.fromJson(data);
        },
        (error) {
          String errorMsg = 'Failed to fetch dashboard stats';
          if (error is String) {
            final trimmed = error.trim();
            if (trimmed.isNotEmpty) {
              errorMsg = trimmed;
            }
          } else if (error is SocketException) {
            errorMsg = 'Network error: ${error.toString()}';
          } else {
            final errorStr = error.toString().trim();
            if (errorStr.isNotEmpty && errorStr != 'null') {
              errorMsg = errorStr;
            }
          }
          // Final fallback
          if (errorMsg.trim().isEmpty) {
            errorMsg = 'Unable to connect to server. Please check your connection.';
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get Task Details
  static Future<TaskModel> getTaskDetails(String taskId) async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);
      
      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/tasks/$taskId/details/',
        method: RequestType.GET,
        maxRedirects: 5,
        loader: true,
      );

      return result.fold(
        (data) {
          return TaskModel.fromJson(data);
        },
        (error) {
          String errorMsg = 'Failed to fetch task details';
          if (error is String) {
            final trimmed = error.trim();
            if (trimmed.isNotEmpty) {
              errorMsg = trimmed;
            }
          } else if (error is SocketException) {
            errorMsg = 'Network error: ${error.toString()}';
          } else {
            final errorStr = error.toString().trim();
            if (errorStr.isNotEmpty && errorStr != 'null') {
              errorMsg = errorStr;
            }
          }
          if (errorMsg.trim().isEmpty) {
            errorMsg = 'Unable to connect to server. Please check your connection.';
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getTasks({
    String status = 'all',
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);
      
      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/tasks/list/',
        method: RequestType.GET,
        queryParameters: {
          'status': status,
          'page': page.toString(),
          'page_size': pageSize.toString(),
        },
        maxRedirects: 5,
        loader: page == 1, // Only show loader on first page
      );

      return result.fold(
        (data) {
          return data;
        },
        (error) {
          String errorMsg = 'Failed to fetch tasks';
          if (error is String) {
            // Trim and check if not empty
            final trimmed = error.trim();
            if (trimmed.isNotEmpty) {
              errorMsg = trimmed;
            }
          } else if (error is SocketException) {
            errorMsg = 'Network error: ${error.toString()}';
          } else {
            final errorStr = error.toString().trim();
            if (errorStr.isNotEmpty && errorStr != 'null') {
              errorMsg = errorStr;
            }
          }
          // Final fallback
          if (errorMsg.trim().isEmpty) {
            errorMsg = 'Unable to connect to server. Please check your connection.';
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Accept Task API
  static Future<Map<String, dynamic>> acceptTask(String taskId) async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);
      
      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/tasks/$taskId/accept/',
        method: RequestType.POST,
        maxRedirects: 5,
        loader: true,
      );

      return result.fold(
        (data) => data,
        (error) {
          String errorMsg = 'Failed to accept task';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else {
            errorMsg = error.toString();
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Reject Task API
  static Future<Map<String, dynamic>> rejectTask(String taskId) async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);
      
      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/tasks/$taskId/reject/',
        method: RequestType.POST,
        maxRedirects: 5,
        loader: true,
      );

      return result.fold(
        (data) => data,
        (error) {
          String errorMsg = 'Failed to reject task';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else {
            errorMsg = error.toString();
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Task Submission API
  static Future<Map<String, dynamic>> submitTask(
    TaskSubmissionModel submission,
  ) async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Map images to backend format
      // The Flutter app has images in a list, but we need to map them by position
      // Assumes: images[0]=front, images[1]=left, images[2]=right, images[3]=close
      Map<String, String?> imageMap = {
        'front_image': null,
        'left_image': null,
        'right_image': null,
        'close_image': null,
      };

      // Map images based on position (assuming order: front, left, right, close)
      for (int i = 0; i < submission.images.length && i < 4; i++) {
        String? imageKey;
        switch (i) {
          case 0:
            imageKey = 'front_image';
            break;
          case 1:
            imageKey = 'left_image';
            break;
          case 2:
            imageKey = 'right_image';
            break;
          case 3:
            imageKey = 'close_image';
            break;
        }
        if (imageKey != null) {
          imageMap[imageKey] = submission.images[i].base64Data;
        }
      }

      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);

      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/task-submission/${submission.taskId}/submit/',
        method: RequestType.POST,
        body: {
          'notes': submission.notes ?? '',
          ...imageMap,
          // Status fields (4 different parts)
          if (submission.colourStatus != null) 'colour_status': submission.colourStatus,
          if (submission.structureStatus != null) 'structure_status': submission.structureStatus,
          if (submission.mediumStatus != null) 'medium_status': submission.mediumStatus,
          if (submission.communicationStatus != null) 'communication_status': submission.communicationStatus,
        },
        maxRedirects: 5,
        loader: true,
      );

      return result.fold(
        (data) => data,
        (error) {
          String errorMsg = 'Failed to submit task';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else {
            errorMsg = error.toString();
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Balance APIs
  static Future<List<BalanceModel>> getBalanceHistory() async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);
      
      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/balance/history/',
        method: RequestType.GET,
        maxRedirects: 5,
        loader: true,
      );

      return result.fold(
        (data) {
          final transactions = data['transactions'] as List?;
          if (transactions == null) return <BalanceModel>[];
          
          return transactions
              .map((tx) => BalanceModel.fromJson(tx))
              .toList();
        },
        (error) {
          String errorMsg = 'Failed to fetch balance history';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else {
            errorMsg = error.toString();
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Withdraw API
  static Future<Map<String, dynamic>> withdrawRequest(
    double amount,
    String method,
    Map<String, dynamic> details,
  ) async {
    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Not authenticated. Please login again.');
      }
      
      // Map method to backend format
      String paymentMethod;
      switch (method) {
        case 'bank':
          paymentMethod = 'bank_transfer';
          break;
        case 'bkash':
        case 'nagad':
        case 'rocket':
          paymentMethod = 'mobile_banking';
          break;
        default:
          paymentMethod = 'other';
      }

      // Ensure global headers are updated with current token
      AppConfig.updateAuthHeaders(token);

      final result = await _request.send<Map<String, dynamic>>(
        url: '/mobile/withdraw/request/',
        method: RequestType.POST,
        body: {
          'amount': amount,
          'payment_method': paymentMethod,
          'account_details': details.toString(),
          'notes': details.toString(), // Can be customized
        },
        maxRedirects: 5,
        loader: true,
      );

      return result.fold(
        (data) => data,
        (error) {
          String errorMsg = 'Failed to submit withdrawal request';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else {
            errorMsg = error.toString();
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Google Sign In
  static Future<Map<String, dynamic>> googleSignIn(String googleToken) async {
    try {
      final result = await _request.send<Map<String, dynamic>>(
        url: '/auth/google-signin/',
        method: RequestType.POST,
        body: {'id_token': googleToken},
        loader: true,
        maxRetries: 2,
        retryDelay: const Duration(seconds: 1),
      );

      return result.fold(
        (data) {
          // Extract user ID from token if available
          String userId = '1';
          try {
            final token = data['token'] ?? '';
            if (token.isNotEmpty) {
              final parts = token.split('.');
              if (parts.length == 3) {
                final payload = parts[1];
                String normalizedPayload = payload;
                switch (payload.length % 4) {
                  case 1:
                    normalizedPayload += '===';
                    break;
                  case 2:
                    normalizedPayload += '==';
                    break;
                  case 3:
                    normalizedPayload += '=';
                    break;
                }
                try {
                  final decoded = Uri.decodeComponent(
                    String.fromCharCodes(
                      List<int>.from(
                        base64.decode(normalizedPayload),
                      ),
                    ),
                  );
                  final jsonData = jsonDecode(decoded);
                  userId = jsonData['user_id']?.toString() ?? 
                          jsonData['id']?.toString() ?? 
                          '1';
                } catch (e) {
                  // If decoding fails, use default
                }
              }
            }
          } catch (e) {
            // If token parsing fails, use default
          }
          
          // Transform backend response to match Flutter app's expected format
          return {
            'success': true,
            'token': data['token'],
            'user': {
              'id': userId,
              'name': data['username'] ?? 'User',
              'email': data['email'] ?? '',
              'user_id': userId,
              'balance': 0.0, // Will be fetched from dashboard
            },
          };
        },
        (error) {
          String errorMsg = 'Google sign-in failed';
          if (error is String && error.isNotEmpty) {
            errorMsg = error;
          } else {
            errorMsg = error.toString();
          }
          throw Exception(errorMsg);
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}

