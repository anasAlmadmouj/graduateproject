import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogStartYearAddYear extends StatefulWidget {
  const DialogStartYearAddYear({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogStartYearAddYear> createState() => _DialogStartYearAddYearState();
}

class _DialogStartYearAddYearState extends State<DialogStartYearAddYear> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit,AdminStates>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
          return TextFormField(
            decoration: InputDecoration(
              hintText: AdminCubit.get(context).startDateTime == DateTime(-1) ?
              'Select start year'
                  : AdminCubit.get(context).startDateTime.year.toString(),
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
                            AdminCubit.get(context).startDateTime = dateTime;
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


              // showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime(2021),
              //   lastDate: DateTime(2025),
              // ).then((value) {
              //   AdminCubit.get(context).startDateTime = value;
              //   AdminCubit.get(context).startDate = value != null
              //       ? Timestamp.fromDate(value)
              //       : null;
              // });
            },
          );
        });
      },
    );

  }
}
