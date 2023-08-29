import 'package:graduateproject/app_layout/app_cubit/app_cubit_imports.dart';
import 'package:graduateproject/models/subjects_model/subjects_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_subject_term/dialog_department_add_sebject_term.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_subject_term/dialog_subject_add_subject_term.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_subject_term/dialog_term_add_subject_term.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_subject_term/dialog_year_add_subject_term.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
import 'package:graduateproject/models/subjects_terms_model/subjects_terms_model.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';

class AddSubjectTermScreen extends StatefulWidget {
  const AddSubjectTermScreen({super.key});

  @override
  State<AddSubjectTermScreen> createState() => _AddSubjectTermScreenState();
}

class _AddSubjectTermScreenState extends State<AddSubjectTermScreen> {
  var subjectController = TextEditingController();

  var numberSubjectController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var numberSectionController = TextEditingController();

  List<int> numberSectionList =
      List.generate(9, (indexSection) => indexSection + 1);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, appState) {
          return BlocConsumer<AdminCubit, AdminStates>(
            listener: (context, adminState) {
              if (adminState is AddSubjectSuccessState) {
                showToast(
                    message: 'Add Subject Success', state: ToastStates.SUCCESS);
              }
              if (adminState is AddSubjectErrorState) {
                showToast(message: adminState.error, state: ToastStates.ERROR);
              }
            },
            builder: (context, adminState) {
              return Scaffold(
                appBar: customizedAppBar(
                  function: () {
                    AppCubit.get(context).selectedDropDownAcademicYears = AcademicYearsModel(
                      academicYearsNumber: [-1],
                      academicYearsId: '-1',
                    );
                    AppCubit.get(context).selectedDropDownAcademicTerms = AcademicTermsModel(
                      academicTermsName: 'academic term',
                      academicYearsId: '-1',
                      academicTermsId: '-1',
                    );
                    AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                      departmentName: 'Department',
                      departmentHeadId: '-1',
                      departmentId: '-1',
                    );
                    AppCubit.get(context).selectedSubjects = SubjectsModel(
                      departmentId: '-1',
                      subjectName: 'Subject',
                      subjectId: '-1',
                      numberSubject: '-1',
                    );

                    Navigator.pop(context);
                  },
                  title: 'Add New Subject',
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const LogoAddingPages(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogYearsAddSubjectTerm(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogTermAddSubjectTerm(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogDepartmentAddSubjectTerm(),
                      const DialogSubjectAddSubjectTerm(),
                      const SizedBox(
                        height: 10,
                      ),
                      DropDownNumberOfSection(
                          numberSectionList: numberSectionList),
                      const SizedBox(
                        height: 30,
                      ),
                      adminState is AddSubjectLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : defaultElevatedButton(
                              backGroundColor: defaultColorGreen,
                              text: 'Add Subject',
                              width: MediaQuery.of(context).size.width / 1.5,
                              function: () async {
                                if (AppCubit.get(context)
                                            .selectedSubjects
                                            ?.subjectId ==
                                        '-1' &&
                                    formKey.currentState!.validate()) {
                                  showToast(
                                      message: 'Please select subject',
                                      state: ToastStates.ERROR);
                                } else if (formKey.currentState!.validate()) {
                                  await AdminCubit.get(context)
                                      .checkIsSubjectTermAvailable(
                                          academicTermId: AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId,
                                          subjectNumber: AppCubit.get(context)
                                              .selectedSubjects
                                              ?.numberSubject)
                                      .then((isSuccess) {
                                    if (isSuccess) {
                                      Uuid id = const Uuid();
                                      String subjectTermId = id.v1();
                                      SubjectTermModel subjectTermModel =
                                          SubjectTermModel(
                                        subjectTermId: subjectTermId,
                                        subjectId: AppCubit.get(context)
                                                .selectedSubjects
                                                ?.subjectId ??
                                            '-1',
                                        academicTermId: AppCubit.get(context)
                                                .selectedDropDownAcademicTerms
                                                ?.academicTermsId ??
                                            '-1',
                                        departmentId: AppCubit.get(context)
                                                .selectedSubjects
                                                ?.departmentId ??
                                            '-1',
                                        subjectNumber: AppCubit.get(context)
                                                .selectedSubjects
                                                ?.numberSubject ??
                                            '-1',
                                        subjectName: AppCubit.get(context)
                                                .selectedSubjects
                                                ?.subjectName ??
                                            '',
                                      );
                                      AdminCubit.get(context)
                                          .createSubjectsTerm(
                                        subjectsTermModel: subjectTermModel,
                                      );
                                      AppCubit.get(context).selectedDropDownAcademicYears = AcademicYearsModel(
                                        academicYearsNumber: [-1],
                                        academicYearsId: '-1',
                                      );
                                      AppCubit.get(context).selectedDropDownAcademicTerms = AcademicTermsModel(
                                        academicTermsName: 'academic term',
                                        academicYearsId: '-1',
                                        academicTermsId: '-1',
                                      );
                                      AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                                        departmentName: 'Department',
                                        departmentHeadId: '-1',
                                        departmentId: '-1',
                                      );
                                      AppCubit.get(context).selectedSubjects = SubjectsModel(
                                        departmentId: '-1',
                                        subjectName: 'Subject',
                                        subjectId: '-1',
                                        numberSubject: '-1',
                                      );
                                      for (int i = 1;
                                          i <=
                                              (AdminCubit.get(context)
                                                      .numberSection ??
                                                  0);
                                          i++) {
                                        Uuid idSec = const Uuid();
                                        String sectionId = idSec.v1();
                                        SectionModel sectionModel =
                                            SectionModel(
                                          subjectId: subjectTermId,
                                          sectionId: sectionId,
                                          sectionName: 'section $i',
                                        );
                                        AdminCubit.get(context).createSection(
                                            sectionModel: sectionModel);
                                      }
                                      AdminCubit.get(context).checkSubjectTermList.clear();
                                    }
                                    else {
                                      showToast(
                                          message:
                                              'This subject already exist in this term ',
                                          state: ToastStates.ERROR);
                                      AdminCubit.get(context).checkSubjectTermList.clear();
                                    }
                                  });
                                }
                              }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DropDownNumberOfSection extends StatelessWidget {
  const DropDownNumberOfSection({
    super.key,
    required this.numberSectionList,
  });

  final List<int> numberSectionList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminStates>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return DropdownButtonFormField(
              validator: (value) => AppCubit.get(context).validateDropDown(
                value,
                'Please select the number of section',
              ),
              decoration: const InputDecoration(
                hintText: 'Select the number of section',
              ),
              items: numberSectionList.map<DropdownMenuItem<int?>>((value) {
                return DropdownMenuItem<int?>(
                  value: value,
                  child: Text(value.toString() ?? ''),
                );
              }).toList(),
              onChanged: (newVal) {
                AdminCubit.get(context).numberSection = newVal;
                print(AdminCubit.get(context).numberSection);
              },
            );
          },
        );
      },
    );
  }
}
