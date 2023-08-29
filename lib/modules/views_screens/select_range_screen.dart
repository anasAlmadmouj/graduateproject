import 'package:flutter/material.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/modules/views_screens/vew_screen.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_range_dialogs_widgets/dialog_category_select_range.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_range_dialogs_widgets/dialog_end_year_select_range.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_range_dialogs_widgets/dialog_start_year_select_range.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_range_dialogs_widgets/dialog_sub_category_select_range.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/select_range_dialogs_widgets/dialog_subjects_select_range.dart';
import '../admin/admin_imports/admin.dart';

class SelectRangeScreen extends StatefulWidget {
  const SelectRangeScreen({Key? key}) : super(key: key);

  @override
  State<SelectRangeScreen> createState() => _SelectRangeScreenState();
}

class _SelectRangeScreenState extends State<SelectRangeScreen> {
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
              // AppCubit.get(context).selectedDropDownSubjectTerm = SubjectTermModel(
              //   subjectName: 'Subject',
              //   numberSubject: '-1',
              //   departmentId: '-1',
              //   subjectId: '-1',
              // );
              AppCubit.get(context)
                  .startRangeDateTime = DateTime(-1);
              AppCubit.get(context)
                  .endRangeDateTime = DateTime(-1);
              Navigator.pop(context);
            },
            title: 'Archived',
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const DialogStartYearSelectRange(), // start year
                const SizedBox(
                  height: 15,
                ),
                const DialogEndYearSelectRange(),   // end year
                const SizedBox(
                  height: 15,
                ),
                const DepartmentDialog(),
                const SizedBox(
                  height: 15,
                ),
                const DialogCategorySelectRange(),
                const SizedBox(
                  height: 15,
                ),
                const DialogSubCategorySelectRange(),
                if(AppCubit.get(context).selectedDropDownCategory?.categoryName == subjectModel)
                  Column(
                    children: const [
                      SizedBox(height: 15,),
                      DialogSubjectsSelectRange(),
                    ],
                  ),

                const SizedBox(
                  height: 40,
                ),
                defaultElevatedButton(
                    text: 'Apply',
                    backGroundColor: defaultColorGreen,
                    function: () {
                      if(AppCubit.get(context).startRangeDateTime == DateTime(-1)){
                        showToast(message: 'Please select the start year', state: ToastStates.ERROR);
                      }
                      else if(AppCubit.get(context).startRangeDateTime == DateTime(-1)){
                        showToast(message: 'Please select the end year', state: ToastStates.ERROR);
                      }
                      else if(AppCubit.get(context).selectedDepartmentDialog?.departmentId == '-1'){
                        showToast(message: 'Please select the department', state: ToastStates.ERROR);
                      }
                      else if(AppCubit.get(context).selectedDropDownCategory?.categoryId == '-1'){
                        showToast(message: 'Please select the Category', state: ToastStates.ERROR);
                      }
                      AppCubit.get(context).getFilesRange(
                        startYear: AppCubit.get(context).startRangeDateTime.year,
                        endYear: AppCubit.get(context).endRangeDateTime.year,
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
                            .selectedSubjects!
                            .subjectId,
                      );
                      AppCubit.get(context).isSelectRange = true;
                      navigateTo(context, const ViewScreen());
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
