import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
import 'package:graduateproject/string_constant.dart';
class DialogAcademicTermsUpload extends StatelessWidget {
  const DialogAcademicTermsUpload({
    Key? key,
  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: AppCubit.get(context)
                .selectedDropDownAcademicTerms
                ?.academicTermsName ??
                ''),
        onTap: () {
          if(AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId == '-1'){
            showToast(message: 'Please select the year', state: ToastStates.ERROR);
          }
          else {

            showCustomDropDownDialog(
                iconFunction: (){
                  AppCubit.get(context).changeAcademicTermClear();
                  maybePop(context);
                },
                context: context,
                title: 'Academic term',
                child: CustomDropDownDialog(
                    actionDropDownList: AppCubit.get(context)
                        .academicTermsList
                        .map((academicTerm) => Container(
                      decoration: BoxDecoration(
                          border: (AppCubit.get(
                              context)
                              .selectedDropDownAcademicTerms
                              ?.academicTermsId ??
                              '') ==
                              academicTerm
                                  .academicTermsId
                              ? Border.all(
                              color: Colors.blue)
                              : null),
                      child:
                      CustomActionDropDownDialog(
                          title: academicTerm
                              .academicTermsName ??
                              '',
                          fontWeight:
                          FontWeight.bold,
                          onTap: () {
                            AppCubit.get(context).changeAcademicTerms(academicTermsModel: academicTerm );
                            AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                              departmentName: 'Department',
                              departmentHeadId: '-1',
                              departmentId: '-1',
                            );
                            AppCubit.get(context).selectedDropDownCategory = CategoryModel(
                              categoryName: 'Category',
                              categoryId: '-1',
                              departmentId: '-1',
                            );
                            if(CacheHelper.getData(key: spUserType) == userTypeAdmin){
                              AppCubit.get(context).selectedDropDownSubCategory = SubCategoryModel(
                                subCategoryName: ['Sub Category'],
                                subCategoryId: '-1',
                                categoryId: '-1',
                              );
                            }
                            else {
                              AppCubit.get(context).selectedSubCategoryCoordinator = SubCategoryModel(
                                  categoryId: '-1', subCategoryId: '-1', subCategoryName: ['Sub category']);
                            }
                          }),
                    ))
                        .toList()));
          }
        },
      );
    });
  }
}
