import 'package:graduateproject/app_layout/app_cubit/app_cubit_imports.dart';
import 'package:graduateproject/models/subjects_model/subjects_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';


class AddSubjectScreen extends StatefulWidget {
  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
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
                      AppCubit.get(context).selectedDepartmentDialog =  DepartmentModel(
                        departmentName: 'Department',
                        departmentHeadId: '-1',
                        departmentId: '-1',
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
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name of subject',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            controller: subjectController,
                            validator: (value) => AppCubit.get(context)
                                .validateFormField(value, 'name is required')
                        ),
                        const SizedBox(
                          height: 10,
                        ), // name subject
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Number of subject',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: numberSubjectController,
                          validator: (value) => AppCubit.get(context)
                              .validateFormField(value, 'name is required'),
                        ),  // number subject
                        const SizedBox(
                          height: 10,
                        ),
                        const DepartmentDialog(),
                        const SizedBox(
                          height: 30,
                        ),
                        adminState is AddSubjectLoadingState ?
                         Center(child: const CircularProgressIndicator())
                        : defaultElevatedButton(
                             backGroundColor: defaultColorGreen,
                             text: 'Add Subject',
                             width: MediaQuery.of(context).size.width / 1.5,
                             function: () {
                                if(AppCubit.get(context).selectedDepartmentDialog?.departmentId == '-1'
                                   && formKey.currentState!.validate()){
                                 showToast(message: 'Please select department', state: ToastStates.ERROR);
                               }
                               else if (formKey.currentState!.validate()) {
                                 AdminCubit.get(context).checkIsSubjectAvailable(
                                     subjectNumber: numberSubjectController.text).then((isSuccess) {
                                       if(!isSuccess){
                                         showToast(message: 'this number of subject already exist', state: ToastStates.ERROR);
                                         AppCubit.get(context).selectedDepartmentDialog =  DepartmentModel(
                                           departmentName: 'Department',
                                           departmentHeadId: '-1',
                                           departmentId: '-1',
                                         );
                                         subjectController.clear();
                                         numberSubjectController.clear();
                                       }
                                       else{
                                         Uuid id = const Uuid();
                                         String subjectId = id.v1();
                                         SubjectsModel subjectsModel = SubjectsModel(
                                           subjectName: subjectController.text,
                                           subjectId: subjectId,
                                           departmentId: AppCubit.get(context)
                                               .selectedDepartmentDialog
                                               ?.departmentId ??
                                               '',
                                           numberSubject:
                                           numberSubjectController.text,
                                         );
                                         AdminCubit.get(context).createSubject(
                                           subjectsModel: subjectsModel,
                                         );
                                         for(int i=1 ; i<=(AdminCubit.get(context).numberSection ??0) ; i++){
                                           Uuid idSec = const Uuid();
                                           String sectionId = idSec.v1();
                                           SectionModel sectionModel = SectionModel(
                                             subjectId: subjectId,
                                             sectionId: sectionId,
                                             sectionName: 'section $i',
                                           );
                                           AdminCubit.get(context)
                                               .createSection(sectionModel: sectionModel);
                                         }
                                         AppCubit.get(context).selectedDepartmentDialog =  DepartmentModel(
                                           departmentName: 'Department',
                                           departmentHeadId: '-1',
                                           departmentId: '-1',
                                         );
                                         subjectController.clear();
                                         numberSubjectController.clear();
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

