import 'package:flutter/material.dart';
import 'package:graduateproject/models/subjects_model/subjects_model.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/network/url_launcher_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  void launchU(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: customizedAppBar(
            function: () {
              setState(() {
                AppCubit.get(context).yearsIdList.clear();
                AppCubit.get(context).uniqueYearsIdList.clear();
                AppCubit.get(context).filesList.clear();
              });
              maybePop(context);
            },
            title: 'Archived',
          ),
          body: AppCubit.get(context).filesList.isNotEmpty ? ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: AppCubit.get(context).filesList.length,
            itemBuilder: (context, index) {
              final file = AppCubit.get(context).filesList[index];

              return ListTile(
                onTap: () {
                  UrlHelper.launchInBrowser(Uri.parse(file.fileUrl ?? ''));
                },
                leading: Image.asset(
                  'assets/images/pdf.png',
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  file.fileName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      file.yearName ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      file.termName ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 2),
                    !listEquals(
                      AppCubit.get(context)
                          .selectedDropDownSubCategory
                          ?.subCategoryName,
                      ['نموذج تنفيذ وتقييم اداء الطلبة'],
                    )
                        ? Text(
                            file.sectionName ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          )
                        : Text(
                            file.subjectName ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm Delete'),
                          content: const Text(
                              'Are you sure you want to delete this file?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: (){
                                 AppCubit.get(context).deleteFile(
                                  fileId: file.fileId ?? '',
                                ).then((value) {
                                   AppCubit.get(context).filesList.clear();
                                 }).whenComplete(() {
                                   print('7tft.......${AppCubit.get(context).filesList.isEmpty}');
                                   CacheHelper.getData(key: spUserType) ==
                                       userTypeAdmin &&
                                       AppCubit.get(context).isSelectRange ==
                                           false
                                       ? AppCubit.get(context).getFiles(
                                     yearId: AppCubit.get(context)
                                         .selectedDropDownAcademicYears
                                         ?.academicYearsId,
                                     termId: AppCubit.get(context)
                                         .selectedDropDownAcademicTerms
                                         ?.academicTermsId,
                                     departmentId: AppCubit.get(context)
                                         .selectedDepartmentDialog
                                         ?.departmentId,
                                     categoryId: AppCubit.get(context)
                                         .selectedDropDownCategory
                                         ?.categoryId,
                                     subCategoryId: AppCubit.get(context)
                                         .selectedDropDownSubCategory
                                         ?.subCategoryId,
                                     subjectId: AppCubit.get(context)
                                         .selectedDropDownSubjectTerm
                                         ?.subjectId,
                                   )
                                       : CacheHelper.getData(key: spUserType) ==
                                       userTypeAdmin &&
                                       AppCubit.get(context)
                                           .isSelectRange ==
                                           true
                                       ? AppCubit.get(context).getFilesRange(
                                     startYear: AppCubit.get(context)
                                         .startRangeDateTime
                                         .year,
                                     endYear: AppCubit.get(context)
                                         .endRangeDateTime
                                         .year,
                                     departmentId: AppCubit.get(context)
                                         .selectedDepartmentDialog!
                                         .departmentId,
                                     categoryId: AppCubit.get(context)
                                         .selectedDropDownCategory!
                                         .categoryId,
                                     subCategoryId: AppCubit.get(context)
                                         .selectedDropDownSubCategory!
                                         .subCategoryId,
                                     subjectId: AppCubit.get(context)
                                         .selectedSubjects!
                                         .subjectId,
                                   )
                                       : CacheHelper.getData(key: spUserType) == userTypeUser &&
                                       AppCubit.get(context).isSelectRange == false ?
                                   AppCubit.get(context).getUserFiles(
                                     yearId: AppCubit.get(context).selectedDropDownAcademicYears?.academicYearsId,
                                     termId: AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId,
                                     departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId,
                                     categoryId: AppCubit.get(context).selectedDropDownCategory?.categoryId,
                                     subjectId: AppCubit.get(context).selectedDropDownSubject?.subjectId,
                                     sectionId: AppCubit.get(context).selectedDropDownSection?.sectionId,
                                   )
                                       : null;
                                   print('gbt.......${AppCubit.get(context).filesList.isEmpty}');
                                   Navigator.pop(context);
                                 });
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.delete),
                ),
              );
            },
          )
              : Center(child: Text('dont have files')),
        );
      },
    );
  }
}
