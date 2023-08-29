import 'package:graduateproject/app_layout/app_cubit/app_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';


class AddUserTypeScreen extends StatelessWidget {
  var userTypeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AppCubit , AppStates>(
            builder: (context, state) {
              return BlocConsumer<AdminCubit,AdminStates>(
                listener: (context, state) {
                  if (state is AddUserTypeSuccessState) {
                    showToast(message: 'Add User Type Success', state: ToastStates.SUCCESS);
                  }
                  if(state is AddUserTypeErrorState){
                    showToast(message: state.error , state: ToastStates.ERROR);
                  }
                },
                builder:(context, state) {
                  return Form(
                    key: formKey,
                    child: Scaffold(
                      appBar: customizedAppBar(
                        function: (){
                          Navigator.pop(context);
                        },
                        title: 'Add User Type ',
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
                                labelText: 'User type name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              controller: userTypeController,
                              validator: (value) => AppCubit.get(context).validateFormField(value, 'user type is required'),
                            ),
                            const SizedBox(height: 30,),
                            ConditionalBuilder(
                              condition: state is! AddUserTypeLoadingState,
                              builder: (context) =>  defaultElevatedButton(
                                borderRadius: 10,
                                width: MediaQuery.of(context).size.width/1.5,
                                text: 'Add User Type',
                                colorText: Colors.white,
                                backGroundColor: defaultColorGreen,
                                function: () {
                                  if(formKey.currentState!.validate()){
                                    Uuid id = const Uuid();
                                    String userTypeId = id.v1();
                                    UserTypeModel userTypeModel = UserTypeModel(
                                      userTypeId: userTypeId,
                                      userTypeName: userTypeController.text,
                                    );
                                    AdminCubit.get(context).createUserType(
                                      userTypeModel: userTypeModel,);
                                    userTypeController.clear();
                                  }
                                },
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),





                          ],
                        ),
                      ),
                    ),
                  );
                },
                );
            },);

  }
}
