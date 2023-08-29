class DepartmentModel {
  String? departmentName;
  String? departmentId;
  String? departmentHeadId;


  DepartmentModel({
    this.departmentName,
    this.departmentId,
    this.departmentHeadId,

  });

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    departmentName = json['departmentName'];
    departmentId = json['departmentId'];
    departmentHeadId = json['departmentHeadId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'departmentName': departmentName,
      'departmentId': departmentId,
      'departmentHeadId': departmentHeadId,
    };
  }
}
