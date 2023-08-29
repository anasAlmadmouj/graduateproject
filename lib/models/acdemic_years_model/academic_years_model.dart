class AcademicYearsModel {
  String? academicYearsId;
  List<int> academicYearsNumber;



  AcademicYearsModel({
    this.academicYearsId,
    required this.academicYearsNumber,
  });

  AcademicYearsModel.fromJson(Map<String, dynamic> json)
      : academicYearsId = json['academicYearsId'],
        academicYearsNumber =
        List<int>.from(json['academicYearsNumber'].map((x) => x));


  Map<String, dynamic> toMap() {
    return {
      'academicYearsId': academicYearsId,
      'academicYearsNumber': academicYearsNumber,
    };
  }
}
