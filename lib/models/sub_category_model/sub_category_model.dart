class SubCategoryModel {
  String? categoryId;
  String? subCategoryId;
  List<String> subCategoryName;

  SubCategoryModel({
    this.categoryId,
    this.subCategoryId,
    required this.subCategoryName,
  });

  SubCategoryModel.fromJson(Map<String, dynamic> json)
      : categoryId = json['categoryId'],
        subCategoryId = json['subCategoryId'],
        subCategoryName =
        List<String>.from(json['subCategoryName'].map((x) => x));

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'subCategoryName': subCategoryName,
    };
  }
}



// class SubCategoryModel {
//   String? categoryId;
//   String? subCategoryId;
//   List<String> subCategoryName;
//
//
//   SubCategoryModel({
//     this.categoryId,
//     this.subCategoryId,
//     this.subCategoryName,
//   });
//
//   SubCategoryModel.fromJson(Map<String, dynamic> json) {
//     categoryId = json['categoryId'];
//     subCategoryId = json['subCategoryId'];
//     subCategoryName = ['subCategoryName'];
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'categoryId': categoryId,
//       'subCategoryId': subCategoryId,
//       'subCategoryName': subCategoryName,
//     };
//   }
// }
