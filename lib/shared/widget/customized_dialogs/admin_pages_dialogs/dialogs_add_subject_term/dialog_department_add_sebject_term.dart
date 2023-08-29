import 'package:graduateproject/models/subjects_model/subjects_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogDepartmentAddSubjectTerm extends StatelessWidget {
  const DialogDepartmentAddSubjectTerm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit , AdminStates>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
          return TextFormField(
            readOnly: true,
            decoration: InputDecoration(
                hintText: AppCubit.get(context)
                    .selectedDepartmentDialog
                    ?.departmentName ??
                    ''),
            onTap: () {
              if(AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId == '-1'){
                showToast(message: 'Please select year', state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId == '-1'){
                showToast(message: 'Please select term', state: ToastStates.ERROR);
              }
              else {
                AppCubit.get(context).departmentsList.clear();
                 AppCubit.get(context).getDepartment().whenComplete(() => showCustomDropDownDialog(
                     iconFunction: () {
                       AppCubit.get(context).changeDepartmentClear();
                       maybePop(context);
                     },
                     context: context,
                     title: 'Department',
                     child: CustomDropDownDialog(
                         actionDropDownList: AppCubit.get(context)
                             .departmentsList
                             .map((department) => Container(
                           decoration: BoxDecoration(
                               border: (AppCubit.get(context)
                                   .selectedDepartmentDialog
                                   ?.departmentId ??
                                   '') ==
                                   department?.departmentId
                                   ? Border.all(color: Colors.blue)
                                   : null),
                           child: CustomActionDropDownDialog(
                               title: department?.departmentName ?? '',
                               fontWeight: FontWeight.bold,
                               onTap: () {
                                 AppCubit.get(context).changeDepartment(
                                     departmentModel: department);
                                 AppCubit.get(context).subjectsList.clear();
                                 AppCubit.get(context).selectedSubjects = SubjectsModel(
                                   departmentId: '-1',
                                   subjectName: 'Subject',
                                   subjectId: '-1',
                                   numberSubject: '-1',
                                 );
                                 // AppCubit.get(context).getSubjects(
                                 //     context: context,
                                 //     departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId);
                               }),
                         ))
                             .toList())));
              }
            },
          );
          //   DropdownButtonFormField<DepartmentModel?>(
          //   validator: (value) => AppCubit.get(context).validateDropDown(value, 'department is required'),
          //   isExpanded: true,
          //   hint: Text(AppCubit.get(context)
          //       .selectedDropDownDepartment
          //       ?.departmentName ??
          //       ''),
          //   // value: HrAppCubit.get(context).selectedDropDownDepartment,
          //   onChanged: (DepartmentModel? newValue) {
          //     AppCubit.get(context)
          //         .changeDepartment(departmentModel: newValue);
          //   },
          //   items: AppCubit.get(context)
          //       .departmentsList
          //       .map<DropdownMenuItem<DepartmentModel?>>((value) {
          //     return DropdownMenuItem<DepartmentModel?>(
          //       value: value,
          //       child: Text(value?.departmentName ?? ''),
          //     );
          //   }).toList(),
          // );
        });
      }
    );
  }
}
