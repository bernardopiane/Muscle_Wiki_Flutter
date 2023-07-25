class Exercise {
  final String? category;
  final String? difficulty;
  final String? force;
  final String? grips;
  final String? details;
  final String? exerciseName;
  final int? id;
  final List<String>? steps;
  final Target? target;
  final List<String>? videoURL;
  final String? youtubeURL;

  Exercise({
    this.category,
    this.difficulty,
    this.force,
    this.grips,
    this.details,
    this.exerciseName,
    this.id,
    this.steps,
    this.target,
    this.videoURL,
    this.youtubeURL,
  });

  Exercise.fromJson(Map<String, dynamic> json)
      : category = json['Category'] as String?,
        difficulty = json['Difficulty'] as String?,
        force = json['Force'] as String?,
        grips = json['Grips'] as String?,
        details = json['details'] as String?,
        exerciseName = json['exercise_name'] as String?,
        id = json['id'] as int?,
        steps =
            (json['steps'] as List?)?.map((dynamic e) => e as String).toList(),
        target = (json['target'] as Map<String, dynamic>?) != null
            ? Target.fromJson(json['target'] as Map<String, dynamic>)
            : null,
        videoURL = (json['videoURL'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        youtubeURL = json['youtubeURL'] as String?;

  Map<String, dynamic> toJson() => {
        'Category': category,
        'Difficulty': difficulty,
        'Force': force,
        'Grips': grips,
        'details': details,
        'exercise_name': exerciseName,
        'id': id,
        'steps': steps,
        'target': target?.toJson(),
        'videoURL': videoURL,
        'youtubeURL': youtubeURL
      };
}

class Target {
  final List<String>? primary;
  final List<String>? secondary;
  final List<String>? tertiary;

  Target({
    this.primary,
    this.secondary,
    this.tertiary,
  });

  // Method to convert Target object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Primary': primary,
      'Secondary': secondary,
      'Tertiary': tertiary,
    };
  }

  // Factory method to create a Target object from a JSON map
  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(
      primary:
          json['Primary'] != null ? List<String>.from(json['Primary']) : null,
      secondary: json['Secondary'] != null
          ? List<String>.from(json['Secondary'])
          : null,
      tertiary:
          json['Tertiary'] != null ? List<String>.from(json['Tertiary']) : null,
    );
  }
}
