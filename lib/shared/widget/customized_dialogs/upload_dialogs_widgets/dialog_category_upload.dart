import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';

class DialogCategoryUpload extends StatefulWidget {
  const DialogCategoryUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogCategoryUpload> createState() => _DialogCategoryUploadState();
}

class _DialogCategoryUploadState extends State<DialogCategoryUpload> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            hintText:
                AppCubit.get(context).selectedDropDownCategory?.categoryName ??
                    ''),
        onTap: () {
          if (AppCubit.get(context)
                  .selectedDropDownAcademicYears
                  ?.academicYearsId ==
              '-1') {
            showToast(
                message: 'Please select the year', state: ToastStates.ERROR);
          } else if (AppCubit.get(context)
                  .selectedDropDownAcademicTerms
                  ?.academicTermsId ==
              '-1') {
            showToast(
                message: 'Please select the term', state: ToastStates.ERROR);
          } else {
            AppCubit.get(context).categoryList.clear();
             AppCubit.get(context).getCategory().whenComplete(() => showCustomDropDownDialog(
                iconFunction: () {
                  AppCubit.get(context).changeCategoryClear();
                  maybePop(context);
                },
                context: context,
                title: 'Category',
                child: CustomDropDownDialog(
                    actionDropDownList: AppCubit.get(context)
                        .categoryList
                        .map((category) => Container(
                      decoration: BoxDecoration(
                          border: (AppCubit.get(context)
                              .selectedDropDownCategory
                              ?.categoryId ??
                              '') ==
                              category.categoryId
                              ? Border.all(color: Colors.blue)
                              : null),
                      child: CustomActionDropDownDialog(
                          title: category.categoryName ?? '',
                          fontWeight: FontWeight.bold,
                          onTap: () {
                            if(CacheHelper.getData(key: spUserType) == userTypeAdmin){
                              AppCubit.get(context).changeCategory(
                                  categoryModel: category);
                              AppCubit.get(context).subCategoryList.clear();
                              AppCubit.get(context).selectedDropDownSubCategory = SubCategoryModel(
                                subCategoryName: ['Sub Category'],
                                subCategoryId: '-1',
                                categoryId: '-1',
                              );
                              if (AppCubit.get(context)
                                  .selectedDropDownCategory
                                  ?.categoryName ==
                                  subjectModel){
                                AppCubit.get(context).selectedDropDownSection = SectionModel(
                                  sectionName: sectionCollection,
                                  subjectId: '-1',
                                  userId: '-1',
                                  sectionId: '-1',
                                );
                                AppCubit.get(context).subjectTermList.clear();
                                AppCubit.get(context)
                                    .selectedDropDownSubjectTerm =
                                    SubjectTermModel(
                                      academicTermId: '-1',
                                      subjectName: 'subject',
                                      subjectId: '-1',
                                      subjectTermId: '-1',
                                      departmentId: '-1',
                                      subjectCoordinator: '',
                                      subjectNumber: '-1',
                                    );
                                AppCubit.get(context).getSubjectsTerms(
                                    departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId,
                                    context: context,
                                    academicTermId: AppCubit.get(context)
                                        .selectedDropDownAcademicTerms
                                        ?.academicTermsId);
                              }
                            }
                            else {
                              AppCubit.get(context).changeCategory(
                                  categoryModel: category);
                              AppCubit.get(context).subCategoryIsCoordinatorList.clear();
                              AppCubit.get(context).selectedSubCategoryCoordinator = SubCategoryModel(
                                subCategoryName: ['Sub Category'],
                                subCategoryId: '-1',
                                categoryId: '-1',
                              );
                              if (AppCubit.get(context)
                                  .selectedDropDownCategory
                                  ?.categoryName ==
                                  subjectModel){
                                AppCubit.get(context).selectedDropDownSection = SectionModel(
                                  sectionName: sectionCollection,
                                  subjectId: '-1',
                                  userId: '-1',
                                  sectionId: '-1',
                                );
                                AppCubit.get(context).subjectList.clear();
                                AppCubit.get(context)
                                    .selectedDropDownSubject =
                                    SubjectTermModel(
                                      academicTermId: '-1',
                                      subjectName: 'subject',
                                      subjectId: '-1',
                                      subjectTermId: '-1',
                                      departmentId: '-1',
                                      subjectCoordinator: '',
                                      subjectNumber: '-1',
                                    );
                                AppCubit.get(context).getSubject(
                                  academicTermId:  AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId,
                                  context: context,
                                );
                              }
                            }

                            // if(CacheHelper.getData(key: spUserType) == userTypeAdmin){
                            //   if(AppCubit.get(context).);
                            // }
                            // AppCubit.get(context)
                            //     .changeCategory(categoryModel: category);
                            // AppCubit.get(context).subCategoryList.clear();
                            // AppCubit.get(context).selectedDropDownSubCategory = SubCategoryModel(
                            //   subCategoryName: ['Sub Category'],
                            //   subCategoryId: '-1',
                            //   categoryId: '-1',
                            // );
                            // AppCubit.get(context).getSubCategory(
                            //     context: context,
                            //     categoryId: AppCubit.get(context).selectedDropDownCategory?.categoryId);
                            // if(CacheHelper.getData(key: spUserType) == userTypeAdmin
                            //     && AppCubit.get(context)
                            //         .selectedDropDownCategory
                            //         ?.categoryName ==
                            //         subjectModel){
                            //   AppCubit.get(context).subjectTermList.clear();
                            //   AppCubit.get(context).selectedDropDownSubjectTerm = SubjectTermModel(
                            //     academicTermId: '-1',
                            //     subjectName: 'subject',
                            //     subjectId: '-1',
                            //     subjectTermId: '-1',
                            //     departmentId: '-1',
                            //     subjectCoordinator: '',
                            //     subjectNumber: '-1',
                            //   );
                            //   AppCubit.get(context).getSubjectsTerms(
                            //       context: context,
                            //       academicTermId: AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId
                            //   );
                            // }
                            // else if(CacheHelper.getData(key: spUserType) == userTypeUser
                            //     || CacheHelper.getData(key: spUserType) == userTypeHeadDepartment
                            //         && AppCubit.get(context)
                            //             .selectedDropDownCategory
                            //             ?.categoryName ==
                            //             subjectModel){
                            //   AppCubit.get(context).subCategoryIsCoordinatorList.clear();
                            //   AppCubit.get(context).selectedSubCategoryCoordinator = SubCategoryModel(
                            //       categoryId: '-1', subCategoryId: '-1', subCategoryName: ['Sub category']);
                            //   AppCubit.get(context).selectedDropDownSubject = SubjectTermModel(
                            //     academicTermId: '-1',
                            //     subjectCoordinator: '-1',
                            //     subjectId: '',
                            //     subjectTermId: '-1',
                            //   );
                            //   AppCubit.get(context)
                            //       .uniqueSubjectList
                            //       .clear();
                            //   AppCubit.get(context).getSubject(context: context);
                          }),
                    ))
                        .toList())));
          }
        },
      );
    });
  }
}
