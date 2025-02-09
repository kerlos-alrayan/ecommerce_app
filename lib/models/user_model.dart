class UserModel {
  final bool status;
  final String message;
  final UserData? data;

  UserModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String name;
  final String phone;
  final String email;
  final int id;
  final String image;
  final String token;

  UserData({
    required this.name,
    required this.phone,
    required this.email,
    required this.id,
    required this.image,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      id: json['id'],
      image: json['image'],
      token: json['token'],
    );
  }
}