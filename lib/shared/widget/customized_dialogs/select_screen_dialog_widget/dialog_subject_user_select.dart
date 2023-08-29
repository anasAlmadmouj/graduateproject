import 'package:graduateproject/models/section/section_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
import 'package:graduateproject/string_constant.dart';


class DialogSubjectUserSelect extends StatefulWidget {
  const DialogSubjectUserSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSubjectUserSelect> createState() => _DialogSubjectUserSelectState();
}

class _DialogSubjectUserSelectState extends State<DialogSubjectUserSelect> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: AppCubit.get(context)
                  .selectedDropDownSubject
                  ?.subjectName ??
                  ''),
          onTap: () {
            if(CacheHelper.getData(key: spUserType) == userTypeUser){
              if(AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId == '-1'){
                showToast(message: 'Please select academic term', state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).uniqueSubjectList.isEmpty){
                showToast(message: 'Don\'t have subject in this term', state: ToastStates.ERROR);
              }
              else{
                showCustomDropDownDialog(
                    iconFunction: () {
                      maybePop(context);
                    },
                    context: context,
                    title: 'Subject',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit.get(context)
                            .uniqueSubjectList
                            .map((subject) => Column(
                              children: [
                                Container(
                          height: 55,
                          decoration: BoxDecoration(
                                  border: (AppCubit.get(context)
                                      .selectedDropDownSubject
                                      ?.subjectTermId ??
                                      '') ==
                                      subject.subjectTermId
                                      ? Border.all(color: Colors.blue)
                                      : null),
                          child: CustomActionDropDownDialog(
                                  title: subject.subjectName ?? '',
                                  fontWeight: FontWeight.bold,
                                  onTap: () {
                                    AppCubit.get(context)
                                        .changeSubject(
                                        subjectModel: subject);
                                    AppCubit.get(context)
                                        .selectedDropDownSection = SectionModel(
                                      sectionName: sectionCollection,
                                      subjectId: '-1',
                                      userId: '-1',
                                      sectionId: '-1',
                                    );
                                    AppCubit.get(context).sectionList.clear();
                                    AppCubit.get(context).getSection(
                                        context: context,
                                        subjectId: AppCubit.get(context)
                                            .selectedDropDownSubject
                                            ?.subjectTermId);
                                  }),
                        ),
                                Divider(),
                              ],
                            ))
                            .toList()));
              }
            }
           else {
            if (AppCubit.get(context)
                    .selectedDropDownAcademicTerms
                    ?.academicTermsId ==
                '-1') {
              showToast(
                  message: 'Please select academic term',
                  state: ToastStates.ERROR);
            } else if (AppCubit.get(context).subjectTermList.isEmpty) {
              showToast(
                  message: 'Don\'t have subject in this term',
                  state: ToastStates.ERROR);
            } else {
              showCustomDropDownDialog(
                  iconFunction: () {
                    AppCubit.get(context).changeSubjectClear();
                    maybePop(context);
                  },
                  context: context,
                  title: 'Subject',
                  child: CustomDropDownDialog(
                      actionDropDownList: AppCubit.get(context)
                          .subjectTermList
                          .map((subjectTerm) => Container(
                                decoration: BoxDecoration(
                                    border: (AppCubit.get(context)
                                                    .selectedDropDownSubjectTerm
                                                    ?.subjectId ??
                                                '') ==
                                            subjectTerm.subjectId
                                        ? Border.all(color: Colors.blue)
                                        : null),
                                child: CustomActionDropDownDialog(
                                    title: subjectTerm.subjectName ?? '',
                                    fontWeight: FontWeight.bold,
                                    onTap: () {
                                      AppCubit.get(context).changeSubjectTerm(
                                          subjectModel: subjectTerm);
                                      AppCubit.get(context)
                                              .selectedDropDownSection =
                                          SectionModel(
                                        sectionName: sectionCollection,
                                        subjectId: '-1',
                                        userId: '-1',
                                        sectionId: '-1',
                                      );
                                      AppCubit.get(context).sectionList.clear();
                                      AppCubit.get(context).getSection(
                                          context: context,
                                          subjectId: AppCubit.get(context)
                                              .selectedDropDownSubjectTerm
                                              ?.subjectTermId);
                                    }),
                              ))
                          .toList()));
            }
          }
        },
        );
    });
  }
}

