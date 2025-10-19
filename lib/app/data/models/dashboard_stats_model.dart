class DashboardStatsModel {
  final int taskCompleted;
  final int taskPending;
  final int taskRejected;
  final double balance;

  DashboardStatsModel({
    this.taskCompleted = 0,
    this.taskPending = 0,
    this.taskRejected = 0,
    this.balance = 0.0,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      taskCompleted: json['task_completed'] ?? 0,
      taskPending: json['task_pending'] ?? 0,
      taskRejected: json['task_rejected'] ?? 0,
      balance: (json['balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_completed': taskCompleted,
      'task_pending': taskPending,
      'task_rejected': taskRejected,
      'balance': balance,
    };
  }
}


