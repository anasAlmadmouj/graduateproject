import 'package:graduateproject/models/section/section_model.dart';
import 'package:graduateproject/models/subjects_model/subjects_model.dart';
import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/upload/upload.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);
 String? headDepartmentId = '';
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String universityId,
    required String userTypeId,
    required String departmentId,
  }) async {
    emit(RegisterUserLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterUserSuccessState());
      createUser(
        name: name,
        email: email,
        phone: phone,
        universityId: universityId,
        userId: value.user!.uid,
        departmentId: departmentId,
        userTypeId: userTypeId,
      );
      headDepartmentId = value.user!.uid;
    }).catchError((error) {
      emit(RegisterUserErrorState(error.toString()));
    });
  }   // This function registers a new user by creating an account with the provided name, email, password, phone, universityId, userTypeId, and departmentId.

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String universityId,
    required String userId,
    required String userTypeId,
    required String departmentId,
  }) {
    UsersModel model = UsersModel(
      userId: userId,
      userName: name,
      userEmail: email,
      userTypeId: userTypeId,
      departmentId: departmentId,
    );
    emit(CreateUserLoadingState());
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
  // The 'createUser' function takes the necessary parameters and creates a 'UsersModel' object with the user's information.
// It then sets the document in the 'usersCollection' collection with the userId as the document ID and the user's information as the document data.
  void updateHeadDepartment(
  {
  required String? departmentId,
  required String? departmentHeadId,
}
      ){
    FireStoreStorage.fireStore
        .collection(departmentCollection)
        .doc(departmentId)
        .update({'departmentHeadId': departmentHeadId} )
        .then((value) {
          emit(AddDepartmentSuccessState());
    }).catchError((error){
      emit(AddDepartmentErrorState(error.toString()));
    });
  }
  List<UsersModel> userList = [];
  UsersModel? selectedDropDownUsers = UsersModel(
      userName: ' users',
      userId: '-1',
      departmentId: '-1',
      userTypeId: '-1',
      userEmail: '-1');

  void changeUser({required UsersModel? usersModel}) {
    selectedDropDownUsers = usersModel;
    emit(UserChangeState());
  }
  String? adminId = '';
  List<String?> adminIdList = [];
  void getUsers() {
    emit(GetUserLoadingState());
    FireStoreStorage.fireStore
    .collection(userTypeCollection)
    .where('userTypeName' , isEqualTo: 'Admin')
    .get()
    .then((value) {
      for(var element in value.docs){
        adminIdList.add(UsersModel.fromJson(element.data()).userTypeId);
      }
    }).whenComplete(() {
      FireStoreStorage.fireStore
          .collection(usersCollection)
          .where('userTypeId' , isNotEqualTo: adminIdList.first)
          .get()
          .then((value) {
        for (var element in value.docs) {
          userList.add(UsersModel.fromJson(element.data()));
        }
        emit(GetUserSuccessState());
      });
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  Future<void> createDepartment(
      {required DepartmentModel departmentModel}) async {
    emit(AddDepartmentLoadingState());
    await FireStoreStorage.fireStore
        .collection(departmentCollection)
        .doc(departmentModel.departmentId ?? '')
        .set(departmentModel.toMap())
        .then((value) => emit(AddDepartmentSuccessState()))
        .catchError((error) {
      emit(AddDepartmentErrorState(error.toString()));
    });
  }

  List<String?> checkDepartmentList = [];

  Future<bool> checkIsDepartmentAvailable({
    required String? departmentName,
  }) async {
    await FireStoreStorage.fireStore
        .collection(departmentCollection)
        .get()
        .then((value) {
      for (var element in value.docs) {
        checkDepartmentList
            .add(DepartmentModel
            .fromJson(element.data())
            .departmentName);
      }
      emit(CheckDepartmentAvailableSuccessState());
    }).catchError((error) {
      emit(CheckDepartmentAvailableErrorState(error.toString()));
    });
    for (var element in checkDepartmentList) {
      if (element == departmentName) {
        return false;
      }
    }
    return true;
  }

  Future<void> createSubject({
    required SubjectsModel subjectsModel,
  }) async {
    emit(AddSubjectLoadingState());
    await FireStoreStorage.fireStore
        .collection(subjectsCollection)
        .doc(subjectsModel.subjectId ?? '')
        .set(subjectsModel.toMap())
        .then((value) => emit(AddSubjectSuccessState()))
        .catchError((error) {
      emit(AddSubjectErrorState(error.toString()));
    });
  }  // This function creates a new subject by adding a document to the 'subjectsCollection' collection in Firestore.

  List<String?> checkSubjectList = [];

  Future<bool> checkIsSubjectAvailable({
    required String? subjectNumber,
  }) async {
    await FireStoreStorage.fireStore
        .collection(subjectsCollection)
        .get()
        .then((value) {
      for (var element in value.docs) {
        checkSubjectList
            .add(SubjectsModel.fromJson(element.data()).numberSubject);
      }
      emit(CheckSubjectAvailableSuccessState());
    }).catchError((error) {
      emit(CheckSubjectAvailableErrorState(error.toString()));
    });
    for (var element in checkSubjectList) {
      if (element == subjectNumber) {
        return false;
      }
    }
    return true;
  }

  Future<void> createSubjectsTerm({
    required SubjectTermModel subjectsTermModel,
  }) async {
    emit(AddSubjectLoadingState());
    await FireStoreStorage.fireStore
        .collection(subjectsTermCollection)
        .doc(subjectsTermModel.subjectTermId ?? '')
        .set(subjectsTermModel.toMap())
        .then((value) => emit(AddSubjectSuccessState()))
        .catchError((error) {
      emit(AddSubjectErrorState(error.toString()));
    });
  }

  List<String?> checkSubjectTermList = [];

  Future<bool> checkIsSubjectTermAvailable({
    required String? subjectNumber,
    required String? academicTermId,
  }) async {
    await FireStoreStorage.fireStore
        .collection(subjectsTermCollection)
        .where('academicTermId',isEqualTo: academicTermId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        checkSubjectTermList
            .add(SubjectTermModel.fromJson(element.data()).subjectNumber);
      }
      emit(CheckSubjectTermAvailableSuccessState());
    }).catchError((error) {
      emit(CheckSubjectTermAvailableErrorState(error.toString()));
    });

    for (var element in checkSubjectTermList) {
      if (element == subjectNumber) {

       return false;
      }
    }
    return true;
  }

  Future<void> createSubCategory(
      {required SubCategoryModel subCategoryModel}) async {
    emit(AddSubCategoryLoadingState());
    await FireStoreStorage.fireStore
        .collection(subCategoryCollection)
        .doc(subCategoryModel.subCategoryId ?? '')
        .set(subCategoryModel.toMap())
        .then((value) => emit(AddSubCategorySuccessState()))
        .catchError((error) {
      emit(AddSubCategoryErrorState(error.toString()));
    });
  }
  List<List<String?>> checkSubCategoryList = [];

  Future<bool> checkIsSubCategoryAvailable({
    required String? categoryId,
    required String? subCategoryName,
  }) async {
    await FireStoreStorage.fireStore
        .collection(subCategoryCollection)
        .where('categoryId' , isEqualTo: categoryId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        checkSubCategoryList
            .add(SubCategoryModel.fromJson(element.data()).subCategoryName);
      }
      emit(CheckSubCategoryAvailableSuccessState());
    }).catchError((error) {
      emit(CheckSubCategoryAvailableErrorState(error.toString()));
    });
    for (var element in checkSubCategoryList) {
      if (listEquals(element, [subCategoryName])) {
        return false;
      }
    }
    return true;
  }

  Future<void> createCategory({
    required CategoryModel categoryModel,
  }) async {
    emit(AddCategoryLoadingState());
    await FireStoreStorage.fireStore
        .collection(categoryCollection)
        .doc(categoryModel.categoryId ?? '')
        .set(categoryModel.toMap())
        .then((value) => emit(AddCategorySuccessState()))
        .catchError((error) {
      emit(AddCategoryErrorState(error.toString()));
    });
  }

  List<String?> checkCategoryList = [];

  Future<bool> checkIsCategoryAvailable({
    required String? categoryName,
  }) async {
    await FireStoreStorage.fireStore
        .collection(categoryCollection)
        .get()
        .then((value) {
      for (var element in value.docs) {
        checkCategoryList
            .add(CategoryModel.fromJson(element.data()).categoryName);
      }
      emit(CheckCategoryAvailableSuccessState());
    }).catchError((error) {
      emit(CheckCategoryAvailableErrorState(error.toString()));
    });
    for (var element in checkCategoryList) {
      if (element == categoryName) {
        return false;
      }
    }
    return true;
  }

  int? numberSection = 0;

  Future<void> createSection({required SectionModel sectionModel}) async {
    emit(AddSectionLoadingState());
    await FireStoreStorage.fireStore
        .collection(sectionCollection)
        .doc(sectionModel.sectionId ?? '')
        .set(sectionModel.toMap())
        .then((value) => emit(AddSectionSuccessState()))
        .catchError((error) {
      emit(AddSectionErrorState(error.toString()));
    });
  }

  Future<void> updateSection(
      {required String? sectionId, required String? userId}) async {
    emit(AddSectionLoadingState());
    await FireStoreStorage.fireStore
        .collection(sectionCollection)
        .doc(sectionId)
        .update({'userId': userId})
        .then((value) => emit(AddSectionSuccessState()))
        .catchError((error) {
          emit(AddSectionErrorState(error.toString()));
        });
  }

  DateTime startDateTime = DateTime(-1);
  DateTime endDateTime = DateTime(-1);
  DateTime selectedStart = DateTime(-1);

  Future<void> createAcademicYears(
      {required AcademicYearsModel academicYearsModel}) async {
    emit(AddAcademicYearsLoadingState());
    await FireStoreStorage.fireStore
        .collection(academicYearsCollection)
        .doc(academicYearsModel.academicYearsId ?? '')
        .set(academicYearsModel.toMap())
        .then((value) {
      emit(AddAcademicYearsSuccessState());
    }).catchError((error) {
      emit(AddAcademicYearsErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<List<int>> checkYearList = [];

  Future<bool> checkIsYearAvailable() async {
    await FireStoreStorage.fireStore
        .collection(academicYearsCollection)
        .get()
        .then((value) {
      for (var element in value.docs) {
        checkYearList.add(
            AcademicYearsModel.fromJson(element.data()).academicYearsNumber);
      }
      emit(CheckYearAvailableSuccessState());
    }).catchError((error) {
      emit(CheckYearAvailableErrorState(error.toString()));
    });
    for (var element in checkYearList) {
      if(listEquals(element, [startDateTime.year, endDateTime.year])) {
        return false;
      }
    }
    return true;
  }


  Future<void> createAcademicTerms({
    required AcademicTermsModel academicTermsModel,
  }) async {
    emit(AddAcademicTermsLoadingState());
    await FireStoreStorage.fireStore
        .collection(academicTermsCollection)
        .doc(academicTermsModel.academicTermsId ?? '')
        .set(academicTermsModel.toMap())
        .then((value) {
      emit(AddAcademicTermsSuccessState());
    }).catchError((error) {
      emit(AddAcademicTermsErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<String?> checkTermList = [];

  Future<bool> checkIsTermAvailable({
    required String? academicYearId,
    required String? academicTermName,
  }) async {
    await FireStoreStorage.fireStore
        .collection(academicTermsCollection)
        .where('academicYearsId', isEqualTo: academicYearId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        checkTermList
            .add(AcademicTermsModel.fromJson(element.data()).academicTermsName);
      }
      emit(CheckTermAvailableSuccessState());
    }).catchError((error) {
      emit(CheckTermAvailableErrorState(error.toString()));
    });
    for (var element in checkTermList) {
            if (element == academicTermName) {
        return false;
      }
    }
    return true;
  }

  Future<void> createUserType({required UserTypeModel userTypeModel}) async {
    emit(AddUserTypeLoadingState());
    await FireStoreStorage.fireStore
        .collection(userTypeCollection)
        .doc(userTypeModel.userTypeId ?? '')
        .set(userTypeModel.toMap())
        .then((value) {
      emit(AddUserTypeSuccessState());
    }).catchError((error) {
      emit(AddUserTypeErrorState(error.toString()));
    });
  }



  Future<void> createCoordinatorToSubject({
    required String? subjectTermId,
    required String? subjectCoordinator,
  }) async {
    emit(CreateSubjectCoordinatorLoadingState());
    await FireStoreStorage.fireStore
        .collection(subjectsTermCollection)
        .doc(subjectTermId ?? '')
        .update({'subjectCoordinator': subjectCoordinator}).then((value) {
      emit(CreateSubjectCoordinatorSuccessState());
    }).catchError((error) {
      emit(CreateSubjectCoordinatorErrorState(error.toString()));
      print(error.toString());
    });
  }


  void clearAdminCubit() {
    selectedDropDownUsers = UsersModel(
      userName: ' users',
    );
  }
}
