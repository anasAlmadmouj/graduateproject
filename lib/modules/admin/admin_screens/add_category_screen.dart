import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';

class AddCategoryScreen extends StatelessWidget {
  var categoryNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return BlocConsumer<AdminCubit , AdminStates>(
          listener: (context, state) {
            if(state is AddCategorySuccessState){
              showToast(message: 'Add Category Success', state: ToastStates.SUCCESS);
            }
            if(state is AddCategoryErrorState){
              showToast(message: state.error , state: ToastStates.ERROR);
            }
          },
            builder: (context, state) {
              AdminCubit adminCubit = AdminCubit.get(context);
              return Form(
                key: formKey,
                child: Scaffold(
                  appBar: customizedAppBar(
                    function: (){
                      AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                        departmentName: 'Department',
                        departmentHeadId: '-1',
                        departmentId: '-1',
                      );
                      Navigator.pop(context);
                    },
                    title: 'Add New Category',
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
                            labelText: 'category name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: categoryNameController,
                          validator:(value) => AppCubit.get(context).validateFormField(value, 'name is required'),
                        ),
                        const SizedBox(height: 10,),
                        const DepartmentDialog(),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! AddCategoryLoadingState,
                          builder: (context) =>  defaultElevatedButton(
                            borderRadius: 10,
                            width: MediaQuery.of(context).size.width/1.5,
                            text: 'Add Category',
                            colorText: Colors.white,
                            backGroundColor: defaultColorGreen,
                            function: () {
                              if(AppCubit.get(context).selectedDepartmentDialog?.departmentId == '-1'
                              && formKey.currentState!.validate()){
                                showToast(message: 'Please select department', state: ToastStates.ERROR);
                              }
                              else if(formKey.currentState!.validate()){
                                AdminCubit.get(context).checkIsCategoryAvailable(
                                    categoryName: categoryNameController.text)
                                .then((isSuccess) {
                                  if(!isSuccess){
                                    showToast(message: 'This category exist', state: ToastStates.ERROR);
                                  }
                                  else{
                                    Uuid id = const Uuid();
                                    String categoryId = id.v1();
                                    CategoryModel categoryModel = CategoryModel(
                                      categoryName: categoryNameController.text,
                                      departmentId: AppCubit.get(context)
                                          .selectedDepartmentDialog
                                          ?.departmentId,
                                      categoryId: categoryId,
                                    );
                                    adminCubit.createCategory(
                                        categoryModel: categoryModel);
                                    categoryNameController.clear();
                                    AppCubit.get(context).selectedDepartmentDialog = DepartmentModel(
                                      departmentName: 'Department',
                                      departmentHeadId: '-1',
                                      departmentId: '-1',
                                    );
                                  }
                                });
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
            },);
      },
    );
  }
}
