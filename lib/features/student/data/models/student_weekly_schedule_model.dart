class StudentWeeklyScheduleData {
  final List<StudentCalendarDay> calendar;
  final List<StudentWeeklyTimetableDay> weeklyTimetable;

  StudentWeeklyScheduleData({
    required this.calendar,
    required this.weeklyTimetable,
  });

  factory StudentWeeklyScheduleData.fromJson(Map<String, dynamic> json) {
    return StudentWeeklyScheduleData(
      calendar: (json['calendar'] as List?)
              ?.map((e) => StudentCalendarDay.fromJson(e))
              .toList() ??
          [],
      weeklyTimetable: (json['weeklyTimetable'] as List?)
              ?.map((e) => StudentWeeklyTimetableDay.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class StudentCalendarDay {
  final String dayName;
  final int dayNumber;
  final int classesCount;

  StudentCalendarDay({
    required this.dayName,
    required this.dayNumber,
    required this.classesCount,
  });

  factory StudentCalendarDay.fromJson(Map<String, dynamic> json) {
    return StudentCalendarDay(
      dayName: json['dayName'] ?? '',
      dayNumber: json['dayNumber'] ?? 0,
      classesCount: json['classesCount'] ?? 0,
    );
  }
}

class StudentWeeklyTimetableDay {
  final String dayName;
  final String date;
  final List<StudentLesson> lessons;

  StudentWeeklyTimetableDay({
    required this.dayName,
    required this.date,
    required this.lessons,
  });

  factory StudentWeeklyTimetableDay.fromJson(Map<String, dynamic> json) {
    return StudentWeeklyTimetableDay(
      dayName: json['dayName'] ?? '',
      date: json['date'] ?? '',
      lessons: (json['lessons'] as List?)
              ?.map((e) => StudentLesson.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class StudentLesson {
  final String time;
  final String subjectName;
  final String teacherName;
  final String room;

  StudentLesson({
    required this.time,
    required this.subjectName,
    required this.teacherName,
    required this.room,
  });

  factory StudentLesson.fromJson(Map<String, dynamic> json) {
    return StudentLesson(
      time: json['time'] ?? '',
      subjectName: json['subjectName'] ?? '',
      teacherName: json['teacherName'] ?? '',
      room: json['room'] ?? '',
    );
  }
}
