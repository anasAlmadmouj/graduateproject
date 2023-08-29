abstract class AdminStates{}

class AdminInitialState extends AdminStates{}


class AddDepartmentLoadingState extends AdminStates{}
class AddDepartmentSuccessState extends AdminStates{}
class AddDepartmentErrorState extends AdminStates{
  final String error;
  AddDepartmentErrorState(this.error);
}
class CheckDepartmentAvailableSuccessState extends AdminStates{}
class CheckDepartmentAvailableErrorState extends AdminStates {
  final String error;

  CheckDepartmentAvailableErrorState(this.error);
}


class AddSubjectLoadingState extends AdminStates{}
class AddSubjectSuccessState extends AdminStates{}
class AddSubjectErrorState extends AdminStates{
  final String error;
  AddSubjectErrorState(this.error);
}
class CheckSubjectAvailableSuccessState extends AdminStates{}
class CheckSubjectAvailableErrorState extends AdminStates {
  final String error;

  CheckSubjectAvailableErrorState(this.error);
}

class AddSubCategoryLoadingState extends AdminStates{}
class AddSubCategorySuccessState extends AdminStates{}
class AddSubCategoryErrorState extends AdminStates{
  final String error;
  AddSubCategoryErrorState(this.error);
}
class CheckSubCategoryAvailableSuccessState extends AdminStates{}
class CheckSubCategoryAvailableErrorState extends AdminStates {
  final String error;

  CheckSubCategoryAvailableErrorState(this.error);
}

class AddCategoryLoadingState extends AdminStates{}
class AddCategorySuccessState extends AdminStates{}
class AddCategoryErrorState extends AdminStates{
  final String error;
  AddCategoryErrorState(this.error);
}
class CheckCategoryAvailableSuccessState extends AdminStates{}
class CheckCategoryAvailableErrorState extends AdminStates {
  final String error;

  CheckCategoryAvailableErrorState(this.error);
}

class AddSectionLoadingState extends AdminStates{}
class AddSectionSuccessState extends AdminStates{}
class AddSectionErrorState extends AdminStates{
  final String error;
  AddSectionErrorState(this.error);
}
class CheckSectionAvailableSuccessState extends AdminStates{}
class CheckSectionAvailableErrorState extends AdminStates {
  final String error;

  CheckSectionAvailableErrorState(this.error);
}

class AddAcademicYearsLoadingState extends AdminStates{}
class AddAcademicYearsSuccessState extends AdminStates{}
class AddAcademicYearsErrorState extends AdminStates{
  final String error;
  AddAcademicYearsErrorState(this.error);
}
class CheckYearAvailableSuccessState extends AdminStates{}
class CheckYearAvailableErrorState extends AdminStates{
  final String error;
  CheckYearAvailableErrorState(this.error);
}

class AddAcademicTermsLoadingState extends AdminStates{}
class AddAcademicTermsSuccessState extends AdminStates{}
class AddAcademicTermsErrorState extends AdminStates{
  final String error;
  AddAcademicTermsErrorState(this.error);
}
class CheckTermAvailableSuccessState extends AdminStates{}
class CheckTermAvailableErrorState extends AdminStates {
  final String error;

  CheckTermAvailableErrorState(this.error);
}

class AddUserTypeLoadingState extends AdminStates{}
class AddUserTypeSuccessState extends AdminStates{}
class AddUserTypeErrorState extends AdminStates{
  final String error;
  AddUserTypeErrorState(this.error);
}
class CheckUserTypeAvailableSuccessState extends AdminStates{}
class CheckUserTypeAvailableErrorState extends AdminStates {
  final String error;

  CheckUserTypeAvailableErrorState(this.error);
}

class RegisterUserLoadingState extends AdminStates{}
class RegisterUserSuccessState extends AdminStates{}
class RegisterUserErrorState extends AdminStates {
  final String error;
  RegisterUserErrorState(this.error);
}

class CreateUserLoadingState extends AdminStates{}
class CreateUserSuccessState extends AdminStates{}
class CreateUserErrorState extends AdminStates {
  final String error;
  CreateUserErrorState(this.error);
}
class UserChangeState extends AdminStates{}

class GetUserLoadingState extends AdminStates{}
class GetUserSuccessState extends AdminStates{}
class GetUserErrorState extends AdminStates {
  final String error;
  GetUserErrorState(this.error);
}


class CreateSubjectCoordinatorLoadingState extends AdminStates{}
class CreateSubjectCoordinatorSuccessState extends AdminStates{}
class CreateSubjectCoordinatorErrorState extends AdminStates {
  final String error;
  CreateSubjectCoordinatorErrorState(this.error);
}
class SubjectCoordinatorChangeState extends AdminStates{}
class CheckCoordinatorAvailableSuccessState extends AdminStates{}
class CheckCoordinatorAvailableErrorState extends AdminStates {
  final String error;

  CheckCoordinatorAvailableErrorState(this.error);
}

class CheckSubjectCoordinatorLoadingState extends AdminStates{}
class CheckSubjectCoordinatorSuccessState extends AdminStates{}
class CheckSubjectCoordinatorErrorState extends AdminStates {
  final String error;
  CheckSubjectCoordinatorErrorState(this.error);
}
class CheckSubjectTermAvailableSuccessState extends AdminStates{}
class CheckSubjectTermAvailableErrorState extends AdminStates {
  final String error;

  CheckSubjectTermAvailableErrorState(this.error);
}