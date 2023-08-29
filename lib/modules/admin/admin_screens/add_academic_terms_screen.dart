import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:graduateproject/app_layout/app_cubit/app_cubit.dart';
import 'package:graduateproject/app_layout/app_cubit/app_states.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/admin_pages_dialogs/dialogs_add_term/dialog_years_add_term.dart';
import 'package:graduateproject/shared/widget/shared_widgets/logo_adding_pages.dart';

class AddAcademicTermsScreen extends StatefulWidget {
  @override
  State<AddAcademicTermsScreen> createState() => _AddAcademicTermsScreenState();
}

class _AddAcademicTermsScreenState extends State<AddAcademicTermsScreen> {
  List<String> academicTermsDropDownList = [
    ' First Term ',
    ' Second Term ',
    ' Summer Term ',
  ];
  var formKey = GlobalKey<FormState>();
  String? selectedAcademicValue ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state) {
            if (state is AddAcademicTermsSuccessState) {
              showToast(
                  message: 'Add New Term Success', state: ToastStates.SUCCESS);
            }
            if (state is AddAcademicTermsErrorState) {
              showToast(message: state.error, state: ToastStates.ERROR);
            }
          },
          builder: (context, state) {
            AdminCubit adminCubit = AdminCubit.get(context);
            return Form(
              key: formKey,
              child: Scaffold(
                appBar: customizedAppBar(
                  function: (){
                    AppCubit.get(context).selectedDropDownAcademicTerms = AcademicTermsModel(
                      academicTermsName: 'academic term',
                      academicYearsId: '-1',
                      academicTermsId: '-1',
                    );
                    AppCubit.get(context).selectedDropDownAcademicYears = AcademicYearsModel(
                      academicYearsNumber: [],
                      academicYearsId: '-1',
                    );
                    Navigator.pop(context);
                  },
                  title: 'Add New Term',
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const LogoAddingPages(),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                          hint: const Text(' academic term '),
                          isExpanded: true,
                          value: selectedAcademicValue,
                          validator: (value) => AppCubit.get(context)
                              .validateDropDown(
                                  value, 'academic term is required'),
                          // value == null ? 'field is required' : null,
                          items: academicTermsDropDownList.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) {
                            print(AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId);
                            setState(() {
                              selectedAcademicValue = value;
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      const DialogYearsAddTerm(),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! AddAcademicTermsLoadingState,
                        builder: (context) => defaultElevatedButton(
                          borderRadius: 10,
                          width: MediaQuery.of(context).size.width / 1.5,
                          text: 'Add new term',
                          colorText: Colors.white,
                          backGroundColor: defaultColorGreen,
                          function: () async {
                            if(AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId == '-1'){
                              showToast(message: 'Please select year', state: ToastStates.ERROR);
                            }
                            else if (formKey.currentState!.validate()) {
                              await AdminCubit.get(context).checkIsTermAvailable(
                                  academicYearId: AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId,
                                  academicTermName: selectedAcademicValue)
                                  .then((isSuccess) {
                                    if(!isSuccess){
                                      showToast(message: 'the term is exit in this year (${AppCubit.get(context).
                                      selectedDropDownAcademicYears?.academicYearsNumber.join('/').toString()})',
                                          state: ToastStates.ERROR);
                                      AppCubit
                                          .get(context)
                                          .selectedDropDownAcademicYears =
                                          AcademicYearsModel(
                                            academicYearsNumber: [-1],
                                            academicYearsId: '-1',
                                          );
                                      AdminCubit.get(context).checkTermList.clear();
                                    }
                                    else{
                                      Uuid id = const Uuid();
                                      String academicTermsId = id.v1();
                                      AcademicTermsModel academicTermsModel =
                                      AcademicTermsModel(
                                          academicTermsId: academicTermsId,
                                          academicTermsName: selectedAcademicValue,
                                          academicYearsId: AppCubit
                                              .get(context)
                                              .selectedDropDownAcademicYears!
                                              .academicYearsId);
                                      adminCubit.createAcademicTerms(
                                        academicTermsModel: academicTermsModel,
                                      );
                                      AppCubit.get(context)
                                          .selectedDropDownAcademicYears = AcademicYearsModel(
                                        academicYearsNumber: [-1],
                                        academicYearsId: '-1',
                                      );
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


