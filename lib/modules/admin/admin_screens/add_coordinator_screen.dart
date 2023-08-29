import 'package:graduateproject/models/users_model/users_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_Add_coordinator/dialog_subject_add_coordinator.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_Add_coordinator/dialog_term_add_coordinator.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_Add_coordinator/dialog_users.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_Add_coordinator/dialog_year_add_coordinator.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_sub_category/dialog_department_add_sebject_coordinator.dart';
import  'package:graduateproject/models/subjects_terms_model/subjects_terms_model.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';


class AddCoordinatorScreen extends StatefulWidget {
  const AddCoordinatorScreen({super.key});

  @override
  State<AddCoordinatorScreen> createState() => _AddCoordinatorScreenState();
}

class _AddCoordinatorScreenState extends State<AddCoordinatorScreen> {
  var sectionController = TextEditingController();
  String? selectedSectionValue;
  bool? isCoordinator = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, appState) {
        return BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, adminState) {
            if(adminState is CreateSubjectCoordinatorSuccessState){
              showToast(message: 'Add coordinator success', state: ToastStates.SUCCESS);
            }
            if(adminState is CreateSubjectCoordinatorErrorState){
              showToast(message: adminState.error, state: ToastStates.ERROR);
            }
          },
          builder: (context, adminState) {
            return Form(
              key: formKey,
              child: Scaffold(
                appBar: customizedAppBar(
                  function: () {
                    AppCubit.get(context).selectedDropDownAcademicYears = AcademicYearsModel(
                      academicYearsNumber: [],
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
                    AppCubit.get(context).selectedDropDownSubjectTerm = SubjectTermModel(
                      academicTermId: '-1',
                      subjectName: 'subject',
                      subjectId: '-1',
                      subjectTermId: '-1',
                      departmentId: '-1',
                      subjectCoordinator: '',
                      subjectNumber: '-1',
                    );
                    AppCubit.get(context).selectedDropDownUserSubject = UsersModel(
                      userName: 'Coordinator',
                      userId: '-1',
                      userTypeId: '-1',
                      departmentId: '-1',
                      userEmail: '-1',
                    );
                    Navigator.pop(context);
                  },
                  title: 'Add Coordinator',
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const LogoAddingPages(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogYearsAddCoordinator(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogTermAddTerm(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogDepartmentAddSubjectCoordinator(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogSubjectAddTerm(), //Subject Term
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogUsers(),    //users
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: adminState is! CreateSubjectCoordinatorLoadingState,
                        builder: (context) =>
                            defaultElevatedButton(
                                backGroundColor: defaultColorGreen,
                                borderRadius: 10,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.5,
                                text: 'Add coordinator',
                                function: () {
                                  if(AppCubit.get(context).selectedDropDownSubjectTerm?.subjectTermId == '-1'){
                                    showToast(message: 'Please select the subject', state: ToastStates.ERROR);
                                  }

                                  else if(AppCubit.get(context).selectedDropDownUserSubject?.userId == '-1'){
                                    showToast(message: 'Please select coordinator', state: ToastStates.ERROR);
                                  }

                                  else {
                                    AdminCubit.get(context)
                                        .createCoordinatorToSubject(
                                        subjectTermId: AppCubit.get(context)
                                            .selectedDropDownSubjectTerm?.subjectTermId ?? '',
                                      subjectCoordinator: AppCubit.get(context)
                                          .selectedDropDownUserSubject?.userId ?? '-1',
                                    );

                                    AppCubit.get(context).selectedDropDownAcademicYears = AcademicYearsModel(
                                      academicYearsNumber: [],
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
                                    AppCubit.get(context).selectedDropDownSubjectTerm = SubjectTermModel(
                                      academicTermId: '-1',
                                      subjectName: 'subject',
                                      subjectId: '-1',
                                      subjectTermId: '-1',
                                      departmentId: '-1',
                                      subjectCoordinator: '',
                                      subjectNumber: '-1',
                                    );
                                    AppCubit.get(context).selectedDropDownUserSubject = UsersModel(
                                      userName: 'Coordinator',
                                      userId: '-1',
                                      userTypeId: '-1',
                                      departmentId: '-1',
                                      userEmail: '-1',
                                    );
                                }
                                }),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
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
