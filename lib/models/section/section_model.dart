class SectionModel {
  String? sectionId;
  String? sectionName;
  String? subjectId;
  String? userId;

  SectionModel({
    this.sectionId,
    this.sectionName,
    this.subjectId,
    this.userId,
  });

  SectionModel.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    sectionName = json['sectionName'];
    subjectId = json['subjectId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sectionId': sectionId,
      'sectionName': sectionName,
      'subjectId': subjectId,
      'userId': userId,
    };
  }
}
