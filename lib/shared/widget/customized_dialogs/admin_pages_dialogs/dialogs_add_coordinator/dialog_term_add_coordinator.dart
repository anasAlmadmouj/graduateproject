import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogTermAddTerm extends StatefulWidget {
  const DialogTermAddTerm({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogTermAddTerm> createState() => _DialogTermAddTermState();
}

class _DialogTermAddTermState extends State<DialogTermAddTerm> {
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
                    .selectedDropDownAcademicTerms
                    ?.academicTermsName ??
                    ''),
            onTap: () {
              if (AppCubit
                  .get(context)
                  .selectedDropDownAcademicYears
                  ?.academicYearsId ==
                  '-1') {
                showToast(
                    message: 'Please select the year',
                    state: ToastStates.ERROR);
              } else {
                showCustomDropDownDialog(
                    iconFunction: () {
                      AppCubit.get(context)
                          .changeAcademicTermClear();
                      maybePop(context);
                    },
                    context: context,
                    title: 'Academic term',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit
                            .get(context)
                            .academicTermsList
                            .map((academicTerm) =>
                            Container(
                              decoration: BoxDecoration(
                                  border: (AppCubit
                                      .get(context)
                                      .selectedDropDownAcademicTerms
                                      ?.academicTermsId ??
                                      '') ==
                                      academicTerm
                                          .academicTermsId
                                      ? Border.all(
                                      color: Colors.blue)
                                      : null),
                              child: CustomActionDropDownDialog(
                                  title: academicTerm
                                      .academicTermsName ??
                                      '',
                                  fontWeight: FontWeight.bold,
                                  onTap: () {
                                    AppCubit.get(context)
                                        .changeAcademicTerms(
                                        academicTermsModel:
                                        academicTerm);
                                    AppCubit
                                        .get(context)
                                        .selectedDropDownSubjectTerm =
                                        SubjectTermModel(
                                          academicTermId: '-1',
                                          subjectName: 'subject',
                                          subjectId: '-1',
                                          subjectTermId: '-1',
                                          departmentId: '-1',
                                          subjectCoordinator: '',
                                          subjectNumber: '-1',
                                        );
                                    AppCubit
                                        .get(context)
                                        .subjectTermList
                                        .clear();

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
