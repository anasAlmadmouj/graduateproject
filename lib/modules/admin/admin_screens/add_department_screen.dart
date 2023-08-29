import 'package:graduateproject/models/users_model/users_model.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dilogs_add_department/dialog_users_add_department.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';



class AddDepartmentScreen extends StatelessWidget {
  var departmentNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
       if(state is AddDepartmentSuccessState){
         showToast(message: 'Add Department Success', state: ToastStates.SUCCESS);
       }
       if(state is AddDepartmentErrorState){
         showToast(message: state.error , state: ToastStates.ERROR);
       }
      },
      builder: (context, state) {
        return BlocBuilder<AppCubit , AppStates>(
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Scaffold(
                    appBar: customizedAppBar(
                      function: (){
                        AdminCubit.get(context).selectedDropDownUsers = UsersModel(
                            userName: ' users',
                            userId: '-1',
                            departmentId: '-1',
                            userTypeId: '-1',
                            userEmail: '-1'
                        );
                        Navigator.pop(context);
                      },
                      title: 'Add New Department',
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
                                labelText: 'Department name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              controller: departmentNameController,
                              validator: (value) => AppCubit.get(context).validateFormField(value, 'name is required'),
                          ),
                          // const SizedBox(height: 15,),
                          // const DialogUsersAddDepartment(),
                          const SizedBox(height: 30,),
                          ConditionalBuilder(
                            condition: state is! AddDepartmentLoadingState,
                            builder: (context) =>  defaultElevatedButton(
                              width: MediaQuery.of(context).size.width/1.5,
                              text: 'Add Department',
                              colorText: Colors.white,
                              backGroundColor: defaultColorGreen,
                              function: () {
                                if(formKey.currentState!.validate()){
    AdminCubit.get(context).checkIsDepartmentAvailable(
    departmentName: departmentNameController.text)
        .then((isSuccess) {
      if (!isSuccess) {
        showToast(message: 'This department already exist', state: ToastStates.ERROR);
        AdminCubit.get(context).selectedDropDownUsers = UsersModel(
            userName: ' users',
            userId: '-1',
            departmentId: '-1',
            userTypeId: '-1',
            userEmail: '-1'
        );
        departmentNameController.clear();
      }
      else{
        Uuid id = const Uuid();
        String departmentId = id.v1();
        DepartmentModel departmentModel = DepartmentModel(
          departmentName: departmentNameController.text,
          departmentId: departmentId,
        );
        AdminCubit.get(context).createDepartment(
            departmentModel: departmentModel);
        AdminCubit.get(context).selectedDropDownUsers = UsersModel(
            userName: ' users',
            userId: '-1',
            departmentId: '-1',
            userTypeId: '-1',
            userEmail: '-1'
        );
        departmentNameController.clear();
      }

    });

                                }
                              },
                            ),
                            fallback: (context) => const CircularProgressIndicator(),
                          ),




                        ],
                      ),
                    ),
                  ),
                );
              },);
        },);
  }
}
