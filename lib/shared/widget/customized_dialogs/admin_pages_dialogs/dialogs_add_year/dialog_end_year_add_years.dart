import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogEndYearAddYear extends StatefulWidget {
  const DialogEndYearAddYear({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogEndYearAddYear> createState() => _DialogEndYearAddYearState();
}

class _DialogEndYearAddYearState extends State<DialogEndYearAddYear> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit,AdminStates>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
          return TextFormField(
            decoration: InputDecoration(
              hintText: AdminCubit.get(context).endDateTime == DateTime(-1) ?
              'Select end year'
                  : AdminCubit.get(context).endDateTime.year.toString(),
            ),
            readOnly: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Year'),
                    content: Container( // Need to use container to add size constraint.
                      width: 300,
                      height: 300,
                      child: YearPicker(
                        firstDate: DateTime(DateTime.now().year - 100, 1),
                        lastDate: DateTime(DateTime.now().year + 100, 1),
                        initialDate: DateTime.now(),
                        selectedDate: DateTime.now(),
                        onChanged: (DateTime dateTime) {
                          // close the dialog when year is selected.
                          setState(() {
                            AdminCubit.get(context).endDateTime = dateTime;
                          });
                          Navigator.pop(context);

                          // Do something with the dateTime selected.
                          // Remember that you need to use dateTime.year to get the year
                        },
                      ),
                    ),
                  );
                },
              );


              // DateTime initialDate = AdminCubit.get(context).endDateTime ?? DateTime.now();
              //
              // showDatePicker(
              //   context: context,
              //   initialDate: initialDate,
              //   firstDate: DateTime(DateTime.now().year - 100, 1),
              //   lastDate: DateTime(DateTime.now().year + 100, 12),
              //   initialDatePickerMode: DatePickerMode.year,
              // ).then((value) {
              //   if (value != null) {
              //     setState(() {
              //       DateTime endDateTime = DateTime(value.year);
              //       AdminCubit.get(context).endDateTime = endDateTime;
              //     });
              //     // Set the selected year, month, and day to the startDateTime.
              //
              //   }
              // });

              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: Text('Select Year'),
              //       content: Container( // Need to use container to add size constraint.
              //         width: 300,
              //         height: 300,
              //         child: YearPicker(
              //           firstDate: DateTime(DateTime.now().year - 100, 1),
              //           lastDate: DateTime(DateTime.now().year + 100, 1),
              //           initialDate: DateTime.now(),
              //           // save the selected date to _selectedDate DateTime variable.
              //           // It's used to set the previous selected date when
              //           // re-showing the dialog.
              //           selectedDate: AdminCubit.get(context).endDateTime,
              //           onChanged: (DateTime dateTime) {
              //             // close the dialog when year is selected.
              //             AdminCubit.get(context).anasTest = '${AdminCubit.get(context).endDateTime}';
              //             Navigator.pop(context);
              //
              //             // Do something with the dateTime selected.
              //             // Remember that you need to use dateTime.year to get the year
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // );



              // showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now() ?? DateTime(2021),
              //   firstDate: DateTime(2021),
              //   lastDate: DateTime(2025),
              // ).then((value) {
              //   AdminCubit.get(context).endDateTime = value;
              //   AdminCubit.get(context).anasTest = value != null
              //       ? Timestamp.fromDate(value).toString()
              //       : null;
              // });
            },
          );
        });
      },
    );

  }
}
