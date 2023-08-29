import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogCategoryAddSubCategory extends StatefulWidget {
  const DialogCategoryAddSubCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogCategoryAddSubCategory> createState() => _DialogCategoryAddSubCategoryState();
}

class _DialogCategoryAddSubCategoryState extends State<DialogCategoryAddSubCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit , AdminStates>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {

          return TextFormField(
            readOnly: true,
            decoration: InputDecoration(
                hintText: AppCubit.get(context)
                    .selectedDropDownCategory
                    ?.categoryName ??
                    ''),
            onTap: () async{
              AppCubit.get(context).categoryList.clear();
              await AppCubit.get(context).getCategory().whenComplete(() => showCustomDropDownDialog(
                  iconFunction: () {
                    AppCubit.get(context).changeCategoryClear();
                    maybePop(context);
                  },
                  context: context,
                  title: 'Category',
                  child: CustomDropDownDialog(
                      actionDropDownList: AppCubit.get(context)
                          .categoryList
                          .map((category) => Container(
                        decoration: BoxDecoration(
                            border: (AppCubit.get(context)
                                .selectedDropDownCategory
                                ?.categoryId ??
                                '') ==
                                category.categoryId
                                ? Border.all(
                                color: Colors.blue)
                                : null),
                        child: CustomActionDropDownDialog(
                            title:
                            category.categoryName ??
                                '',
                            fontWeight: FontWeight.bold,
                            onTap: () {
                              AppCubit.get(context)
                                  .changeCategory(categoryModel: category);

                            }
                        ),
                      ))
                          .toList())));
            }
            ,
          );
        });
      },
    );
  }
}
