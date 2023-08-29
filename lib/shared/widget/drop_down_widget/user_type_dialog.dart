import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class UserTypeDialog extends StatelessWidget {
  const UserTypeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: AppCubit.get(context)
                .selectedDropDownUserType
                ?.userTypeName ??
                ''),
        onTap: () {
          AppCubit.get(context).userTypeList.clear();
           AppCubit.get(context).getUserType().whenComplete(() => showCustomDropDownDialog(
               iconFunction: (){
                 maybePop(context);
               },
               context: context,
               title: 'User type',
               child: CustomDropDownDialog(
                   actionDropDownList: AppCubit.get(context)
                       .userTypeList
                       .map((userType) => Container(
                     decoration: BoxDecoration(
                         border: (AppCubit.get(
                             context)
                             .selectedDropDownUserType
                             ?.userTypeId ??
                             '') ==
                             userType
                                 .userTypeId
                             ? Border.all(
                             color: Colors.blue)
                             : null),
                     child:
                     CustomActionDropDownDialog(
                         title: userType
                             .userTypeName ??
                             '',
                         fontWeight:
                         FontWeight.bold,
                         onTap: () {
                           AppCubit.get(context)
                               .changeUserType(
                               userTypeModel:
                               userType);
                         }),
                   ))
                       .toList())));
        },
      );
    });
  }
}
