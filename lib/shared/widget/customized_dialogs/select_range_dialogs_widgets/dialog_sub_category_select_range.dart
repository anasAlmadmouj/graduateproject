import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
class DialogSubCategorySelectRange extends StatelessWidget {
  const DialogSubCategorySelectRange({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: AppCubit.get(context).selectedDropDownSubCategory
                  ?.categoryId == ['-1'] ?
              'Selected sub category'
                  : AppCubit
                  .get(context)
                  .selectedDropDownSubCategory
                  ?.subCategoryName.join()
          ),
          onTap: () {
            if(AppCubit.get(context).
            selectedDropDownCategory?.categoryId == '-1') {
              showToast(message: 'Please select category',
                  state: ToastStates.ERROR);
            }
            else if(AppCubit.get(context).subCategoryList.isEmpty){
              showToast(message: 'Don\'t have sub category',
                  state: ToastStates.ERROR);
            }
            else {
              showCustomDropDownDialog(
                  iconFunction: () {
                    maybePop(context);
                  },
                  context: context,
                  title: 'Sub category',
                  child: CustomDropDownDialog(
                      actionDropDownList:
                      AppCubit
                          .get(context)
                          .subCategoryList
                          .map((subCategory) =>
                          Column(
                            children: [
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    border: (AppCubit
                                        .get(
                                        context)
                                        .selectedDropDownSubCategory
                                        ?.subCategoryId ??
                                        '') ==
                                        subCategory
                                            .subCategoryId
                                        ? Border.all(
                                        color: Colors.blue)
                                        : null),
                                child:
                                CustomActionDropDownDialog(
                                    title: subCategory
                                        .subCategoryName[0] ??
                                        '',
                                    fontWeight:
                                    FontWeight.bold,
                                    onTap: () {
                                      AppCubit.get(context)
                                          .changeSubCategory(
                                          subCategoryModel:
                                          subCategory);
                                    }),
                              ),
                              Divider(),
                            ],
                          ))
                          .toList()
                  ));
            }
          },
        );
      }
    );
  }
}
