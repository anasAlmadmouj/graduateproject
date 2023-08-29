import 'package:graduateproject/models/section/section_model.dart';
import 'package:graduateproject/models/users_model/users_model.dart';
import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogDepartmentAddSection extends StatelessWidget {
  const DialogDepartmentAddSection({
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
                             .map((department) => Column(
                               children: [
                                 Container(
                                   height: 55,
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
                                     AppCubit.get(context).subjectTermList.clear();
                                     AppCubit.get(context).selectedDropDownSubjectTerm = SubjectTermModel(
                                       academicTermId: '-1',
                                       subjectName: 'subject',
                                       subjectId: '-1',
                                       subjectTermId: '-1',
                                       departmentId: '-1',
                                       subjectCoordinator: '',
                                       subjectNumber: '-1',
                                     );
                                     AppCubit.get(context).selectedDropDownSection = SectionModel(
                                       sectionName: sectionCollection,
                                       subjectId: '-1',
                                       userId: '-1',
                                       sectionId: '-1',
                                     );
                                     AdminCubit.get(context).selectedDropDownUsers = UsersModel(
                                         userName: ' users',
                                         userId: '-1',
                                         departmentId: '-1',
                                         userTypeId: '-1',
                                         userEmail: '-1'
                                     );
                                     AppCubit.get(context).getSubjectsTerms(
                                         academicTermId: AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId,
                                         context: context,
                                         departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId);
                                   }),
                         ),
                                 Divider(),
                               ],
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
      },
    );
  }
}
