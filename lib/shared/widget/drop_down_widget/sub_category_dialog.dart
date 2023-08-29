import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';

class SubCategoryDialog extends StatelessWidget {
  const SubCategoryDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: AppCubit.get(context)
                  .selectedDropDownSubCategory
                  ?.subCategoryName[0] ??
                  ''),
          onTap: () {
            if(AppCubit.get(context).
            selectedDropDownCategory?.categoryId == '-1') {
              showToast(message: 'Please select Category',
                  state: ToastStates.ERROR);
            }
            else {
              showCustomDropDownDialog(
                iconFunction: (){
                  maybePop(context);
                },
                context: context,
                title: 'Sub category',
                child: CustomDropDownDialog(
                    actionDropDownList: AppCubit.get(context)
                        .subCategoryList
                        .map((subCategory) => Column(
                          children: [
                            Container(
                      height: 55,
                      decoration: BoxDecoration(
                              border: (AppCubit.get(
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
                        .toList()));
            }
          },
        );
    });
  }
}
// class DropDownSubCategory extends StatelessWidget {
//   const DropDownSubCategory({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
//       if (AppCubit.get(context).categoryList.isNotEmpty || AppCubit.get(context).subCategoryList.isNotEmpty) {
//         return DropdownButtonFormField<SubCategoryModel?>(
//         validator: (value) => AppCubit.get(context).validateDropDown(value, 'category is required'),
//         isExpanded: true,
//         hint: Text(AppCubit.get(context)
//             .selectedDropDownSubCategory
//             ?.subCategoryName ??
//             ''),
//         // value: HrAppCubit.get(context).selectedDropDownDepartment,
//         onChanged: (SubCategoryModel? newValue) {
//           AppCubit.get(context)
//               .changeSubCategory(subCategoryModel: newValue);
//         },
//         items: AppCubit.get(context)
//             .subCategoryList
//             .map<DropdownMenuItem<SubCategoryModel?>>((value) {
//           return DropdownMenuItem<SubCategoryModel?>(
//             value: value,
//             child: Text(value.subCategoryName ?? ''),
//           );
//         }).toList(),
//       );
//       } else {
//         return const SizedBox();
//       }
//     });
//   }
// }
