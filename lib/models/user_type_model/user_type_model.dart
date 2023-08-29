class UserTypeModel {
  String? userTypeId;
  String? userTypeName;


  UserTypeModel({
    this.userTypeId,
    this.userTypeName,
  });

  UserTypeModel.fromJson(Map<String, dynamic> json) {
    userTypeId = json['userTypeId'];
    userTypeName = json['userTypeName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userTypeId': userTypeId,
      'userTypeName': userTypeName,
    };
  }
}
