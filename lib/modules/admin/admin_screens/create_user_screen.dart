import 'package:graduateproject/app_layout/app_layout_imports.dart';
import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/modules/login/cubit/login_states.dart';

class CreateUserScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var universityIdController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state,) {
        if (state is CreateUserSuccessState) {
          showToast(message: 'Create Account Success', state: ToastStates.SUCCESS);
        }

        if(state is CreateUserErrorState){
          showToast(message: state.error , state: ToastStates.ERROR);
        }
      },
      builder: (context, state,) {
        return BlocBuilder<LoginCubit,LoginStates>(
          builder: (context, state) {
            return BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                return Scaffold(
                  appBar: customizedAppBar(
                    function: (){
                      AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                        departmentName: 'Department',
                        departmentHeadId: '-1',
                        departmentId: '-1',
                      );
                      AppCubit.get(context).selectedDropDownUserType =  UserTypeModel(
                        userTypeName: 'User Type',
                        userTypeId: '-1',
                      );
                      Navigator.pop(context);
                    },
                    title: 'Create User',
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0 , right: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    child: Image.asset('assets/images/LogoFinal.jpg' , fit: BoxFit.fill),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Create New ',
                                        style: TextStyle(
                                          color: defaultColorGreen ,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('Account ',
                                        style: TextStyle(
                                          color: defaultColorGreen ,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              defaultTextFormField(
                                labelText: 'Name',
                                controller: nameController,
                                validation: (value) =>
                                    AppCubit.get(context).validateFormField(value, 'name is required'),
                              ),
                              const SizedBox(height: 10,),
                              defaultTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                labelText: 'Email',
                                prefixIcon: Icons.email,
                                controller: emailController,
                                validation: (value) => AppCubit.get(context).validateFormField(value, 'email is required'),
                              ),
                              const SizedBox(height: 10,),
                              defaultTextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: LoginCubit
                                      .get(context)
                                      .suffixIcon,
                                  labelText: 'password',
                                  controller: passwordController,
                                  obscureText: LoginCubit
                                      .get(context)
                                      .isPassword,
                                  validation: (value) =>
                                      AppCubit.get(context).validateFormField(value, 'password is required'),
                                  suffixPressed: () {
                                    LoginCubit.get(context).visiblePassword();
                                  }
                              ),
                              const DepartmentDialog(),
                              const SizedBox(height: 10,),
                              const UserTypeDialog(),
                              const SizedBox(height: 20,),
                              ConditionalBuilder(
                                condition: state is! CreateUserLoadingState,
                                builder: (context) =>  defaultElevatedButton(
                                    width: double.infinity,
                                    text: 'Create User',
                                    backGroundColor: defaultColorGreen,
                                    colorText: defaultColorGray,
                                    function: () async {
                                      if(AppCubit.get(context).selectedDepartmentDialog?.departmentId == '-1'
                                      && formKey.currentState!.validate()){
                                        showToast(message: 'Please select department', state: ToastStates.ERROR);
                                      }

                                      else if(AppCubit.get(context).selectedDropDownUserType?.userTypeId == '-1'
                                          && formKey.currentState!.validate()){
                                        showToast(message: 'Please select user type', state: ToastStates.ERROR);
                                      }
                                      else if (formKey.currentState!.validate()) {
                                        await AdminCubit.get(context).registerUser(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          universityId: universityIdController.text,
                                          userTypeId: AppCubit.get(context).selectedDropDownUserType!.userTypeId.toString(),
                                          departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId ?? '',
                                        );
                                        if(AppCubit.get(context).selectedDropDownUserType?.userTypeName == 'Head Department'){
                                          AdminCubit.get(context).updateHeadDepartment(
                                              departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId,
                                              departmentHeadId: AdminCubit.get(context).headDepartmentId);
                                        }
                                        AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                                          departmentName: 'Department',
                                          departmentHeadId: '-1',
                                          departmentId: '-1',
                                        );
                                        AppCubit.get(context).selectedDropDownUserType =  UserTypeModel(
                                          userTypeName: 'User Type',
                                          userTypeId: '-1',
                                        );
                                        nameController.clear();
                                        emailController.clear();
                                        passwordController.clear();
                                      }
                                    }
                                ),
                                fallback: (context) => const CircularProgressIndicator(),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },);
          },
        );
      },

    );
  }
}
