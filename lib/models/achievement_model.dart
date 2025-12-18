class AchievementModel {
  final int? id;
  final String userEmail;
  final String achievementId; // Unique identifier like 'first_workout', 'week_warrior'
  final String title;
  final String description;
  final int xpReward;
  final String category; // 'workout', 'nutrition', 'streak', 'xp', 'water', 'sleep'
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final DateTime createdAt;

  AchievementModel({
    this.id,
    required this.userEmail,
    required this.achievementId,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.category,
    this.isUnlocked = false,
    this.unlockedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': userEmail,
      'achievement_id': achievementId,
      'title': title,
      'description': description,
      'xp_reward': xpReward,
      'category': category,
      'is_unlocked': isUnlocked ? 1 : 0,
      'unlocked_at': unlockedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AchievementModel.fromMap(Map<String, dynamic> map) {
    return AchievementModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String,
      achievementId: map['achievement_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      xpReward: map['xp_reward'] as int? ?? 0,
      category: map['category'] as String,
      isUnlocked: (map['is_unlocked'] as int? ?? 0) == 1,
      unlockedAt: map['unlocked_at'] != null
          ? DateTime.parse(map['unlocked_at'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }

  AchievementModel copyWith({
    int? id,
    String? userEmail,
    String? achievementId,
    String? title,
    String? description,
    int? xpReward,
    String? category,
    bool? isUnlocked,
    DateTime? unlockedAt,
    DateTime? createdAt,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      achievementId: achievementId ?? this.achievementId,
      title: title ?? this.title,
      description: description ?? this.description,
      xpReward: xpReward ?? this.xpReward,
      category: category ?? this.category,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

