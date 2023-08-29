class SubjectsModel {
  String? subjectId;
  String? subjectName;
  String? numberSubject;
  String? departmentId;


  SubjectsModel({
    this.subjectId,
    this.subjectName,
    this.departmentId,
    this.numberSubject,
  });

  SubjectsModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    departmentId = json['departmentId'];
    numberSubject = json['numberSubject'];
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'subjectName': subjectName,
      'departmentId': departmentId,
      'numberSubject': numberSubject,
    };
  }
}
