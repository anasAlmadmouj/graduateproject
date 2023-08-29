abstract class AppStates{}

class AppInitialState extends AppStates{}

class ChangeYearClearSuccessState extends AppStates{}
class ChangeTermClearSuccessState extends AppStates{}
class ChangeDepartmentClearSuccessState extends AppStates{}
class ChangeCategoryClearSuccessState extends AppStates{}
class ChangeSubjectClearSuccessState extends AppStates{}
class ChangeSectionClearSuccessState extends AppStates{}

class GetSubjectByTermSuccessState extends AppStates{}
class GetSubjectByTermErrorState extends AppStates{
  final String error;
  GetSubjectByTermErrorState(this.error);
}
class SubjectByTermChangeState extends AppStates{}
class GetSelectedAcademicTermIdSuccessState extends AppStates{}


class DepartmentChangeState extends AppStates{}
class GetDepartmentLoadingState extends AppStates{}
class GetDepartmentSuccessState extends AppStates{}
class GetDepartmentErrorState extends AppStates{
  final String error;
  GetDepartmentErrorState(this.error);
}


class GetSectionLoadingState extends AppStates{}
class GetSectionSuccessState extends AppStates{}
class GetSectionErrorState extends AppStates{
  final String error;
  GetSectionErrorState(this.error);
}
class SectionChangeState extends AppStates{}
class ClearSectionState extends AppStates{}

class GetAcademicTermsLoadingState extends AppStates{}
class GetAcademicTermsSuccessState extends AppStates{}
class GetAcademicTermsErrorState extends AppStates{
  final String error;
  GetAcademicTermsErrorState(this.error);
}
class AcademicTermsChangeState extends AppStates{}

class GetCategoryLoadingState extends AppStates{}
class GetCategorySuccessState extends AppStates{}
class ChangeCategorySuccessState extends AppStates{}
class GetCategoryErrorState extends AppStates{
  final String error;
  GetCategoryErrorState(this.error);
}

class GetSubCategoryLoadingState extends AppStates{}
class GetSubCategorySuccessState extends AppStates{}
class GetSubCategoryErrorState extends AppStates{
  final String error;
  GetSubCategoryErrorState(this.error);
}
class ClearSubCategoryState extends AppStates{}

class GetSubjectLoadingState extends AppStates{}
class GetSubjectSuccessState extends AppStates{}
class GetHeadDepartmentSubjectSuccessState extends AppStates{}
class GetSubjectErrorState extends AppStates{
  final String error;
  GetSubjectErrorState(this.error);
}
class SubjectChangeState extends AppStates{}
class GetSectionIdListSuccessState extends AppStates{}

class GetFilesLoadingState extends AppStates{}
class GetFilesSuccessState extends AppStates{}
class ClearFilesSuccessState extends AppStates{}
class GetFilesErrorState extends AppStates{
  final String error;
  GetFilesErrorState(this.error);
}
class GetCordinatorSubCategoySuccessState extends AppStates{}

class GetCoordinatorIdLoadingState extends AppStates{}
class GetCoordinatorIdSuccessState extends AppStates{}
class ChangeCoordinatorIdSuccessState extends AppStates{}
class GetCoordinatorIdErrorState extends AppStates{
  final String error;
  GetCoordinatorIdErrorState(this.error);
}
class DeleteFilesSuccessState extends AppStates{}
class DeleteFilesErrorState extends AppStates{
  final String error;
  DeleteFilesErrorState(this.error);
}

class GetUserSubjectLoadingState extends AppStates{}
class GetUserSubjectSuccessState extends AppStates{}
class GetUserSectionSuccessState extends AppStates{}
class GetUserSubjectErrorState extends AppStates{
  final String error;
  GetUserSubjectErrorState(this.error);
}
class ChangeUserSubjectState extends AppStates{}

class ChangeAdminBottomNavBarState extends AppStates{}
class UserTypeChangeState extends AppStates{}
class AcademicYearsChangeState extends AppStates{}
class AcademicTermsLoadingState extends AppStates{}
