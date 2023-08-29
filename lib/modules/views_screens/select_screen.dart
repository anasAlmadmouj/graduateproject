import 'package:flutter/material.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/modules/views_screens/vew_screen.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_screen_dialog_widget/dialog_academic_terms_select.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_screen_dialog_widget/dialog_academic_year_select.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_screen_dialog_widget/dialog_category_select.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_screen_dialog_widget/dialog_section_select_screen.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_screen_dialog_widget/dialog_sub_category_select.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_screen_dialog_widget/dialog_subject_term_select.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_screen_dialog_widget/dialog_subject_user_select.dart';
import '../admin/admin_imports/admin.dart';
import 'package:graduateproject/models/subjects_terms_model/subjects_terms_model.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: customizedAppBar(
            function: () {
              AppCubit.get(context).selectedDropDownAcademicYears =
                  AcademicYearsModel(
                academicYearsNumber: [],
                academicYearsId: '-1',
              );
              AppCubit.get(context).selectedDropDownAcademicTerms =
                  AcademicTermsModel(
                academicTermsName: 'academic term',
                academicYearsId: '-1',
                academicTermsId: '-1',
              );
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
              AppCubit.get(context).selectedDropDownSubCategory =
                  SubCategoryModel(
                subCategoryName: ['Sub Category'],
                subCategoryId: '-1',
                categoryId: '-1',
              );
              AppCubit.get(context).selectedDropDownSubjectTerm =
                  SubjectTermModel(
                    academicTermId: '-1',
                    subjectName: 'subject',
                    subjectId: '-1',
                    subjectTermId: '-1',
                    departmentId: '-1',
                    subjectCoordinator: '',
                    subjectNumber: '-1',
                  );
              AppCubit.get(context).subjectList.clear();
              AppCubit.get(context).uniqueSubjectList.clear();
              AppCubit.get(context).sectionIdList.clear();
              Navigator.pop(context);
            },
            title: 'Archived',
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const AcademicYearsDialogSelect(), //year
                const SizedBox(
                  height: 15,
                ),
                const DialogAcademicTermsSelect(),
                const SizedBox(
                  height: 15,
                ),
                const DepartmentDialog(),
                const SizedBox(
                  height: 15,
                ),
                const DialogCategorySelect(),
                if(CacheHelper.getData(key: spUserType) == userTypeAdmin
                    || CacheHelper.getData(key: spUserType) == userTypeHeadDepartment)
                Column(
                  children: const [
                    SizedBox(height: 15,),
                     DialogSubCategorySelect(),
                  ],
                ),
                if (AppCubit.get(context)
                        .selectedDropDownCategory
                        ?.categoryName ==
                    subjectModel)
                  Column(
                    children: [
                      if(CacheHelper.getData(key: spUserType) == userTypeAdmin
                          || CacheHelper.getData(key: spUserType) == userTypeHeadDepartment)
                      Column(
                        children: const [
                          SizedBox(
                            height: 15,
                          ),
                          DialogSubjectTermSelect(),
                        ],
                      ),

                      if(CacheHelper.getData(key: spUserType) == userTypeUser)
                        Column(
                          children: const[
                            SizedBox(
                              height: 15,
                            ),
                            DialogSubjectUserSelect(),
                          ],
                        ),

                    ],
                  ),
                if (CacheHelper.getData(key: spUserType) == userTypeUser &&
                    AppCubit.get(context)
                            .selectedDropDownCategory
                            ?.categoryName ==
                        subjectModel)
                  Column(
                    children: const [
                      SizedBox(height: 15,),
                      DialogSectionSelectScreen(),
                    ],
                  ),
                const SizedBox(
                  height: 40,
                ),
                defaultElevatedButton(
                    text: 'Apply',
                    backGroundColor: defaultColorGreen,
                    function: () {
                      if(AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId == '-1'){
                        showToast(message: 'Please select the year', state: ToastStates.ERROR);
                      }
                      else if(AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId == '-1'){
                        showToast(message: 'Please select the term', state: ToastStates.ERROR);
                      }
                      else if(AppCubit.get(context).selectedDepartmentDialog?.departmentId == '-1'){
                        showToast(message: 'Please select the department', state: ToastStates.ERROR);
                      }
                      else if(AppCubit.get(context).selectedDropDownCategory?.categoryId == '-1'){
                        showToast(message: 'Please select the Category', state: ToastStates.ERROR);
                      }
                      else {
                        if (CacheHelper.getData(key: spUserType) ==
                            userTypeUser) {
                          AppCubit.get(context).getUserFiles(
                            sectionId: AppCubit.get(context)
                                .selectedDropDownSection
                                ?.sectionId,
                            yearId: AppCubit.get(context)
                                .selectedDropDownAcademicYears!
                                .academicYearsId,
                            termId: AppCubit.get(context)
                                .selectedDropDownAcademicTerms!
                                .academicTermsId,
                            departmentId: AppCubit.get(context)
                                .selectedDepartmentDialog!
                                .departmentId,
                            categoryId: AppCubit.get(context)
                                .selectedDropDownCategory!
                                .categoryId,
                            subjectId: AppCubit.get(context)
                                .selectedDropDownSubject!
                                .subjectId,
                          );
                        }
                        else {
                          AppCubit.get(context).getFiles(
                            yearId: AppCubit.get(context)
                                .selectedDropDownAcademicYears!
                                .academicYearsId,
                            termId: AppCubit.get(context)
                                .selectedDropDownAcademicTerms!
                                .academicTermsId,
                            departmentId: AppCubit.get(context)
                                .selectedDepartmentDialog!
                                .departmentId,
                            categoryId: AppCubit.get(context)
                                .selectedDropDownCategory!
                                .categoryId,
                            subCategoryId: AppCubit.get(context)
                                .selectedDropDownSubCategory!
                                .subCategoryId,
                            subjectId: AppCubit.get(context)
                                .selectedDropDownSubjectTerm!
                                .subjectId,
                          );
                        }
                        navigateTo(context, const ViewScreen());
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

