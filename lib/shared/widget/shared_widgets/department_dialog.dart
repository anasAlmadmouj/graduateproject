import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DepartmentDialog extends StatelessWidget {
  const DepartmentDialog({
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
              AppCubit.get(context).departmentsList.clear();
               AppCubit.get(context).getDepartment().whenComplete(() => showCustomDropDownDialog(
                   iconFunction: (){
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
                             border: (AppCubit.get(
                                 context)
                                 .selectedDepartmentDialog
                                 ?.departmentId ??
                                 '') ==
                                 department
                                     ?.departmentId
                                 ? Border.all(
                                 color: Colors.blue)
                                 : null),
                         child:
                         CustomActionDropDownDialog(
                             title: department
                                 ?.departmentName ??
                                 '',
                             fontWeight:
                             FontWeight.bold,
                             onTap: () {
                               AppCubit.get(context)
                                   .changeDepartment(
                                   departmentModel:
                                   department);
                               AppCubit.get(context).changeDepartmentClear();
                             }),
                       ))
                           .toList())));
            },
          );
        });
      },
    );
  }
}
