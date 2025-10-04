class CallStatsModel {
  final int totalCalls;
  final int successfulCalls;
  final int failedCalls;
  final double conversionRate;
  final int callsToday;
  final List<WeeklyData> weeklyData;
  final List<MonthlyData> monthlyData;

  CallStatsModel({
    required this.totalCalls,
    required this.successfulCalls,
    required this.failedCalls,
    required this.conversionRate,
    required this.callsToday,
    required this.weeklyData,
    required this.monthlyData,
  });

  factory CallStatsModel.fromJson(Map<String, dynamic> json) {
    return CallStatsModel(
      totalCalls: json['total_calls'] ?? 0,
      successfulCalls: json['successful_calls'] ?? 0,
      failedCalls: json['failed_calls'] ?? 0,
      conversionRate: (json['conversion_rate'] ?? 0.0).toDouble(),
      callsToday: json['calls_today'] ?? 0,
      weeklyData: (json['weekly_data'] as List?)
          ?.map((e) => WeeklyData.fromJson(e))
          .toList() ?? [],
      monthlyData: (json['monthly_data'] as List?)
          ?.map((e) => MonthlyData.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_calls': totalCalls,
      'successful_calls': successfulCalls,
      'failed_calls': failedCalls,
      'conversion_rate': conversionRate,
      'calls_today': callsToday,
      'weekly_data': weeklyData.map((e) => e.toJson()).toList(),
      'monthly_data': monthlyData.map((e) => e.toJson()).toList(),
    };
  }
}

class WeeklyData {
  final String day;
  final int calls;
  final int successful;
  final int failed;

  WeeklyData({
    required this.day,
    required this.calls,
    required this.successful,
    required this.failed,
  });

  factory WeeklyData.fromJson(Map<String, dynamic> json) {
    return WeeklyData(
      day: json['day'] ?? '',
      calls: json['calls'] ?? 0,
      successful: json['successful'] ?? 0,
      failed: json['failed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'calls': calls,
      'successful': successful,
      'failed': failed,
    };
  }
}

class MonthlyData {
  final String month;
  final int calls;
  final int successful;
  final int failed;

  MonthlyData({
    required this.month,
    required this.calls,
    required this.successful,
    required this.failed,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      month: json['month'] ?? '',
      calls: json['calls'] ?? 0,
      successful: json['successful'] ?? 0,
      failed: json['failed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'calls': calls,
      'successful': successful,
      'failed': failed,
    };
  }
}