import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/modules/admin/admin_imports/navigate_admin_imports.dart';
import 'package:graduateproject/modules/admin/admin_screens/add_coordinator_screen.dart';
import 'package:graduateproject/modules/admin/admin_screens/add_subject_term_screen.dart';

class AddingPage extends StatelessWidget {
  const AddingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return BlocBuilder<AdminCubit, AdminStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: customizedAppBar(
                function: (){
                  maybePop(context);
                },
                title: 'Adding page',
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add User Type',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, AddUserTypeScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add Department',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, AddDepartmentScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add New User',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, CreateUserScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add New Year',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, AddAcademicYearsScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add New Term',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, AddAcademicTermsScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add Category',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, AddCategoryScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add Sub Category',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, AddSubCategoryScreen());
                      },
                    ),
                    SizedBox(height: 10,),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add Subject',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, AddSubjectScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add subject term',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, const AddSubjectTermScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add Section',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, const AddSectionScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultElevatedButton(
                      borderRadius: 10,
                      text: 'Add Coordinator',
                      colorText: Colors.white,
                      backGroundColor: defaultColorGreen,
                      function: () {
                        navigateTo(context, const AddCoordinatorScreen());
                      },
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
