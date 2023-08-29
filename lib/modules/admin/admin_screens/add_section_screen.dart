import 'package:graduateproject/models/section/section_model.dart';
import 'package:graduateproject/models/users_model/users_model.dart';
import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_section/dialog_department_add_section.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_section/dialog_section_add_section.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_section/dialog_subject_add_section.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_section/dialog_term_add_section.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_section/dialog_users_add_section.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_section/dialog_year_add_section.dart';
import  'package:graduateproject/models/subjects_terms_model/subjects_terms_model.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';


class AddSectionScreen extends StatefulWidget {
  const AddSectionScreen({super.key});

  @override
  State<AddSectionScreen> createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  var sectionController = TextEditingController();
  String? selectedSectionValue;
  bool? isCoordinator = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AddSectionSuccessState) {
          showToast(message: 'Add Section Success', state: ToastStates.SUCCESS);
        }

        if (state is AddSectionErrorState) {
          showToast(message: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Scaffold(
                appBar: customizedAppBar(
                  function: () {
                    AppCubit.get(context).selectedDropDownAcademicYears = AcademicYearsModel(
                      academicYearsNumber: [-1],
                      academicYearsId: '-1',
                    );
                    AppCubit.get(context).selectedDropDownAcademicTerms =  AcademicTermsModel(
                      academicTermsName: 'academic term',
                      academicYearsId: '-1',
                      academicTermsId: '-1',
                    );
                    AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                      departmentName: 'Department',
                      departmentHeadId: '-1',
                      departmentId: '-1',
                    );
                    AppCubit.get(context).selectedDropDownSubjectTerm =  SubjectTermModel(
                      academicTermId: '-1',
                      subjectName: 'subject',
                      subjectId: '-1',
                      subjectTermId: '-1',
                      departmentId: '-1',
                      subjectCoordinator: '',
                      subjectNumber: '-1',
                    );
                    AppCubit.get(context).selectedDropDownSection = SectionModel(
                      sectionName: sectionCollection,
                      subjectId: '-1',
                      userId: '-1',
                      sectionId: '-1',
                    );
                    AdminCubit.get(context).selectedDropDownUsers = UsersModel(
                        userName: ' users',
                        userId: '-1',
                        departmentId: '-1',
                        userTypeId: '-1',
                        userEmail: '-1');
                    Navigator.pop(context);
                  },
                  title: 'Add New Section',
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const LogoAddingPages(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogYearsAddSection(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogTermAddSection(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogDepartmentAddSection(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogSubjectAddSection(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogSectionAddSection(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogUsersAddSection(),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! AddSectionLoadingState,
                        builder: (context) =>
                            defaultElevatedButton(
                                backGroundColor: defaultColorGreen,
                                borderRadius: 10,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.5,
                                text: 'Add Section',
                                function: () {
                                  if(AppCubit.get(context).selectedDropDownSubjectTerm?.subjectTermId == '-1'
                                      && formKey.currentState!.validate()){
                                    showToast(message: 'Please select subject', state: ToastStates.ERROR);
                                  }
                                  else if(AppCubit.get(context).selectedDropDownSection?.sectionId == '-1'
                                      && formKey.currentState!.validate()){
                                    showToast(message: 'Please select section', state: ToastStates.ERROR);
                                  }
                                  else if(AdminCubit.get(context).selectedDropDownUsers?.userId == '-1'
                                      && formKey.currentState!.validate()){
                                    showToast(message: 'Please select user', state: ToastStates.ERROR);
                                  }
                                  else if (formKey.currentState!.validate()) {
                                    AdminCubit.get(context).updateSection(
                                      sectionId:AppCubit.get(context).selectedDropDownSection?.sectionId,
                                      userId: AdminCubit.get(context).selectedDropDownUsers?.userId,);
                                    AppCubit.get(context).selectedDropDownAcademicYears = AcademicYearsModel(
                                      academicYearsNumber: [-1],
                                      academicYearsId: '-1',
                                    );
                                    AppCubit.get(context).selectedDropDownAcademicTerms =  AcademicTermsModel(
                                      academicTermsName: 'academic term',
                                      academicYearsId: '-1',
                                      academicTermsId: '-1',
                                    );
                                    AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                                      departmentName: 'Department',
                                      departmentHeadId: '-1',
                                      departmentId: '-1',
                                    );
                                    AppCubit.get(context).selectedDropDownSubjectTerm =  SubjectTermModel(
                                      academicTermId: '-1',
                                      subjectName: 'subject',
                                      subjectId: '-1',
                                      subjectTermId: '-1',
                                      departmentId: '-1',
                                      subjectCoordinator: '',
                                      subjectNumber: '-1',
                                    );
                                    AppCubit.get(context).selectedDropDownSection = SectionModel(
                                      sectionName: sectionCollection,
                                      subjectId: '-1',
                                      userId: '-1',
                                      sectionId: '-1',
                                    );
                                    AdminCubit.get(context).selectedDropDownUsers = UsersModel(
                                        userName: ' users',
                                        userId: '-1',
                                        departmentId: '-1',
                                        userTypeId: '-1',
                                        userEmail: '-1');
                                  }
                                }),
                        fallback: (context) =>
                        const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
