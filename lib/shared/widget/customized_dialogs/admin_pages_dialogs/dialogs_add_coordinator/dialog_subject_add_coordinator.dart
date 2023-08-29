import 'package:graduateproject/models/users_model/users_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogSubjectAddTerm extends StatefulWidget {
  const DialogSubjectAddTerm({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSubjectAddTerm> createState() => _DialogSubjectAddTermState();
}

class _DialogSubjectAddTermState extends State<DialogSubjectAddTerm> {
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
                    .selectedDropDownSubjectTerm
                    ?.subjectName ??
                    ''),
            onTap: () {
              if(AppCubit.get(context).subjectTermList.isEmpty){
                showToast(message: 'Don\'t have subject ', state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).subjectTermList.isNotEmpty){
                showCustomDropDownDialog(
                    iconFunction: () {
                      AppCubit.get(context).changeSubjectClear();
                      maybePop(context);
                    },
                    context: context,
                    title: 'Subject',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit
                            .get(context)
                            .subjectTermList
                            .map((subjectTerm) =>
                            Container(
                              decoration: BoxDecoration(
                                  border: (AppCubit
                                      .get(context)
                                      .selectedDropDownSubjectTerm
                                      ?.subjectTermId ??
                                      '') ==
                                      subjectTerm.subjectTermId
                                      ? Border.all(
                                      color: Colors.blue)
                                      : null),
                              child: CustomActionDropDownDialog(
                                  title:
                                  subjectTerm.subjectName ??
                                      '',
                                  fontWeight: FontWeight.bold,
                                  onTap: () {
                                    AppCubit.get(context)
                                        .changeSubjectTerm(
                                        subjectModel:
                                        subjectTerm);
                                    AppCubit.get(context)
                                        .changeSubjectClear();
                                    AppCubit.get(context)
                                        .uniqueUserSubjectList.clear();
                                    AppCubit.get(context)
                                        .userSubjectList.clear();
                                    AppCubit.get(context).userSectionList.clear();
                                    AppCubit.get(context)
                                        .selectedDropDownUserSubject = UsersModel(
                                      userName: 'Coordinator',
                                      userId: '-1',
                                      userTypeId: '-1',
                                      departmentId: '-1',
                                      userEmail: '-1',
                                    );
                                    AppCubit.get(context).getSubjectUser(
                                        subjectId: AppCubit
                                            .get(context)
                                            .selectedDropDownSubjectTerm
                                            ?.subjectTermId);
                                  }),
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
