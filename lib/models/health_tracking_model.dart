class SleepTrackingModel {
  final int? id;
  final DateTime date;
  final DateTime? bedtime;
  final DateTime? wakeTime;
  final double? duration; // in hours
  final int quality; // 1-5
  final DateTime createdAt;

  SleepTrackingModel({
    this.id,
    required this.date,
    this.bedtime,
    this.wakeTime,
    this.duration,
    this.quality = 3,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'bedtime': bedtime?.toIso8601String(),
      'wake_time': wakeTime?.toIso8601String(),
      'duration': duration,
      'quality': quality,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory SleepTrackingModel.fromMap(Map<String, dynamic> map) {
    return SleepTrackingModel(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      bedtime: map['bedtime'] != null
          ? DateTime.parse(map['bedtime'] as String)
          : null,
      wakeTime: map['wake_time'] != null
          ? DateTime.parse(map['wake_time'] as String)
          : null,
      duration: map['duration'] != null
          ? (map['duration'] as num).toDouble()
          : null,
      quality: map['quality'] as int? ?? 3,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }
}

class WaterIntakeModel {
  final int? id;
  final DateTime date;
  final int amount; // in ml
  final DateTime createdAt;

  WaterIntakeModel({
    this.id,
    required this.date,
    required this.amount,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory WaterIntakeModel.fromMap(Map<String, dynamic> map) {
    return WaterIntakeModel(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      amount: map['amount'] as int,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }
}

class HealthGoalModel {
  final int? id;
  final String title;
  final String target;
  final String current;
  final double progress; // 0.0 to 1.0
  final String deadline;
  final DateTime createdAt;
  final DateTime? updatedAt;

  HealthGoalModel({
    this.id,
    required this.title,
    required this.target,
    required this.current,
    required this.progress,
    required this.deadline,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'target': target,
      'current': current,
      'progress': progress,
      'deadline': deadline,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory HealthGoalModel.fromMap(Map<String, dynamic> map) {
    return HealthGoalModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      target: map['target'] as String,
      current: map['current'] as String,
      progress: (map['progress'] as num).toDouble(),
      deadline: map['deadline'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }
}

