class FilesModel {
  String? fileId;
  String? fileName;
  String? yearId;
  String? yearName;
  String? termName;
  String? termId;
  String? departmentId;
  String? categoryId;
  String? subCategoryId;
  String? subjectId;
  String? subjectTermId;
  String? subjectName;
  String? sectionId;
  String? sectionName;
  String? fileUrl;
  String? userId;
  String? subCategoryName;

  FilesModel({
    this.subjectId,
    this.subjectTermId,
    this.subjectName,
    this.yearId,
    this.yearName,
    this.termId,
    this.termName,
    this.sectionId,
    this.sectionName,
    this.departmentId,
    this.categoryId,
    this.subCategoryId,
    this.fileId,
    this.fileName,
    this.fileUrl,
    this.userId,
    this.subCategoryName,
  });

  FilesModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['subjectId'];
    subjectTermId = json['subjectTermId'];
    subjectName = json['subjectName'];
    yearId = json['yearId'];
    yearName = json['yearName'];
    termId = json['termId'];
    termName = json['termName'];
    sectionId = json['sectionId'];
    sectionName = json['sectionName'];
    departmentId = json['departmentId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    fileId = json['fileId'];
    fileName = json['fileName'];
    fileUrl = json['fileUrl'];
    userId = json['userId'];
    subCategoryName = json['subCategoryName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'subjectTermId': subjectTermId,
      'subjectName': subjectName,
      'yearId': yearId,
      'yearName': yearName,
      'termId': termId,
      'termName': termName,
      'sectionId': sectionId,
      'sectionName': sectionName,
      'departmentId': departmentId,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'fileId': fileId,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'userId': userId,
      'subCategoryName': subCategoryName,
    };
  }
}
