class ProfileModel {
  final String? fullName;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? department;
  final String? position;
  final String? employeeId;

  ProfileModel({
    this.fullName,
    this.email,
    this.phone,
    this.avatar,
    this.department,
    this.position,
    this.employeeId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      department: json['department'] as String?,
      position: json['position'] as String?,
      employeeId: json['employeeId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'department': department,
      'position': position,
      'employeeId': employeeId,
    };
  }
}
