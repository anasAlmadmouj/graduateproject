import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DropDownUsers extends StatelessWidget {
  const DropDownUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminCubit.get(context).userList.isNotEmpty
        ? BlocBuilder<AdminCubit, AdminStates>(builder: (context, state) {
      return TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: AdminCubit.get(context)
                .selectedDropDownUsers
                ?.userName ??
                ''),
        onTap: () {

          showCustomDropDownDialog(
              iconFunction: (){
                maybePop(context);
              },
              context: context,
              title: 'Users',
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
    })
        : const SizedBox();
  }
}
