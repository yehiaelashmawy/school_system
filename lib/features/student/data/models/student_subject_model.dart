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
}
