import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogUsersAddDepartment extends StatefulWidget {
  const DialogUsersAddDepartment({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogUsersAddDepartment> createState() => _DialogUsersAddDepartmentState();
}

class _DialogUsersAddDepartmentState extends State<DialogUsersAddDepartment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit , AdminStates>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
          return TextFormField(
            readOnly: true,
            decoration: InputDecoration(
                hintText: AdminCubit.get(context).selectedDropDownUsers?.userId == '-1' ?
                'Head department'
                    : AdminCubit.get(context)
                    .selectedDropDownUsers
                    ?.userName

                    ??
                    ''),
            onTap: () {

              showCustomDropDownDialog(
                  iconFunction: (){
                    maybePop(context);
                  },
                  context: context,
                  title: 'Head department',
                  child: CustomDropDownDialog(
                      actionDropDownList: AdminCubit.get(context)
                          .userList
                          .map((users) => Column(
                            children: [
                              Container(
                                height: 55,
                        decoration: BoxDecoration(
                                border: (AppCubit.get(
                                    context)
                                    .selectedDropDownUserType
                                    ?.userTypeId ??
                                    '') ==
                                    users
                                        .userId
                                    ? Border.all(
                                    color: Colors.blue)
                                    : null),
                        child:
                        CustomActionDropDownDialog(
                                title: users
                                    .userName ??
                                    '',
                                fontWeight:
                                FontWeight.bold,
                                onTap: () {
                                  AdminCubit.get(context)
                                      .changeUser(
                                      usersModel:
                                      users);
                                }),
                      ),
                              Divider(),
                            ],
                          ))
                          .toList()));
            },
          );
        });
      },
    );

  }
}
