class TaskSubmissionModel {
  final String taskId;
  final List<String> conditions;
  final String? notes;
  final List<SubmissionImage> images;
  final DateTime submittedAt;

  TaskSubmissionModel({
    required this.taskId,
    required this.conditions,
    this.notes,
    required this.images,
    required this.submittedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'conditions': conditions,
      'notes': notes,
      'images': images.map((e) => e.toJson()).toList(),
      'submitted_at': submittedAt.toIso8601String(),
    };
  }

  factory TaskSubmissionModel.fromJson(Map<String, dynamic> json) {
    return TaskSubmissionModel(
      taskId: json['task_id'] ?? '',
      conditions: List<String>.from(json['conditions'] ?? []),
      notes: json['notes'],
      images: (json['images'] as List?)
              ?.map((e) => SubmissionImage.fromJson(e))
              .toList() ??
          [],
      submittedAt: DateTime.parse(json['submitted_at']),
    );
  }
}

class SubmissionImage {
  final String base64Data;
  final String fileName;
  final int fileSize;
  final String status;

  SubmissionImage({
    required this.base64Data,
    required this.fileName,
    required this.fileSize,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'base64_data': base64Data,
      'file_name': fileName,
      'file_size': fileSize,
      'status': status,
    };
  }

  factory SubmissionImage.fromJson(Map<String, dynamic> json) {
    return SubmissionImage(
      base64Data: json['base64_data'] ?? '',
      fileName: json['file_name'] ?? '',
      fileSize: json['file_size'] ?? 0,
      status: json['status'] ?? 'pending',
    );
  }
}


