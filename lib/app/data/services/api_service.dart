import 'package:one_request/one_request.dart';
import '../models/task_model.dart';
import '../models/dashboard_stats_model.dart';
import '../models/balance_model.dart';
import '../models/task_submission_model.dart';

class ApiService {
  static final OneRequest _request = OneRequest();

  // Auth APIs
  static Future<Map<String, dynamic>> login(String email, String password) async {
    // Mock response for demo
    await Future.delayed(const Duration(seconds: 2));
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

    /* Uncomment for real API with one_request
    final result = await _request.send<Map<String, dynamic>>(
      url: '/auth/login',
      method: RequestType.POST,
      body: {'email': email, 'password': password},
      loader: true,
      maxRetries: 2,
      retryDelay: const Duration(seconds: 1),
    );

    return result.fold(
      (data) => data,
      (error) => throw Exception(error),
    );
    */
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    // Mock response for demo
    await Future.delayed(const Duration(seconds: 2));
    return {
      'success': true,
      'message': 'Registration successful',
    };
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
    await Future.delayed(const Duration(seconds: 1));
    return DashboardStatsModel(
      taskCompleted: 22,
      taskPending: 1,
      taskRejected: 3,
      balance: 12000.0,
    );
  }

  static Future<List<TaskModel>> getTasks({String status = 'all'}) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data
    final tasks = [
      TaskModel(
        id: '01',
        title: 'TASK: Gulshan 2 Billboard',
        description: 'Check billboard condition at Gulshan 2',
        location: 'Gulshan 2, Dhaka',
        imageUrl: '',
        reward: 250.0,
        status: 'submitted',
        views: 2,
        submissionStatus: 'Accepted',
        submittedStatus: 'Good',
        deadline: DateTime.now().add(const Duration(days: 5)),
      ),
      TaskModel(
        id: '02',
        title: 'TASK: Shitolpur School Ctg',
        description: 'Check billboard at Shitolpur School',
        location: 'Chittagong',
        imageUrl: '',
        reward: 250.0,
        status: 'submitted',
        views: 2,
        submissionStatus: 'Accepted',
        submittedStatus: 'Good',
        deadline: DateTime.now().add(const Duration(days: 5)),
      ),
      TaskModel(
        id: '03',
        title: 'TASK: Banani Billboard',
        description: 'Check billboard condition at Banani',
        location: 'Banani, Dhaka',
        imageUrl: '',
        reward: 250.0,
        status: 'pending',
        views: 0,
        deadline: DateTime.now().add(const Duration(days: 3)),
      ),
    ];

    if (status == 'all') return tasks;
    return tasks.where((task) => task.status == status).toList();
  }

  // Task Submission API
  static Future<Map<String, dynamic>> submitTask(
    TaskSubmissionModel submission,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    return {
      'success': true,
      'message': 'Task submitted successfully',
    };
  }

  // Balance APIs
  static Future<List<BalanceModel>> getBalanceHistory() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      BalanceModel(
        id: '1',
        amount: 250.0,
        type: 'earning',
        description: 'Task completed: Gulshan 2 Billboard',
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      BalanceModel(
        id: '2',
        amount: 1000.0,
        type: 'withdrawal',
        description: 'Withdrawal to bank account',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      BalanceModel(
        id: '3',
        amount: 250.0,
        type: 'earning',
        description: 'Task completed: Shitolpur School',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  // Withdraw API
  static Future<Map<String, dynamic>> withdrawRequest(
    double amount,
    String method,
    Map<String, dynamic> details,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'success': true,
      'message': 'Withdrawal request submitted',
      'transaction_id': 'TXN${DateTime.now().millisecondsSinceEpoch}',
    };
  }

  // Google Sign In (mock)
  static Future<Map<String, dynamic>> googleSignIn(String googleToken) async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'success': true,
      'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      'user': {
        'id': '1',
        'name': 'NAFSIN RAHMAN',
        'email': 'user@gmail.com',
        'user_id': '34874',
        'balance': 12000.0,
      },
    };
  }
}

