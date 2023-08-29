import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_year/dialog_end_year_add_years.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_year/dialog_start_year_add_years.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';

class AddAcademicYearsScreen extends StatefulWidget {
  @override
  State<AddAcademicYearsScreen> createState() => _AddAcademicYearsScreenState();
}

class _AddAcademicYearsScreenState extends State<AddAcademicYearsScreen> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state) {
            if (state is AddAcademicYearsSuccessState) {
              showToast(
                  message: 'Add New Year Success', state: ToastStates.SUCCESS);
            }
            if (state is AddAcademicYearsErrorState) {
              showToast(message: state.error, state: ToastStates.ERROR);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Scaffold(
                appBar: customizedAppBar(
                  function: () {
                    AdminCubit.get(context).startDateTime = DateTime(-1);
                    AdminCubit.get(context).endDateTime = DateTime(-1);
                    Navigator.pop(context);
                  },
                  title: 'Add New Year',
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const LogoAddingPages(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogStartYearAddYear(),    //select start year
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogEndYearAddYear(),     //select end year
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! AddAcademicYearsLoadingState,
                        builder: (context) => defaultElevatedButton(
                          borderRadius: 10,
                          width: MediaQuery.of(context).size.width / 1.5,
                          text: 'Add new year',
                          colorText: Colors.white,
                          backGroundColor: defaultColorGreen,
                          function: () async {
                            if(AdminCubit.get(context).startDateTime == DateTime(-1)){
                              showToast(message: 'Please select start year', state: ToastStates.ERROR);
                            }
                            else if(AdminCubit.get(context).endDateTime == DateTime(-1)){
                              showToast(message: 'Please select end year', state: ToastStates.ERROR);
                            }
                            else{
                              await AdminCubit.get(context).checkIsYearAvailable().then((isSuccess) {
                                if(!isSuccess){
                                  showToast(message: 'This year already exist', state: ToastStates.ERROR);
                                  AdminCubit.get(context).startDateTime =
                                      DateTime(-1);
                                  AdminCubit.get(context).endDateTime =
                                      DateTime(-1);
                                  AdminCubit.get(context).checkYearList.clear();
                                }
                                else {
                                  // print('elseee ${AdminCubit.get(context).isYearAvailable}');
                                  Uuid id = const Uuid();
                                  String academicYearsId = id.v1();
                                  AcademicYearsModel academicYearsModel =
                                  AcademicYearsModel(
                                    academicYearsId: academicYearsId,
                                    academicYearsNumber: [AdminCubit.get(context).startDateTime.year ,
                                      AdminCubit.get(context).endDateTime.year ],
                                  );
                                  AdminCubit.get(context).createAcademicYears(
                                      academicYearsModel: academicYearsModel);
                                  AdminCubit.get(context).startDateTime =
                                      DateTime(-1);
                                  AdminCubit.get(context).endDateTime =
                                      DateTime(-1);
                                }
                              });

                            }
                          },
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
