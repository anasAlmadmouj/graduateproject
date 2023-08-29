import 'package:graduateproject/models/section/section_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
import 'package:graduateproject/string_constant.dart';


class DialogSubjectAddSection extends StatefulWidget {
  const DialogSubjectAddSection({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSubjectAddSection> createState() => _DialogSubjectAddSectionState();
}

class _DialogSubjectAddSectionState extends State<DialogSubjectAddSection> {
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
              // print(AppCubit.get(context).subjectTermList.isEmpty? true : false);
              if(AppCubit.get(context).subjectTermList.isNotEmpty) {
                showCustomDropDownDialog(
                    iconFunction: () {
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
                                      ?.subjectId ??
                                      '') ==
                                      subjectTerm.subjectId
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
                                    AppCubit.get(context).sectionList.clear();
                                    AppCubit.get(context).selectedDropDownSection = SectionModel(
                                      sectionName: sectionCollection,
                                      subjectId: '-1',
                                      userId: '-1',
                                      sectionId: '-1',
                                    );
                                    AppCubit.get(context)
                                        .getSection(
                                        context: context,
                                        subjectId: AppCubit
                                            .get(
                                            context)
                                            .selectedDropDownSubjectTerm
                                            ?.subjectTermId);
                                  }),
                            ))
                            .toList()));
              }
              else {
                showToast(message: 'dont have subject', state: ToastStates.ERROR);
              }
            },
          );
        });
      },
    );

  }
}
