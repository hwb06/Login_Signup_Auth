class UserModel {
  final String uId;
  final String username;
  final String email;
  final String password;
  final String userDeviceToken;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;

  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.password,
    required this.userDeviceToken,
    required this.isAdmin,
    required this.isActive,
    required this.createdOn,
  });

  //Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': password,
      'userDeviceToken': userDeviceToken,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdOn': createdOn,
    };
  }

//Create a UserModel instance from a JSON map
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      userDeviceToken: json['userDeviceToken'],
      isAdmin: json['isAdmin'],
      isActive: json['isActive'],
      createdOn: json['createdOn'].toString(),
    );
  }
}
