class AddExamRequest {
  final String name;
  final String description;
  final String type;
  final String subjectOid;
  final String classOid;
  final String date;
  final String startTime;
  final String duration;
  final int maxScore;
  final int passingScore;
  final String room;
  final String instructions;
  final List<Map<String, dynamic>> materials;

  AddExamRequest({
    required this.name,
    required this.description,
    required this.type,
    required this.subjectOid,
    required this.classOid,
    required this.date,
    required this.startTime,
    required this.duration,
    required this.maxScore,
    required this.passingScore,
    required this.room,
    required this.instructions,
    required this.materials,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "type": type,
      "subjectOid": subjectOid,
      "classOid": classOid,
      "date": date,
      "startTime": startTime,
      "duration": duration,
      "maxScore": maxScore,
      "passingScore": passingScore,
      "room": room,
      "instructions": instructions,
      "materials": materials,
    };
  }
}
