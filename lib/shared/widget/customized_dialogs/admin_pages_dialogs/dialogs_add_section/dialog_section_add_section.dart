import 'package:graduateproject/models/users_model/users_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogSectionAddSection extends StatefulWidget {
  const DialogSectionAddSection({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSectionAddSection> createState() => _DialogSectionAddSectionState();
}

class _DialogSectionAddSectionState extends State<DialogSectionAddSection> {
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
                    .selectedDropDownSection
                    ?.sectionName ??
                    ''),
            onTap: () {
              if (AppCubit
                  .get(context)
                  .selectedDropDownSubjectTerm
                  ?.subjectTermId == '-1') {
                showToast(message: 'Please select subject'
                  , state: ToastStates.ERROR,);
              }
              else if (AppCubit.get(context).sectionList.isEmpty){
                showToast(message: 'Don\'t have section', state: ToastStates.ERROR);
              }
              else {
                showCustomDropDownDialog(
                    iconFunction: () {
                      maybePop(context);
                    },
                    context: context,
                    title: 'Section',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit
                            .get(context)
                            .sectionList
                            .map((section) =>
                            Container(
                              decoration: BoxDecoration(
                                  border: (AppCubit
                                      .get(
                                      context)
                                      .selectedDropDownSection
                                      ?.sectionId ??
                                      '') ==
                                      section
                                          .sectionId
                                      ? Border.all(
                                      color: Colors.blue)
                                      : null),
                              child:
                              CustomActionDropDownDialog(
                                  title: section
                                      .sectionName ??
                                      '',
                                  fontWeight:
                                  FontWeight.bold,
                                  onTap: () {
                                    AppCubit.get(context)
                                        .changeSection(
                                        sectionModel:
                                        section);
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
