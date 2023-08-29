import 'package:graduateproject/app_layout/app_layout_imports.dart';
import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/modules/login/cubit/login_states.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class SubjectDialog extends StatelessWidget {
  const SubjectDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
      return BlocBuilder<AppCubit , AppStates>(
          builder: (context, state) {
            return AppCubit.get(context).
            selectedDropDownCategory?.categoryName == subjectModel ?
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  hintText: AppCubit.get(context)
                      .selectedDropDownSubject
                      ?.subjectCoordinator ??
                      ''),
              onTap: () {

                showCustomDropDownDialog(
                    iconFunction: (){
                      AppCubit.get(context).changeSubjectClear();
                      maybePop(context);
                    },
                    context: context,
                    title: 'Subject',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit.get(context)
                            .uniqueSubjectList
                            .map((subject) => Container(
                          decoration: BoxDecoration(
                              border: (AppCubit.get(
                                  context)
                                  .selectedDropDownSubject
                                  ?.subjectId ??
                                  '') ==
                                  subject
                                      .subjectId
                                  ? Border.all(
                                  color: Colors.blue)
                                  : null),
                          child:
                          CustomActionDropDownDialog(
                              title: subject
                                  .subjectCoordinator ??
                                  '',
                              fontWeight:
                              FontWeight.bold,
                              onTap: () {
                                AppCubit.get(context)
                                    .changeSubject(
                                    subjectModel:
                                    subject);
                                AppCubit.get(context).changeSubjectClear();
                                AppCubit.get(context).getSection(context: context,
                                    subjectId: AppCubit.get(context).selectedDropDownSubject?.subjectId);
                              }),
                        ))
                            .toList()));
              },
            )
                : const SizedBox();
          },
      );
    });

  }
}
