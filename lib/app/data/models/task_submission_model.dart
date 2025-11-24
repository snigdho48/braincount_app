class TaskSubmissionModel {
  final String taskId;
  final String? notes;
  final List<SubmissionImage> images;
  final DateTime submittedAt;
  
  // Status fields (4 different parts)
  final String? colourStatus;      // good, degraded, critical
  final String? structureStatus;  // good, degraded, critical
  final String? mediumStatus;     // good, degraded, critical
  final String? communicationStatus; // good, critical

  TaskSubmissionModel({
    required this.taskId,
    this.notes,
    required this.images,
    required this.submittedAt,
    this.colourStatus,
    this.structureStatus,
    this.mediumStatus,
    this.communicationStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'notes': notes,
      'images': images.map((e) => e.toJson()).toList(),
      'submitted_at': submittedAt.toIso8601String(),
      'colour_status': colourStatus,
      'structure_status': structureStatus,
      'medium_status': mediumStatus,
      'communication_status': communicationStatus,
    };
  }

  factory TaskSubmissionModel.fromJson(Map<String, dynamic> json) {
    return TaskSubmissionModel(
      taskId: json['task_id'] ?? '',
      notes: json['notes'],
      images: (json['images'] as List?)
              ?.map((e) => SubmissionImage.fromJson(e))
              .toList() ??
          [],
      submittedAt: DateTime.parse(json['submitted_at']),
      colourStatus: json['colour_status'],
      structureStatus: json['structure_status'],
      mediumStatus: json['medium_status'],
      communicationStatus: json['communication_status'],
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


