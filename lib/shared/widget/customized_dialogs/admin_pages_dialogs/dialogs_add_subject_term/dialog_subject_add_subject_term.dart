import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogSubjectAddSubjectTerm extends StatefulWidget {
  const DialogSubjectAddSubjectTerm({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSubjectAddSubjectTerm> createState() => _DialogSubjectAddSubjectTermState();
}

class _DialogSubjectAddSubjectTermState extends State<DialogSubjectAddSubjectTerm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit , AdminStates>(
      builder: (context , state) {
        return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
          return TextFormField(
            readOnly: true,
            decoration: InputDecoration(
                hintText: AppCubit.get(context)
                    .selectedSubjects
                    ?.subjectName ??
                    ''),
            onTap: () {
                AppCubit.get(context).subjectsList.clear();
                AppCubit.get(context).getSubjects(
                    context: context,
                    departmentId: AppCubit.get(context)
                        .selectedDepartmentDialog?.departmentId).whenComplete(() {
                  if(AppCubit.get(context).subjectsList.isEmpty){
                    showToast(message: 'Don\'t have subject in this department', state: ToastStates.ERROR);
                  }
                  else {
                    showCustomDropDownDialog(
                      iconFunction: () {
                        AppCubit.get(context).changeSubjectClear();
                        maybePop(context);
                      },
                      context: context,
                      title: 'Subject',
                      child: CustomDropDownDialog(
                          actionDropDownList: AppCubit.get(context)
                              .subjectsList
                              .map((subjects) => Column(
                                children: [
                                  Container(
                                    height: 55,
                            decoration: BoxDecoration(
                                    border: (AppCubit.get(context)
                                        .selectedSubjects
                                        ?.subjectId ??
                                        '') ==
                                        subjects.subjectId
                                        ? Border.all(color: Colors.blue)
                                        : null),
                            child: CustomActionDropDownDialog(
                                    title: subjects.subjectName ?? '',
                                    fontWeight: FontWeight.bold,
                                    onTap: () {
                                      AppCubit.get(context)
                                          .changeSubjects(
                                          subjectsModel: subjects);
                                    }),
                          ),
                                  Divider(),
                                ],
                              ))
                              .toList()));
                  }
                });
            },
          );
        });
      }
    );

  }
}
