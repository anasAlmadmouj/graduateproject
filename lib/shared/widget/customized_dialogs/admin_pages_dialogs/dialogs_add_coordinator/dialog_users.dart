import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogUsers extends StatelessWidget {
  const DialogUsers({
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
                hintText: AppCubit
                    .get(context)
                    .selectedDropDownUserSubject
                    ?.userName ??
                    ''),
            onTap: () {
              if (AppCubit
                  .get(context)
                  .selectedDropDownSubjectTerm
                  ?.subjectTermId == '-1') {
                showToast(message: 'Please select subject',
                    state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).uniqueUserSubjectList.isEmpty){
                showToast(message: 'The subject don\'t have sections yet ', state: ToastStates.ERROR);
              }
              else {
                showCustomDropDownDialog(
                    iconFunction: () {
                      maybePop(context);
                    },
                    context: context,
                    title: 'Users',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit
                            .get(context)
                            .uniqueUserSubjectList
                            .map((userSubject) =>
                            Column(
                              children: [
                                Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      border: (AppCubit
                                          .get(context)
                                          .selectedDropDownUserSubject
                                          ?.userId ??
                                          '') ==
                                          userSubject.userId
                                          ? Border.all(
                                          color: Colors.blue)
                                          : null),
                                  child: CustomActionDropDownDialog(
                                      title:
                                      userSubject.userName ??
                                          '',
                                      fontWeight: FontWeight.bold,
                                      onTap: () {
                                        AppCubit.get(context)
                                            .changeUserSubject(
                                            usersModel:
                                            userSubject);
                                      }),
                                ),
                                Divider(),
                              ],
                            ))
                            .toList()));
              }
            },
          );
        });
      },
    );

  }
}
