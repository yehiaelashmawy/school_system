class UserModel {
  final String userId;
  final String? teacherId;
  final String? studentId;
  final String? parentId;
  final String fullName;
  final String email;
  final int role;
  final String token;
  final String redirectTo;

  UserModel({
    required this.userId,
    this.teacherId,
    this.studentId,
    this.parentId,
    required this.fullName,
    required this.email,
    required this.role,
    required this.token,
    required this.redirectTo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String? ?? '',
      teacherId: json['teacherId'] as String?,
      studentId: json['studentId'] as String?,
      parentId: json['parentId'] as String?,
      fullName: json['fullName'] as String? ?? 'Unknown User',
      email: json['email'] as String? ?? '',
      role: json['role'] as int? ?? 0,
      token: json['token'] as String? ?? '',
      redirectTo: json['redirectTo'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'teacherId': teacherId,
      'studentId': studentId,
      'parentId': parentId,
      'fullName': fullName,
      'email': email,
      'role': role,
      'token': token,
      'redirectTo': redirectTo,
    };
  }
}
