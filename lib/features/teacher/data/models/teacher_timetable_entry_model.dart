class TeacherTimetableEntryModel {
  final String time;
  final String subjectName;
  final String teacherName;
  final String room;
  final String className;
  final String classOid;
  final String subjectOid;
  final String day;
  final String startTime;
  final String endTime;
  final int period;

  TeacherTimetableEntryModel({
    required this.time,
    required this.subjectName,
    required this.teacherName,
    required this.room,
    required this.className,
    required this.classOid,
    required this.subjectOid,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.period,
  });

  factory TeacherTimetableEntryModel.fromJson(Map<String, dynamic> json) {
    return TeacherTimetableEntryModel(
      time: (json['time'] ?? '').toString(),
      subjectName: (json['subjectName'] ?? '').toString(),
      teacherName: (json['teacherName'] ?? '').toString(),
      room: (json['room'] ?? '').toString(),
      className: (json['className'] ?? '').toString(),
      classOid: (json['classOid'] ?? '').toString(),
      subjectOid: (json['subjectOid'] ?? '').toString(),
      day: (json['day'] ?? '').toString(),
      startTime: (json['startTime'] ?? '').toString(),
      endTime: (json['endTime'] ?? '').toString(),
      period: (json['period'] is int)
          ? json['period'] as int
          : int.tryParse((json['period'] ?? '0').toString()) ?? 0,
    );
  }
}
