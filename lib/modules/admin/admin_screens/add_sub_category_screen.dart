import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_sub_category/dialog_category_add_sub_category.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';

class AddSubCategoryScreen extends StatelessWidget {
  final subCategoryController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AddSubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AddSubCategorySuccessState) {
          showToast(message: 'Add Sub Category Success', state: ToastStates.SUCCESS);
        }

        if(state is AddSubCategoryErrorState){
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
                      AppCubit.get(context).selectedDropDownCategory = CategoryModel(
                        categoryName: 'Category',
                        categoryId: '-1',
                        departmentId: '-1',
                      );
                      Navigator.pop(context);
                    },
                    title: 'Add Sub Category',
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
                            labelText: 'Sub category name',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                          ),
                          controller: subCategoryController,
                          validator: (value) => AppCubit.get(context).validateFormField(value, 'category is required'),
                        ),
                        const SizedBox(height: 10,),
                        const DialogCategoryAddSubCategory(),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! AddSubCategoryLoadingState,
                          builder: (context) =>  defaultElevatedButton(
                            borderRadius: 10,
                            width: MediaQuery.of(context).size.width/1.5,
                            text: 'Add Sub Category',
                            colorText: Colors.white,
                            backGroundColor: defaultColorGreen,
                            function: () {
                              if(AppCubit.get(context).selectedDropDownCategory?.categoryId == '-1'
                              && formKey.currentState!.validate()){
                                showToast(message: 'Please select category', state: ToastStates.ERROR);
                              }
                              else if(formKey.currentState!.validate()){
                                AdminCubit.get(context).checkIsSubCategoryAvailable(
                                    categoryId: AppCubit.get(context).selectedDropDownCategory?.categoryId,
                                    subCategoryName: subCategoryController.text).then((isSuccess) {
                                      if(!isSuccess){
                                        showToast(message: 'The sub category already exist in this category',
                                            state: ToastStates.ERROR);
                                      }
                                      else{
                                        Uuid id = const Uuid();
                                        String subCategoryId = id.v1();
                                        SubCategoryModel subCategoryModel =
                                        SubCategoryModel(
                                          categoryId: AppCubit.get(context)
                                              .selectedDropDownCategory!
                                              .categoryId,
                                          subCategoryId: subCategoryId,
                                          subCategoryName: [subCategoryController.text],
                                        );
                                        AdminCubit.get(context).createSubCategory(
                                          subCategoryModel: subCategoryModel,
                                        );
                                        subCategoryController.clear();
                                        AppCubit.get(context).selectedDropDownCategory = CategoryModel(
                                          categoryName: 'Category',
                                          categoryId: '-1',
                                          departmentId: '-1',
                                        );
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
      },
    );
  }
}
