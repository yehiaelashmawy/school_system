class StudentLessonObjective {
  final String oid;
  final String description;
  final int order;

  StudentLessonObjective({
    required this.oid,
    required this.description,
    required this.order,
  });

  factory StudentLessonObjective.fromJson(Map<String, dynamic> json) {
    return StudentLessonObjective(
      oid: json['oid'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
    );
  }
}

class StudentLessonMaterial {
  final String oid;
  final String name;
  final String fileUrl;
  final String fileType;
  final int fileSize;

  StudentLessonMaterial({
    required this.oid,
    required this.name,
    required this.fileUrl,
    required this.fileType,
    required this.fileSize,
  });

  factory StudentLessonMaterial.fromJson(Map<String, dynamic> json) {
    return StudentLessonMaterial(
      oid: json['oid'] ?? '',
      name: json['name'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileType: json['fileType'] ?? '',
      fileSize: json['fileSize'] ?? 0,
    );
  }

  bool get isPdf =>
      fileType.toLowerCase().contains('pdf') ||
      name.toLowerCase().endsWith('.pdf');

  String get formattedSize {
    if (fileSize <= 0) return 'Unknown size';
    final kb = fileSize / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(0)} KB';
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }
}

class StudentLessonDetailModel {
  final String oid;
  final String title;
  final String? description;
  final String status;
  final String type;
  final String className;
  final String subjectName;
  final String teacherName;
  final int duration;
  final int materialsCount;
  final int objectivesCount;
  final bool hasHomework;
  final List<StudentLessonObjective> objectives;
  final List<StudentLessonMaterial> materials;

  StudentLessonDetailModel({
    required this.oid,
    required this.title,
    this.description,
    required this.status,
    required this.type,
    required this.className,
    required this.subjectName,
    required this.teacherName,
    required this.duration,
    required this.materialsCount,
    required this.objectivesCount,
    required this.hasHomework,
    required this.objectives,
    required this.materials,
  });

  factory StudentLessonDetailModel.fromJson(Map<String, dynamic> json) {
    var objectivesList = json['objectives'] as List? ?? [];
    var materialsList = json['materials'] as List? ?? [];

    return StudentLessonDetailModel(
      oid: json['oid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      className: json['className'] ?? '',
      subjectName: json['subjectName'] ?? '',
      teacherName: json['teacherName'] ?? '',
      duration: json['duration'] ?? 0,
      materialsCount: json['materialsCount'] ?? 0,
      objectivesCount: json['objectivesCount'] ?? 0,
      hasHomework: json['hasHomework'] ?? false,
      objectives: objectivesList
          .map((i) => StudentLessonObjective.fromJson(i))
          .toList(),
      materials: materialsList
          .map((i) => StudentLessonMaterial.fromJson(i))
          .toList(),
    );
  }
}
