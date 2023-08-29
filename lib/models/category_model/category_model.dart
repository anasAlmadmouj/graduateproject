class CategoryModel {
  String? categoryId;
  String? categoryName;
  String? departmentId;


  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.departmentId,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    departmentId = json['departmentId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'departmentId': departmentId,
    };
  }
}
