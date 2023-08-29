class UsersModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? departmentId;
  String? userTypeId;
  // UserType? userType;

  UsersModel({
    this.userId,
    this.userEmail,
    this.userName,
    this.departmentId,
    this.userTypeId,
    // this.userType,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userEmail = json['userEmail'];
    userName = json['userName'];
    departmentId = json['departmentId'];
    userTypeId = json['userTypeId'];
    // userType = json['userType'] == 'admin'
    //     ? UserType.admin
    //     : json['userTypeId'] == 'user'
    //         ? UserType.user
    //         : UserType.none;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'departmentId': departmentId,
      'userTypeId': userTypeId,
      // 'userType': userType,
    };
  }
}

// enum UserType {
//   admin,
//   user,
//   none,
// }
