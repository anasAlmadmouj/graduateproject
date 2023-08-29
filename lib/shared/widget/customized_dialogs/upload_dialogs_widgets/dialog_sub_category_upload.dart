import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
class DialogSubCategoryUpload extends StatelessWidget {
  const DialogSubCategoryUpload({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: CacheHelper.getData(key: spUserType) == userTypeAdmin ?
                  AppCubit.get(context).selectedDropDownSubCategory?.subCategoryName[0]
              :
                  AppCubit.get(context).selectedSubCategoryCoordinator?.subCategoryName[0],

          ),
          onTap: () {
            if(CacheHelper.getData(key: spUserType) == userTypeAdmin){
              if(AppCubit.get(context).selectedDropDownCategory?.categoryId == '-1') {
                showToast(message: 'Please select category',
                    state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).selectedDropDownCategory?.categoryName == subjectModel
                  && AppCubit.get(context).selectedDropDownSubjectTerm?.subjectTermId == '-1') {
                showToast(
                    message: 'Please select subject', state: ToastStates.ERROR);
              }
                 else if(AppCubit.get(context).subCategoryList.isEmpty) {
      showToast(message: 'Don\'t have sub category',
      state: ToastStates.ERROR);
      }
              else {
                showCustomDropDownDialog(
                    iconFunction: () {
                      maybePop(context);
                    },
                    context: context,
                    title: 'Sub category',
                    child: CustomDropDownDialog(
                        actionDropDownList:
                        AppCubit.get(context)
                            .subCategoryList
                            .map((subCategory) => Column(
                              children: [
                                Container(
                                  height: 55,
                          decoration: BoxDecoration(
                                  border: (AppCubit.get(context)
                                      .selectedDropDownSubCategory
                                      ?.subCategoryId ??
                                      '') ==
                                      subCategory.subCategoryId
                                      ? Border.all(color: Colors.blue)
                                      : null),
                          child: CustomActionDropDownDialog(
                                  title: subCategory.subCategoryName[0] ??
                                      '',
                                  fontWeight: FontWeight.bold,
                                  onTap: () {
                                    AppCubit.get(context)
                                        .changeSubCategory(
                                        subCategoryModel:
                                        subCategory);
                                    AppCubit.get(context).selectedDropDownSection = SectionModel(
                                      sectionName: sectionCollection,
                                      subjectId: '-1',
                                      userId: '-1',
                                      sectionId: '-1',
                                    );
                                  }),
                        ),
                                Divider(),
                              ],
                            ))
                            .toList()
                    ));
              }
            }
            else {
              if(AppCubit.get(context).selectedDropDownCategory?.categoryId == '-1') {
                showToast(message: 'Please select category',
                    state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).selectedDropDownCategory?.categoryName == subjectModel
                  && AppCubit.get(context).selectedDropDownSubject?.subjectTermId == '-1') {
                showToast(
                    message: 'Please select subject', state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).subCategoryIsCoordinatorList.isEmpty) {
                showToast(message: 'Don\'t have sub category',
                    state: ToastStates.ERROR);
              }
              else {
                showCustomDropDownDialog(
                    iconFunction: () {
                      maybePop(context);
                    },
                    context: context,
                    title: 'Sub category',
                    child: CustomDropDownDialog(
                        actionDropDownList:
                        AppCubit.get(context)
                            .subCategoryIsCoordinatorList
                            .map((subCategory) => Container(
                          decoration: BoxDecoration(
                              border: (AppCubit.get(context)
                                  .selectedSubCategoryCoordinator
                                  ?.subCategoryId ??
                                  '') ==
                                  subCategory.subCategoryId
                                  ? Border.all(color: Colors.blue)
                                  : null),
                          child: CustomActionDropDownDialog(
                              title: subCategory.subCategoryName[0] ??
                                  '',
                              fontWeight: FontWeight.bold,
                              onTap: () {
                                AppCubit.get(context)
                                    .changeSubCategoryCoordinator(
                                    subCategoryModel:
                                    subCategory);
                                AppCubit.get(context).selectedDropDownSection = SectionModel(
                                  sectionName: sectionCollection,
                                  subjectId: '-1',
                                  userId: '-1',
                                  sectionId: '-1',
                                );
                              }),
                        ))
                            .toList()
                    ));
              }
            }

            }




        );
      }
    );
  }
}
