import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/app_layout/app_cubit/app_cubit_imports.dart';
import 'package:graduateproject/app_layout/app_cubit/app_states.dart';
import 'package:graduateproject/models/department/department_model.dart';
import 'package:graduateproject/models/file_model/file_model.dart';
import 'package:graduateproject/models/sub_category_model/sub_category_model.dart';
import 'package:graduateproject/models/subjects_model/subjects_model.dart';
import 'package:graduateproject/models/users_model/users_model.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  String? validateDropDown(var value, String? message) {
    if (value == null) {
      return '$message';
    }
    return null;
  }

  String? validateFormField(var value, String? message) {
    if (value.isEmpty || value == null) {
      return '$message';
    }
    return null;
  }

  String? departmentLayOutId;


  List<DepartmentModel?> departmentsList = [];
  DepartmentModel? selectedDepartmentDialog = DepartmentModel(
    departmentName: 'Department',
    departmentHeadId: '-1',
    departmentId: '-1',
  );

  void changeDepartment({required DepartmentModel? departmentModel}) {
    selectedDepartmentDialog = departmentModel;
    emit(DepartmentChangeState());
  }

  Future<void> getDepartment() async{
    await FireStoreStorage.fireStore
        .collection(departmentCollection)
        .orderBy('departmentName')
        .get()
        .then((value) {
      for (var element in value.docs) {
        departmentsList.add(DepartmentModel.fromJson(element.data()));
      }
    }).catchError((error) {});
  }

  List<SubjectTermModel> subjectTermList = [];
  SubjectTermModel? selectedDropDownSubjectTerm = SubjectTermModel(
    academicTermId: '-1',
    subjectName: 'subject',
    subjectId: '-1',
    subjectTermId: '-1',
    departmentId: '-1',
    subjectCoordinator: '',
    subjectNumber: '-1',
  );

  void changeSubjectTerm({required SubjectTermModel? subjectModel}) {
    selectedDropDownSubjectTerm = subjectModel;
    emit(SubjectByTermChangeState());
  }

  void getSubjectsTerms(
      {
        required BuildContext? context,
        required String? academicTermId,
        required String? departmentId,
      }) {
    FireStoreStorage.fireStore
        .collection(subjectsTermCollection)
        .where('departmentId' , isEqualTo: departmentId)
        .where('academicTermId' , isEqualTo: academicTermId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        subjectTermList.add(SubjectTermModel.fromJson(element.data()));
      }
      emit(GetSubjectByTermSuccessState());
    }).catchError((error) {
      emit(GetSubjectByTermErrorState(error.toString()));
    });
  } // This function retrieves the subjects' terms for a specific academic term and department from Firestore.

  List<UserTypeModel> userTypeList = [];
  UserTypeModel? selectedDropDownUserType = UserTypeModel(
    userTypeName: 'User Type',
    userTypeId: '-1',
  );

  void changeUserType({required UserTypeModel? userTypeModel}) {
    selectedDropDownUserType = userTypeModel;
    emit(UserTypeChangeState());
  }

  Future<void> getUserType() async{
    await FireStoreStorage.fireStore
        .collection(userTypeCollection)
        .orderBy('userTypeName')
        .get()
        .then((value) {
      for (var element in value.docs) {
        userTypeList.add(UserTypeModel.fromJson(element.data()));
      }
    }).catchError((error) {});
  }

  List<SubCategoryModel> subCategoryList = [];
  SubCategoryModel? selectedDropDownSubCategory = SubCategoryModel(
    subCategoryName: ['Sub Category'],
    subCategoryId: '-1',
    categoryId: '-1',
  );

  void changeSubCategory({required SubCategoryModel? subCategoryModel}) {
    selectedDropDownSubCategory = subCategoryModel;
    emit(UserTypeChangeState());
  }

  void getSubCategory({
    required BuildContext context,
    required String? categoryId,
  }) {
    emit(GetSubCategoryLoadingState());
    FireStoreStorage.fireStore
        .collection(subCategoryCollection)
        .where('categoryId', isEqualTo: categoryId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        subCategoryList.add(SubCategoryModel.fromJson(element.data()));
      }
      emit(GetSubCategorySuccessState());
    }).catchError((error) {
      emit(GetSubCategoryErrorState(error));
    });
  }

  List<CategoryModel> categoryList = [];
  CategoryModel? selectedDropDownCategory = CategoryModel(
    categoryName: 'Category',
    categoryId: '-1',
    departmentId: '-1',
  );

  void changeCategory({required CategoryModel? categoryModel}) {
    selectedDropDownCategory = categoryModel;
    emit(ChangeCategorySuccessState());
  }

  Future<void> getCategory() async{
    emit(GetCategoryLoadingState());
    await FireStoreStorage.fireStore
        .collection(categoryCollection)
        .get()
        .then((value) {
      for (var element in value.docs) {
        categoryList.add(CategoryModel.fromJson(element.data()));
      }
      emit(GetCategorySuccessState());
    }).catchError((error) {
      emit(GetCategoryErrorState(error));
    });
  }

  List<AcademicYearsModel> academicYearsList = [];
  AcademicYearsModel? selectedDropDownAcademicYears = AcademicYearsModel(
    academicYearsNumber: [-1],
    academicYearsId: '-1',
  );

  void changeAcademicYears({required AcademicYearsModel? academicYearsModel}) {
    selectedDropDownAcademicYears = academicYearsModel;
    emit(AcademicYearsChangeState());
  }

  Future<void> getAcademicYears() async {
    emit(AcademicTermsLoadingState());
    await FireStoreStorage.fireStore
        .collection(academicYearsCollection)
        .orderBy('academicYearsNumber')
        .get()
        .then((value) {
      for (var element in value.docs) {
        academicYearsList.add(AcademicYearsModel.fromJson(element.data()));
      }
      emit(AcademicTermsLoadingState());
    }).catchError((error) {
      emit(AcademicTermsLoadingState());

    });
  }

  List<AcademicTermsModel> academicTermsList = [];
  AcademicTermsModel? selectedDropDownAcademicTerms = AcademicTermsModel(
    academicTermsName: 'academic term',
    academicYearsId: '-1',
    academicTermsId: '-1',
  );

  void changeAcademicTerms({required AcademicTermsModel? academicTermsModel}) {
    selectedDropDownAcademicTerms = academicTermsModel;
    emit(AcademicTermsChangeState());
  }

  void getAcademicTerms(
      {required BuildContext context, required String? academicYearsId}) {
    emit(GetAcademicTermsLoadingState());
    FireStoreStorage.fireStore
        .collection(academicTermsCollection)
        .orderBy('academicTermsName')
        .where('academicYearsId', isEqualTo: academicYearsId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        academicTermsList.add(AcademicTermsModel.fromJson(element.data()));
      }
      emit(GetAcademicTermsSuccessState());
    }).catchError((error) {
      emit(GetAcademicTermsErrorState(error.toString()));
    });
  }

  List<SectionModel> sectionList = [];
  SectionModel? selectedDropDownSection = SectionModel(
    sectionName: sectionCollection,
    subjectId: '-1',
    userId: '-1',
    sectionId: '-1',
  );

  void changeSection({required SectionModel? sectionModel}) {
    selectedDropDownSection = sectionModel;
    emit(SectionChangeState());
  }

  Future<void> getSection(
      {required BuildContext context, required String? subjectId}) async {
    final user = FirebaseAuth.instance.currentUser;
    emit(GetSectionLoadingState());
    if (user != null && CacheHelper.getData(key: spUserType) == userTypeAdmin) {
      FireStoreStorage.fireStore
          .collection(sectionCollection)
          .where('subjectId', isEqualTo: subjectId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          sectionList.add(SectionModel.fromJson(element.data()));
        }
        emit(GetSectionSuccessState());
      }).catchError((error) {
        emit(GetSectionErrorState(error.toString()));
      });
    }
    else if (user != null &&
        (CacheHelper.getData(key: spUserType) == userTypeUser ||
            CacheHelper.getData(key: spUserType) == userTypeHeadDepartment)) {
      FireStoreStorage.fireStore
          .collection(subjectsTermCollection)
          .where('subjectTermId' , isEqualTo: subjectId)
          .where('subjectCoordinator' , isEqualTo: user.uid)
          .get()
          .then((value) {
        if(value.docs.isNotEmpty){
            FireStoreStorage.fireStore
                .collection(sectionCollection)
                .where('subjectId', isEqualTo: subjectId)
                .get()
                .then((value) {
              for (var element in value.docs) {
                sectionList.add(SectionModel.fromJson(element.data()));
              }
              emit(GetSectionSuccessState());
            });
        }
        else{
          FireStoreStorage.fireStore
              .collection(sectionCollection)
              .where('subjectId', isEqualTo: subjectId)
              .where('userId', isEqualTo: user.uid)
              .get()
              .then((value) {
            for (var element in value.docs) {
              sectionList.add(SectionModel.fromJson(element.data()));
            }
            emit(GetSectionSuccessState());
          });
        }
      }).catchError((error) {
        emit(GetSectionErrorState(error.toString()));
      });
    }
  }

  List<FilesModel> filesList = [];

  void getFiles({
    required String? yearId,
    required String? termId,
    required String? departmentId,
    required String? categoryId,
    required String? subCategoryId,
    required String? subjectId,
  }) {
    emit(GetFilesLoadingState());
    FireStoreStorage.fireStore
        .collection(fileCollection)
        .where('yearId', isEqualTo: yearId)
        .where('termId', isEqualTo: termId)
        .where('departmentId', isEqualTo: departmentId)
        .where('categoryId', isEqualTo: categoryId)
        .where('subCategoryId', isEqualTo: subCategoryId)
        .where('subjectId', isEqualTo: subjectId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        filesList.add(FilesModel.fromJson(element.data()));
      }
      emit(GetFilesSuccessState());
    }).catchError((error) {
      emit(GetFilesErrorState(error.toString()));
    });
  }

  void getUserFiles({
    required String? yearId,
    required String? termId,
    required String? departmentId,
    required String? categoryId,
    required String? subjectId,
    required String? sectionId,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      emit(GetFilesLoadingState());
      FireStoreStorage.fireStore
          .collection(fileCollection)
          // .orderBy('yearName')
          .where('yearId', isEqualTo: yearId)
          .where('termId', isEqualTo: termId)
          .where('departmentId', isEqualTo: departmentId)
          .where('categoryId', isEqualTo: categoryId)
          // .where('subCategoryId', isEqualTo: subCategoryId)
          .where('subjectId', isEqualTo: subjectId)
          // .where('userId', isEqualTo: user.uid)
          .where('sectionId', isEqualTo: sectionId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          filesList.add(FilesModel.fromJson(element.data()));
        }
        emit(GetFilesSuccessState());
        print('user ......... GetFilesSuccessState()');
        print('cubit.......${filesList.isEmpty}');
      }).whenComplete(() {
        FireStoreStorage.fireStore
            .collection(fileCollection)
        // .orderBy('yearName')
            .where('yearId', isEqualTo: yearId)
            .where('termId', isEqualTo: termId)
            .where('departmentId', isEqualTo: departmentId)
            .where('categoryId', isEqualTo: categoryId)
            .where('subjectId', isEqualTo: subjectId)
            .where('subCategoryName', isEqualTo: 'تنفيذ وتقييم اداء الطلبة')
            .get()
            .then((value) {
          for (var element in value.docs) {
            filesList.add(FilesModel.fromJson(element.data()));
            print('هاي ثاني وحدة ${filesList.isEmpty}');
          }
          emit(GetCordinatorSubCategoySuccessState());
        });
      }).catchError((error) {
        emit(GetSubjectByTermErrorState(error.toString()));
        print(error.toString());
      });
    }
  }  // This function retrieves files based on various filters such as yearId, termId, departmentId, categoryId, subCategoryId, and subjectId from Firestore.


  List<FilesModel> filesRangeList = [];
  DateTime startRangeDateTime = DateTime(-1);
  DateTime endRangeDateTime = DateTime(-1);
  List<AcademicYearsModel> yearsIdList = [];
  List<AcademicYearsModel> uniqueYearsIdList = [];
  bool isSelectRange = false;
  void getFilesRange({
    required String? departmentId,
    required String? categoryId,
    required String? subCategoryId,
    required String? subjectId,
    required int? startYear,
    required int? endYear,
  }) {
    emit(GetFilesLoadingState());
    FireStoreStorage.fireStore
        .collection(academicYearsCollection)
        .where('academicYearsNumber', isGreaterThanOrEqualTo: [startYear] , isLessThanOrEqualTo: [(endYear!+1)]
    )
        .get()
         .then((value) {
           for(var element in value.docs){
             yearsIdList.add(AcademicYearsModel.fromJson(element.data()));
           }
           yearsIdList = yearsIdList.toSet().toList();
           var seen = <String?>{};
           uniqueYearsIdList = yearsIdList
               .where((year) => seen.add(year.academicYearsId))
               .toList();

    }).whenComplete(() {
      for(int i = 0 ; i<uniqueYearsIdList.length ; i++) {
        print(uniqueYearsIdList.length);
        FireStoreStorage.fireStore
            .collection(fileCollection)
            .where('yearId', isEqualTo: uniqueYearsIdList[i].academicYearsId)
            .where('departmentId', isEqualTo: departmentId)
            .where('categoryId', isEqualTo: categoryId)
            .where('subCategoryId', isEqualTo: subCategoryId)
            .where('subjectId', isEqualTo: subjectId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            filesList.add(FilesModel.fromJson(element.data()));
          }
          emit(GetFilesSuccessState());
        });
      }
    })
    .catchError((error) {
      emit(GetFilesErrorState(error.toString()));
    });
  }  // This function retrieves files within a specified range of academic years, along with other filters such as departmentId, categoryId, subCategoryId, and subjectId, from Firestore.

  List<SubjectTermModel> subjectList = [];
  List<SubjectTermModel> uniqueSubjectList = [];
  List<String> sectionIdList = [];
  List<SubjectTermModel> headDepartmentSubjectList = [];

  SubjectTermModel? selectedDropDownSubject = SubjectTermModel(
    academicTermId: '-1',
    subjectCoordinator: '-1',
    subjectId: '-1',
    subjectTermId: '-1',
  );

     void changeSubject({required SubjectTermModel? subjectModel}) {
    selectedDropDownSubject = subjectModel;
    emit(SubjectChangeState());
  }

  Future<void> getSubject({
    required BuildContext context,
    required String? academicTermId,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(GetSubjectLoadingState());
      await FireStoreStorage.fireStore
          .collection(sectionCollection)
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((value) {
        for (var element in value.docs) {
          sectionIdList
              .add(SectionModel.fromJson(element.data()).subjectId.toString());
        }
        emit(GetSectionIdListSuccessState());
      }).whenComplete(() {
        for (var element in sectionIdList) {
          FireStoreStorage.fireStore
              .collection(subjectsTermCollection)
              .where('subjectTermId', isEqualTo: element)
              .where('academicTermId' , isEqualTo: academicTermId)
              .get()
              .then((value) {
            for (var element in value.docs) {
              subjectList.add(SubjectTermModel.fromJson(element.data()));
            }
            subjectList = subjectList.toSet().toList();
            var seen = <String?>{};
            uniqueSubjectList = subjectList
                .where((subject) => seen.add(subject.subjectName))
                .toList();
              });
        }
        emit(GetSubjectSuccessState());
      });
    }
  }

  List<SubjectsModel> subjectsList = [];
  SubjectsModel? selectedSubjects = SubjectsModel(
    departmentId: '-1',
    subjectName: 'Subject',
    subjectId: '-1',
    numberSubject: '-1',
  );

  void changeSubjects({required SubjectsModel? subjectsModel}) {
    selectedSubjects = subjectsModel;
    emit(SubjectByTermChangeState());
  }
  Future<void> getSubjects({
    required BuildContext context,
    required String? departmentId,
  })async{
    await FireStoreStorage.fireStore
        .collection(subjectsCollection)
        // .orderBy('subjectName')
        .where('departmentId' , isEqualTo: departmentId)
        .get()
        .then((value) {
          for(var element in value.docs){
            subjectsList.add(SubjectsModel.fromJson(element.data()));
          }
    }).catchError((error){
      print(error);
    });
  }

  List<String> userSectionList = [];
  List<UsersModel> userSubjectList = [];
  List<UsersModel> uniqueUserSubjectList = [];
  UsersModel? selectedDropDownUserSubject = UsersModel(
    userName: 'Coordinator',
    userId: '-1',
    userTypeId: '-1',
    departmentId: '-1',
    userEmail: '-1',
  );

  void changeUserSubject({required UsersModel? usersModel}) {
    selectedDropDownUserSubject = usersModel;
    emit(ChangeUserSubjectState());
  }

  void getSubjectUser({
    required String? subjectId,
  }) {
    emit(GetUserSubjectLoadingState());
    FireStoreStorage.fireStore
        .collection(sectionCollection)
        .where('subjectId', isEqualTo: subjectId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        userSectionList
            .add(SectionModel.fromJson(element.data()).userId.toString());
        emit(GetUserSectionSuccessState());
      }
    }).whenComplete(() {
      for (var element in userSectionList) {
        FireStoreStorage.fireStore
            .collection(usersCollection)
            .where('userId', isEqualTo: element)
            .get()
            .then((value) {
          for (var element in value.docs) {
            userSubjectList.add(UsersModel.fromJson(element.data()));
          }
          userSubjectList = userSubjectList.toSet().toList();
          var seen = <String?>{};
          uniqueUserSubjectList = userSubjectList
              .where((userSubject) => seen.add(userSubject.userName))
              .toList();
        });
      }
      emit(GetUserSubjectSuccessState());
    }).catchError((error) {
      emit(GetUserSubjectErrorState(error.toString()));
    });
  }

  List<SubjectTermModel> coordinatorIdList = [];
  List<SubCategoryModel> subCategoryIsCoordinatorList = [];
  SubCategoryModel? selectedSubCategoryCoordinator = SubCategoryModel(
      categoryId: '-1', subCategoryId: '-1', subCategoryName: ['Sub category']);
  void changeSubCategoryCoordinator(
      {required SubCategoryModel? subCategoryModel}) {
    selectedSubCategoryCoordinator = subCategoryModel;
    emit(ChangeCoordinatorIdSuccessState());
  }

  void getSubCategoryIsCoordinator({
    required String? subjectId,
    required String? categoryId,
    required BuildContext context,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(GetCoordinatorIdLoadingState());
      await FireStoreStorage.fireStore
          .collection(subjectsTermCollection)
          .where('subjectTermId', isEqualTo: subjectId)
          .where('subjectCoordinator' , isEqualTo: user.uid)
          .get()
          .then((value) {
        for (var element in value.docs) {
          coordinatorIdList
              .add(SubjectTermModel.fromJson(element.data()));
        }
        emit(GetCoordinatorIdSuccessState());
      }).whenComplete(() {
        if (coordinatorIdList.isNotEmpty) {
          if (coordinatorIdList.single.subjectCoordinator.toString() == user.uid) {
            FireStoreStorage.fireStore
                .collection(subCategoryCollection)
                .where('categoryId', isEqualTo: categoryId)
                .get()
                .then((value) {
              for (var element in value.docs) {
                subCategoryIsCoordinatorList
                    .add(SubCategoryModel.fromJson(element.data()));
              }
            });
          }
        } else {
          FireStoreStorage.fireStore
              .collection(subCategoryCollection)
              .where('categoryId', isEqualTo: categoryId)
              .where('subCategoryName', arrayContainsAny: [
                'نموذج الحضور والغياب',
                'نموذج توثيق التقدم للإمتحان',
                'نموذج حرمان',
                'نموذج الأسألة',
                'نموذج الإجابة',
              ])
              .get()
              .then((value) {
                for (var element in value.docs) {
                  subCategoryIsCoordinatorList
                      .add(SubCategoryModel.fromJson(element.data()));
                }
                emit(GetSubCategorySuccessState());
              });
        }
      });
    }
  }

  Future<void> deleteFile({
  required String? fileId,
})async{
    await FireStoreStorage.fireStore
        .collection(fileCollection)
        .doc(fileId)
        .delete()
        .then((value) {
          emit(DeleteFilesSuccessState());
    }).catchError((error) {
      emit(DeleteFilesErrorState(error.toString()));
    });
  }   // This function deletes a file from Firestore based on the provided fileId.

  void clearDialog() {

    selectedSubCategoryCoordinator = SubCategoryModel(
        categoryId: '-1', subCategoryId: '-1', subCategoryName: ['Sub category']);
    selectedDropDownAcademicYears = AcademicYearsModel(
      academicYearsNumber: [],
      academicYearsId: '-1',
    );
    selectedDropDownAcademicTerms = AcademicTermsModel(
      academicTermsName: 'academic term',
      academicYearsId: '-1',
      academicTermsId: '-1',
    );
    academicTermsList.clear();
    selectedDepartmentDialog = DepartmentModel(
      departmentName: 'Department',
      departmentHeadId: '-1',
      departmentId: '-1',
    );
    selectedDropDownCategory = CategoryModel(
      categoryName: 'Category',
      categoryId: '-1',
      departmentId: '-1',
    );
    selectedDropDownSubCategory = SubCategoryModel(
      subCategoryName: ['Sub Category'],
      subCategoryId: '-1',
      categoryId: '-1',
    );
    subjectList.clear();
    selectedDropDownSubjectTerm = SubjectTermModel(
      academicTermId: '-1',
      subjectName: 'subject',
      subjectId: '-1',
      subjectTermId: '-1',
      departmentId: '-1',
      subjectCoordinator: '',
      subjectNumber: '-1',
    );
    selectedDropDownSubject = SubjectTermModel(
      academicTermId: '-1',
      subjectCoordinator: '-1',
      subjectId: '',
      subjectTermId: '-1',
    );
    uniqueSubjectList.clear();
    subjectsList.clear();
    sectionIdList.clear();
    selectedDropDownSection = SectionModel(
      sectionName: sectionCollection,
      subjectId: '-1',
      userId: '-1',
      sectionId: '-1',
    );
    sectionList.clear();
    emit(ChangeYearClearSuccessState());
  }

  void changeAcademicYearClear() {
    selectedDropDownAcademicTerms = AcademicTermsModel(
      academicTermsName: 'academic term',
      academicYearsId: '-1',
      academicTermsId: '-1',
    );
    academicTermsList.clear();
    selectedDepartmentDialog = DepartmentModel(
      departmentName: 'Department',
      departmentHeadId: '-1',
      departmentId: '-1',
    );
    selectedDropDownCategory = CategoryModel(
      categoryName: 'Category',
      categoryId: '-1',
      departmentId: '-1',
    );
    selectedDropDownSubCategory = SubCategoryModel(
      subCategoryName: ['Sub Category'],
      subCategoryId: '-1',
      categoryId: '-1',
    );
    subjectList.clear();
    selectedDropDownSubjectTerm = SubjectTermModel(
      academicTermId: '-1',
      subjectName: 'subject',
      subjectId: '-1',
      subjectTermId: '-1',
      departmentId: '-1',
      subjectCoordinator: '',
      subjectNumber: '-1',
    );
    selectedDropDownSubject = SubjectTermModel(
      academicTermId: '-1',
      subjectCoordinator: '-1',
      subjectId: '',
      subjectTermId: '-1',
    );
    uniqueSubjectList.clear();
    selectedDropDownSection = SectionModel(
      sectionName: sectionCollection,
      subjectId: '-1',
      userId: '-1',
      sectionId: '-1',
    );
    sectionList.clear();
    emit(ChangeYearClearSuccessState());
  }

  void changeAcademicTermClear() {
    selectedDepartmentDialog = DepartmentModel(
      departmentName: 'Department',
      departmentHeadId: '-1',
      departmentId: '-1',
    );
    selectedDropDownCategory = CategoryModel(
      categoryName: 'Category',
      categoryId: '-1',
      departmentId: '-1',
    );
    selectedDropDownSubCategory = SubCategoryModel(
      subCategoryName: ['Sub Category'],
      subCategoryId: '-1',
      categoryId: '-1',
    );
    subCategoryList.clear();
    selectedDropDownSubjectTerm =SubjectTermModel(
      academicTermId: '-1',
      subjectName: 'subject',
      subjectId: '-1',
      subjectTermId: '-1',
      departmentId: '-1',
      subjectCoordinator: '',
      subjectNumber: '-1',
    );
    selectedDropDownSubject = SubjectTermModel(
      academicTermId: '-1',
      subjectCoordinator: '-1',
      subjectId: '',
      subjectTermId: '-1',
    );
    uniqueSubjectList.clear();
    selectedDropDownSection = SectionModel(
      sectionName: sectionCollection,
      subjectId: '-1',
      userId: '-1',
      sectionId: '-1',
    );
    sectionList.clear();
    emit(ChangeTermClearSuccessState());
  }

  void changeDepartmentClear() {
    selectedDropDownCategory = CategoryModel(
      categoryName: 'Category',
      categoryId: '-1',
      departmentId: '-1',
    );
    selectedDropDownSubCategory = SubCategoryModel(
      subCategoryName: ['Sub Category'],
      subCategoryId: '-1',
      categoryId: '-1',
    );
    subCategoryList.clear();
    selectedDropDownSubjectTerm = SubjectTermModel(
      academicTermId: '-1',
      subjectName: 'subject',
      subjectId: '-1',
      subjectTermId: '-1',
      departmentId: '-1',
      subjectCoordinator: '',
      subjectNumber: '-1',
    );
    selectedDropDownSubject = SubjectTermModel(
      academicTermId: '-1',
      subjectCoordinator: '-1',
      subjectId: '',
      subjectTermId: '-1',
    );
    uniqueSubjectList.clear();
    selectedDropDownSection = SectionModel(
      sectionName: sectionCollection,
      subjectId: '-1',
      userId: '-1',
      sectionId: '-1',
    );
    sectionList.clear();
    emit(ChangeDepartmentClearSuccessState());
  }

  void changeCategoryClear() {
    selectedSubCategoryCoordinator = SubCategoryModel(
        categoryId: '-1',
        subCategoryId: '-1',
        subCategoryName: ['Sub category']);
    selectedDropDownSubCategory = SubCategoryModel(
      subCategoryName: ['Sub Category'],
      subCategoryId: '-1',
      categoryId: '-1',
    );
    subCategoryList.clear();
    selectedDropDownSubjectTerm = SubjectTermModel(
      academicTermId: '-1',
      subjectName: 'subject',
      subjectId: '-1',
      subjectTermId: '-1',
      departmentId: '-1',
      subjectCoordinator: '',
      subjectNumber: '-1',
    );
    selectedDropDownSubject = SubjectTermModel(
      academicTermId: '-1',
      subjectCoordinator: '-1',
      subjectId: '',
      subjectTermId: '-1',
    );
    uniqueSubjectList.clear();
    selectedDropDownSection = SectionModel(
      sectionName: sectionCollection,
      subjectId: '-1',
      userId: '-1',
      sectionId: '-1',
    );
    sectionList.clear();
    emit(ChangeCategorySuccessState());
  }

  void changeSubjectClear() {
    selectedDropDownSection = SectionModel(
      sectionName: sectionCollection,
      subjectId: '-1',
      userId: '-1',
      sectionId: '-1',
    );
    sectionList.clear();
    selectedSubCategoryCoordinator = SubCategoryModel(
        categoryId: '-1', subCategoryId: '-1', subCategoryName: ['Sub category']);
    emit(ChangeSubjectClearSuccessState());
  }
}
