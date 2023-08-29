import 'package:flutter/material.dart';
import 'package:graduateproject/modules/admin/admin_imports/navigate_admin_imports.dart';
import 'package:graduateproject/modules/login/login.dart';
import 'package:graduateproject/modules/ask_me_screen.dart';
import 'package:graduateproject/modules/views_screens/select_range_screen.dart';
import 'package:graduateproject/modules/views_screens/select_screen.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit , LoginStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: scaffoldColor,
            elevation: 0,
            actions: [
              PopupMenuButton(
                icon: Icon(Icons.menu , color: defaultColorGreen,),
                onSelected: (value) {
                  if (value == 'logout') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Logout'),
                              onPressed: () {
                                // Perform logout logic here
                                Navigator.of(context).pop(); // Close the dialog
                                LoginCubit.get(context).logout(context: context); // Perform logout operation
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.power_settings_new, color: Colors.red.shade900),
                        SizedBox(width: 10),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            title: Text(
              'DIGITAL ARCHIVE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: defaultColorGreen,
              ),
            ),
            centerTitle: true,
          ),

            body: CacheHelper.getData(key: spUserType) == userTypeAdmin ?
            SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 2,
                        color: defaultColorGray,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Name :',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ${LoginCubit.get(context).usersModel.userName}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Email :',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ${LoginCubit.get(context).usersModel.userEmail}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        navigateTo(context, const SelectScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: defaultColorGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        minimumSize: const Size(215 , 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'View Data',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navigateTo(context, const SelectRangeScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: defaultColorGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        minimumSize: const Size(215 , 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'View Data range',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navigateTo(context,  UploadScreenMobile());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: defaultColorGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        minimumSize: const Size(215 , 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Upload',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navigateTo(context, ChatPage());                      },
                      style: ElevatedButton.styleFrom(
                        primary: defaultColorGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        minimumSize: const Size(215 , 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Ask me',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navigateTo(context, const AddingPage());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: defaultColorGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        minimumSize: const Size(215 , 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Adding Page',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
                : CacheHelper.getData(key: spUserType) == userTypeHeadDepartment ?  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: defaultColorGray,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Name :',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' ${LoginCubit.get(context).usersModel.userName}',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Email :',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' ${LoginCubit.get(context).usersModel.userEmail}',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(context, const SelectScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: defaultColorGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          minimumSize: const Size(215 , 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'View Data',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(context, const SelectRangeScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: defaultColorGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          minimumSize: const Size(215 , 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'View Data range',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(context,  UploadScreenMobile());                    },
                        style: ElevatedButton.styleFrom(
                          primary: defaultColorGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          minimumSize: const Size(215 , 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Upload',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(context, ChatPage());                          },
                        style: ElevatedButton.styleFrom(
                          primary: defaultColorGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          minimumSize: const Size(215 , 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Ask me',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          )
              : CacheHelper.getData(key: spUserType) == userTypeUser ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: defaultColorGray,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Name :',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' ${LoginCubit.get(context).usersModel.userName}',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Email :',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' ${LoginCubit.get(context).usersModel.userEmail}',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 70),
                  Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(context, const SelectScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: defaultColorGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          minimumSize: const Size(215 , 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'View Data',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigateTo(context,  UploadScreenMobile());                    },
                        style: ElevatedButton.styleFrom(
                          primary: defaultColorGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          minimumSize: const Size(215 , 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Upload',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // UrlHelper.launchInBrowser(Uri.parse('https://bd0112cf7420ebd2e4.gradio.live'));
                          navigateTo(context, ChatPage());

                          },
                        style: ElevatedButton.styleFrom(
                          primary: defaultColorGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          minimumSize: const Size(215 , 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Ask me',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          )
                : const SizedBox(),
        );
      },
    );
  }
}
