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
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['image_url'] ?? '',
      reward: (json['reward'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      deadline: json['deadline'] != null 
          ? DateTime.parse(json['deadline']) 
          : null,
      views: json['views'] ?? 0,
      submissionStatus: json['submission_status'],
      submittedStatus: json['submitted_status'],
      submittedAt: json['submitted_at'] != null
          ? DateTime.parse(json['submitted_at'])
          : null,
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
  bool get isSubmitted => status == 'submitted';
  bool get isRejected => status == 'rejected';
}


