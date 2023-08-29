import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';
class AcademicTermsDialog extends StatelessWidget {
  const AcademicTermsDialog({
    Key? key,
  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: AppCubit.get(context)
                .selectedDropDownAcademicTerms
                ?.academicTermsName ??
                ''),
        onTap: () {
          if(AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId == '-1'){
            showToast(message: 'Please select the year', state: ToastStates.ERROR);
          }
          else {

            showCustomDropDownDialog(
                iconFunction: (){
                  AppCubit.get(context).changeAcademicTermClear();
                  maybePop(context);
                },
                context: context,
                title: 'Academic term',
                child: CustomDropDownDialog(
                    actionDropDownList: AppCubit.get(context)
                        .academicTermsList
                        .map((academicTerm) => Column(
                          children: [
                            Container(
                              height: 55,
                      decoration: BoxDecoration(
                              border: (AppCubit.get(
                                  context)
                                  .selectedDropDownAcademicTerms
                                  ?.academicTermsId ??
                                  '') ==
                                  academicTerm
                                      .academicTermsId
                                  ? Border.all(
                                  color: Colors.blue)
                                  : null),
                      child:
                      CustomActionDropDownDialog(
                              title: academicTerm
                                  .academicTermsName ??
                                  '',
                              fontWeight:
                              FontWeight.bold,
                              onTap: () {
                                AppCubit.get(context)
                                    .changeAcademicTerms(
                                    academicTermsModel:
                                    academicTerm);
                                AppCubit.get(context).changeAcademicTermClear();
                                print(academicTerm
                                    .academicTermsId);
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
