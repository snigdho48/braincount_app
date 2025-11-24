class TaskModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final double reward;
  final String status;
  final DateTime? deadline;
  final int views;
  final String? submissionStatus;
  final String? submittedStatus;
  final DateTime? submittedAt;
  
  // Status fields from submission (4 different parts)
  final String? colourStatus;
  final String? structureStatus;
  final String? mediumStatus;
  final String? communicationStatus;
  final String? overallStatus;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.reward,
    this.status = 'pending',
    this.deadline,
    this.views = 0,
    this.submissionStatus,
    this.submittedStatus,
    this.submittedAt,
    this.colourStatus,
    this.structureStatus,
    this.mediumStatus,
    this.communicationStatus,
    this.overallStatus,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    // Helper to parse date from string or DateTime
    DateTime? parseDate(dynamic dateValue) {
      if (dateValue == null) return null;
      if (dateValue is DateTime) return dateValue;
      if (dateValue is String) {
        try {
          return DateTime.parse(dateValue);
        } catch (e) {
          return null;
        }
      }
      return null;
    }
    
    // Extract submission data if available
    final submission = json['submission'] as Map<String, dynamic>?;

    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['image_url'] ?? '',
      reward: (json['reward'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      deadline: parseDate(json['deadline']),
      views: json['views'] ?? 0,
      submissionStatus: json['submission_status'] ?? json['submitted_status'] ?? json['payment_status'],
      submittedStatus: json['submitted_status'] ?? json['submission_status'] ?? json['payment_status'],
      submittedAt: parseDate(json['submitted_at']),
      // Status fields from submission
      colourStatus: submission?['colour_status'],
      structureStatus: submission?['structure_status'],
      mediumStatus: submission?['medium_status'],
      communicationStatus: submission?['communication_status'],
      overallStatus: submission?['overall_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'image_url': imageUrl,
      'reward': reward,
      'status': status,
      'deadline': deadline?.toIso8601String(),
      'views': views,
      'submission_status': submissionStatus,
      'submitted_status': submittedStatus,
      'submitted_at': submittedAt?.toIso8601String(),
    };
  }

  bool get isCompleted => status == 'completed';
  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted';
  bool get isSubmitted => status == 'submitted';
  bool get isRejected => status == 'rejected';
}


