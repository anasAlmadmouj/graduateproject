import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogYearsAddTerm extends StatelessWidget {
  const DialogYearsAddTerm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit , AdminStates>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return TextFormField(
                readOnly: true,
                decoration: InputDecoration(

                    hintText:  AppCubit.get(context)
                        .selectedDropDownAcademicYears
                        ?.academicYearsId == '-1' ?
                    'Selected year'
                        : AppCubit
                        .get(context)
                        .selectedDropDownAcademicYears
                        ?.academicYearsNumber
                        .join('/')
                        .toString()
                ),
                onTap: () {
                  AppCubit.get(context).academicYearsList.clear();
                  AppCubit.get(context).getAcademicYears().whenComplete(() => showCustomDropDownDialog(
                      iconFunction: (){
                        AppCubit.get(context).changeAcademicYearClear();
                        maybePop(context);
                      },
                      context: context,
                      title: 'Academic year',
                      child: CustomDropDownDialog(
                          actionDropDownList: AppCubit.get(context)
                              .academicYearsList
                              .map((academicYear) => Container(
                            decoration: BoxDecoration(
                                border: (AppCubit.get(
                                    context)
                                    .selectedDropDownAcademicYears
                                    ?.academicYearsId ??
                                    '') ==
                                    academicYear
                                        .academicYearsId
                                    ? Border.all(
                                    color: Colors.blue)
                                    : null),
                            child:
                            CustomActionDropDownDialog(
                                title: academicYear
                                    .academicYearsNumber.join('/').toString() ??
                                    '',
                                fontWeight:
                                FontWeight.bold,
                                onTap: () {
                                  AppCubit.get(context)
                                      .changeAcademicYears(
                                      academicYearsModel:
                                      academicYear);
                                }),
                          ))
                              .toList())));
                },
              );
            });
      },
    );

  }
}
