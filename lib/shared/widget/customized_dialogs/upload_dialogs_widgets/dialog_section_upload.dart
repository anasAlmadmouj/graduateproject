import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
class DialogSectionUpload extends StatelessWidget {
  const DialogSectionUpload({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        return
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: AppCubit.get(context)
                  .selectedDropDownSection
                  ?.sectionName ??
                  ''),
          onTap: () {


            if(CacheHelper.getData(key: spUserType) == userTypeAdmin){
              if(AppCubit.get(context).selectedDropDownSubjectTerm?.subjectTermId == '-1'){
                showToast(message: 'Please select subject'
                  , state: ToastStates.ERROR,);
            }
              else if(AppCubit.get(context).sectionList.isEmpty){
                showToast(message: 'Dont\'t have sections yet'
                  , state: ToastStates.ERROR,);
              }
              else {
                showCustomDropDownDialog(
                    iconFunction: (){
                      maybePop(context);
                    },
                    context: context,
                    title: 'Section',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit.get(context)
                            .sectionList
                            .map((section) => Container(
                          decoration: BoxDecoration(
                              border: (AppCubit.get(
                                  context)
                                  .selectedDropDownSection
                                  ?.sectionId ??
                                  '') ==
                                  section
                                      .sectionId
                                  ? Border.all(
                                  color: Colors.blue)
                                  : null),
                          child:
                          CustomActionDropDownDialog(
                              title: section
                                  .sectionName ??
                                  '',
                              fontWeight:
                              FontWeight.bold,
                              onTap: () {
                                AppCubit.get(context)
                                    .changeSection(
                                    sectionModel:
                                    section);
                              }),
                        ))
                            .toList()));
              }
            }
            else{
              if(AppCubit.get(context).selectedDropDownSubject?.subjectTermId == '-1'){
                showToast(message: 'Please select subject'
                  , state: ToastStates.ERROR,);
              }
              else if(AppCubit.get(context).sectionList.isEmpty){
                showToast(message: 'Dont\'t have sections yet'
                  , state: ToastStates.ERROR,);
              }
              else {
                showCustomDropDownDialog(
                    iconFunction: (){
                      maybePop(context);
                    },
                    context: context,
                    title: 'Section',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit.get(context)
                            .sectionList
                            .map((section) => Container(
                          decoration: BoxDecoration(
                              border: (AppCubit.get(
                                  context)
                                  .selectedDropDownSection
                                  ?.sectionId ??
                                  '') ==
                                  section
                                      .sectionId
                                  ? Border.all(
                                  color: Colors.blue)
                                  : null),
                          child:
                          CustomActionDropDownDialog(
                              title: section
                                  .sectionName ??
                                  '',
                              fontWeight:
                              FontWeight.bold,
                              onTap: () {
                                AppCubit.get(context)
                                    .changeSection(
                                    sectionModel:
                                    section);
                              }),
                        ))
                            .toList()));
              }
            }
          },
        );
      }
    );
  }
}
