class SubjectTermModel {
  String? subjectTermId;
  String? subjectId;
  String? subjectName;
  String? subjectNumber;
  String? departmentId;
  String? academicTermId;
  String? subjectCoordinator;



  SubjectTermModel({
    this.subjectId,
    this.subjectTermId,
    this.subjectName,
    this.subjectNumber,
    this.departmentId,
    this.academicTermId,
    this.subjectCoordinator,
  });

  SubjectTermModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['subjectId'];
    subjectTermId = json['subjectTermId'];
    subjectName = json['subjectName'];
    subjectNumber = json['subjectNumber'];
    departmentId = json['departmentId'];
    subjectCoordinator = json['subjectCoordinator'];
    academicTermId = json['academicTermId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'subjectTermId': subjectTermId,
      'subjectName': subjectName,
      'subjectNumber': subjectNumber,
      'departmentId': departmentId,
      'academicTermId': academicTermId,
      'subjectCoordinator': subjectCoordinator,
    };
  }
}
