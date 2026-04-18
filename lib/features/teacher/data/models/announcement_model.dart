class AnnouncementModel {
  final String oid;
  final String title;
  final String contentEn;
  final String contentAr;
  final String priority;
  final String timeAgo;

  AnnouncementModel({
    required this.oid,
    required this.title,
    required this.contentEn,
    required this.contentAr,
    required this.priority,
    required this.timeAgo,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      oid: json['oid'] as String? ?? '',
      title: json['title'] as String? ?? '',
      contentEn: json['contentEn'] as String? ?? '',
      contentAr: json['contentAr'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      timeAgo: json['timeAgo'] as String? ?? '',
    );
  }
}
