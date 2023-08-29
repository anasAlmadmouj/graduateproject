class AcademicTermsModel {
  String? academicTermsId;
  String? academicTermsName;
  String? academicYearsId;


  AcademicTermsModel({
    this.academicTermsId,
    this.academicTermsName,
    this.academicYearsId,
  });

  AcademicTermsModel.fromJson(Map<String, dynamic> json) {
    academicTermsId = json['academicTermsId'];
    academicTermsName = json['academicTermsName'];
    academicYearsId = json['academicYearsId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'academicTermsId': academicTermsId,
      'academicTermsName': academicTermsName,
      'academicYearsId': academicYearsId,
    };
  }
}
