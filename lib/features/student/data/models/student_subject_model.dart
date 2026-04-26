class StudentSubjectModel {
  final String oid;
  final String code;
  final String trackName;
  final String subjectName;
  final String professorName;
  final int progressPercentage;
  final int attendancePercentage;
  final int assignmentsPercentage;

  StudentSubjectModel({
    this.oid = '',
    this.code = '',
    required this.trackName,
    required this.subjectName,
    required this.professorName,
    required this.progressPercentage,
    required this.attendancePercentage,
    required this.assignmentsPercentage,
  });

  factory StudentSubjectModel.fromApiJson(Map<String, dynamic> json) {
    final teachersRaw = json['teachers'];
    final teachers = teachersRaw is List
        ? teachersRaw.whereType<Map>().map((e) => e.cast<String, dynamic>()).toList()
        : <Map<String, dynamic>>[];

    final teacherName = teachers.isNotEmpty
        ? (teachers.first['fullName']?.toString() ?? '').trim()
        : '';

    final subjectName = (json['name'] ?? '').toString().trim();
    final code = (json['code'] ?? '').toString().trim();

    return StudentSubjectModel(
      oid: (json['oid'] ?? '').toString(),
      code: code,
      trackName: code.isNotEmpty ? code : 'GENERAL',
      subjectName: subjectName.isNotEmpty ? subjectName : 'Unnamed Subject',
      professorName: teacherName.isNotEmpty ? teacherName : 'No teacher assigned',
      progressPercentage: 0,
      attendancePercentage: 0,
      assignmentsPercentage: 0,
    );
  }

  /// Maps the /api/my-subjects response schema.
  /// The [oid] is set to [subjectId] so it matches the key used in the
  /// detail repo lookup.
  factory StudentSubjectModel.fromMySubjectsJson(Map<String, dynamic> json) {
    final subjectName = (json['subjectName'] ?? '').toString().trim();
    final teacherName = (json['teacherName'] ?? '').toString().trim();
    final lessonsCount = (json['lessonsCount'] as num?)?.toInt() ?? 0;
    final homeworksCount = (json['homeworksCount'] as num?)?.toInt() ?? 0;

    return StudentSubjectModel(
      oid: (json['subjectId'] ?? '').toString(),
      code: '',
      trackName: 'GENERAL',
      subjectName: subjectName.isNotEmpty ? subjectName : 'Unnamed Subject',
      professorName: teacherName.isNotEmpty ? teacherName : 'No teacher assigned',
      progressPercentage: 0,
      attendancePercentage: 0,
      assignmentsPercentage: lessonsCount > 0
          ? ((homeworksCount / lessonsCount) * 100).round().clamp(0, 100)
          : 0,
    );
  }
}
