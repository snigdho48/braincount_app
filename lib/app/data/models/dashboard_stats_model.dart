import 'task_model.dart';

class DashboardStatsModel {
  final int taskCompleted;
  final int taskPending;
  final int taskRejected;
  final double balance;
  final List<TaskModel>? recentTasks;

  DashboardStatsModel({
    this.taskCompleted = 0,
    this.taskPending = 0,
    this.taskRejected = 0,
    this.balance = 0.0,
    this.recentTasks,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      taskCompleted: json['task_completed'] ?? 0,
      taskPending: json['task_pending'] ?? 0,
      taskRejected: json['task_rejected'] ?? 0,
      balance: (json['balance'] ?? 0).toDouble(),
      recentTasks: json['recent_tasks'] != null
          ? (json['recent_tasks'] as List)
              .map((task) => TaskModel.fromJson(task))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_completed': taskCompleted,
      'task_pending': taskPending,
      'task_rejected': taskRejected,
      'balance': balance,
      'recent_tasks': recentTasks?.map((task) => task.toJson()).toList(),
    };
  }
}


