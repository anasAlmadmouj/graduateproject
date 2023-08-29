import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogSubjectsSelectRange extends StatefulWidget {
  const DialogSubjectsSelectRange({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSubjectsSelectRange> createState() => _DialogSubjectsSelectRangeState();
}

class _DialogSubjectsSelectRangeState extends State<DialogSubjectsSelectRange> {
  @override
  Widget build(BuildContext context) {
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
                departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId,
              ).whenComplete(()
              {
              if(AppCubit.get(context).subjectsList.isEmpty){
                  showToast(message: 'Don\'t have subject in this term', state: ToastStates.ERROR);
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
                .map((subjects) => Container(
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
            ))
                .toList()));
              }
                  });

          },
        );
    });
  }
}

