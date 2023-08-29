import 'package:graduateproject/modules/login/cubit/login_states.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/modules/upload/upload_cubit/upload_cubit.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/upload_dialogs_widgets/dialog_academic_terms_uoload.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/upload_dialogs_widgets/dialog_academic_year_upload.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/upload_dialogs_widgets/dialog_category_upload.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/upload_dialogs_widgets/dialog_section_upload.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/upload_dialogs_widgets/dialog_sub_category_upload.dart';
import 'package:graduateproject/shared/widget/customized_dialogs/upload_dialogs_widgets/dialog_subject_term_upload.dart';

class UploadScreenMobile extends StatelessWidget {
  var fileNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadCubit, UploadStates>(
      listener: (context, uploadState) {
        if (uploadState is UploadSuccessState) {
          showToast(message: 'Upload file Success', state: ToastStates.SUCCESS);
        }
        if (uploadState is UploadErrorState) {
          showToast(message: uploadState.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, uploadState) {
        return BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) =>
              BlocBuilder<LoginCubit, LoginStates>(
                builder: (context, state) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: scaffoldColor,
                      leading: IconButton(
                        onPressed: () {
                          AppCubit.get(context).clearDialog();
                          UploadCubit
                              .get(context)
                              .fileSize = 0;
                          maybePop(context);
                          AppCubit.get(context).clearDialog();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: defaultColorGreen,
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'DIGITAL ARCHIVE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: defaultColorGreen,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                      elevation: 0,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView(
                        children: [
                          const AcademicYearsDialogUpload(), //year
                          const SizedBox(
                            height: 15,
                          ),
                          const DialogAcademicTermsUpload(), //term
                          const SizedBox(
                            height: 15,
                          ),
                          const DepartmentDialog(),
                          const SizedBox(
                            height: 15,
                          ),
                          const DialogCategoryUpload(), //category
                          const SizedBox(
                            height: 15,
                          ),
                          if (AppCubit
                              .get(context)
                              .selectedDropDownCategory
                              ?.categoryName == subjectModel)
                            Column(
                              children: const [
                                DialogSubjectTermUpload(),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          const DialogSubCategoryUpload(), //SubCategory
                          const SizedBox(
                            height: 15,
                          ),
                          if((CacheHelper.getData(key: spUserType) ==
                              userTypeUser ||
                              CacheHelper.getData(key: spUserType) ==
                                  userTypeHeadDepartment)
                              && AppCubit
                                  .get(context)
                                  .selectedDropDownCategory
                                  ?.categoryName == subjectModel
                              && !listEquals(AppCubit
                                  .get(context)
                                  .selectedSubCategoryCoordinator
                                  ?.subCategoryName,
                                  ['تنفيذ وتقييم اداء الطلبة'])
                              && AppCubit
                                  .get(context)
                                  .selectedSubCategoryCoordinator
                                  ?.subCategoryId != '-1')
                            Column(
                              children: const [
                                DialogSectionUpload(),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          if((CacheHelper.getData(key: spUserType) ==
                              userTypeAdmin)
                              && AppCubit
                                  .get(context)
                                  .selectedDropDownCategory
                                  ?.categoryName == subjectModel
                              && !listEquals(AppCubit
                                  .get(context)
                                  .selectedDropDownSubCategory
                                  ?.subCategoryName,
                                  ['تنفيذ وتقييم اداء الطلبة'])
                              && AppCubit
                                  .get(context)
                                  .selectedDropDownSubCategory
                                  ?.subCategoryId != '-1')
                            Column(
                              children: const [
                                DialogSectionUpload(),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          defaultElevatedButton(
                              borderRadius: 10,
                              width: double.infinity,
                              text: 'Choose File',
                              backGroundColor: defaultColorGreen,
                              function: () {
                                UploadCubit.get(context).selectPdfFile();
                              }),
                          UploadCubit
                              .get(context)
                              .fileSize != 0
                              ? Column(
                            children: [
                              SizedBox(height: 10,),
                              const FileChoosedContainer(),
                            ],
                          )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          uploadState is UploadLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : defaultElevatedButton(
                              borderRadius: 10,
                              backGroundColor: defaultColorGreen,
                              text: 'Upload',
                              width: double.infinity,
                              function: () {
                                if (AppCubit
                                    .get(context)
                                    .selectedDropDownAcademicYears
                                    ?.academicYearsId ==
                                    '-1') {
                                  showToast(
                                      message: 'Please select academic year',
                                      state: ToastStates.ERROR);
                                } else if (AppCubit
                                    .get(context)
                                    .selectedDropDownAcademicTerms
                                    ?.academicTermsId ==
                                    '-1') {
                                  showToast(
                                      message: 'Please select academic term',
                                      state: ToastStates.ERROR);
                                } else if (AppCubit
                                    .get(context)
                                    .selectedDepartmentDialog
                                    ?.departmentId ==
                                    '-1') {
                                  showToast(
                                      message: 'Please select department',
                                      state: ToastStates.ERROR);
                                } else if (AppCubit
                                    .get(context)
                                    .selectedDropDownCategory
                                    ?.categoryId ==
                                    '-1') {
                                  showToast(
                                      message: 'Please select category',
                                      state: ToastStates.ERROR);
                                } else if (
                                (CacheHelper.getData(key: spUserType) ==
                                    userTypeUser
                                    || CacheHelper.getData(key: spUserType) ==
                                        userTypeHeadDepartment)
                                    && AppCubit
                                    .get(context)
                                    .selectedSubCategoryCoordinator
                                    ?.subCategoryId ==
                                    '-1') {
                                  showToast(
                                      message: 'Please select sub category',
                                      state: ToastStates.ERROR);
                                }
                                else if (
                                CacheHelper.getData(key: spUserType) ==
                                    userTypeAdmin
                                    && AppCubit
                                    .get(context)
                                    .selectedDropDownSubCategory
                                    ?.subCategoryId ==
                                    '-1') {
                                  showToast(
                                      message: 'Please select sub category',
                                      state: ToastStates.ERROR);
                                }
                                else if (CacheHelper.getData(key: spUserType) ==
                                    userTypeAdmin &&
                                    AppCubit
                                        .get(context)
                                        .selectedDropDownSubjectTerm
                                        ?.subjectTermId ==
                                        '-1') {
                                  showToast(
                                      message: 'Please select subject',
                                      state: ToastStates.ERROR);
                                } else
                                if ((CacheHelper.getData(key: spUserType) ==
                                    userTypeUser ||
                                    CacheHelper.getData(key: spUserType) ==
                                        userTypeHeadDepartment) &&
                                    AppCubit
                                        .get(context)
                                        .selectedDropDownSubject
                                        ?.subjectId == '-1') {
                                  showToast(
                                      message: 'Please select subject',
                                      state: ToastStates.ERROR);
                                }
                                // else if (!listEquals(AppCubit
                                //     .get(context)
                                //     .selectedDropDownSubCategory
                                //     ?.subCategoryName,
                                //     ['تنفيذ وتقييم اداء الطلبة'])
                                //     && AppCubit
                                //         .get(context)
                                //         .selectedDropDownSection
                                //         ?.sectionId == '-1') {
                                //   showToast(
                                //       message: 'Please select section',
                                //       state: ToastStates.ERROR);
                                // }
                                else if (UploadCubit
                                    .get(context)
                                    .fileSize == 0) {
                                  showToast(
                                      message: 'Please choose file',
                                      state: ToastStates.ERROR);
                                } else {
                                  Uuid id = const Uuid();
                                  String fileId = id.v1();
                                  UploadCubit.get(context).uploadFile(
                                    // subjectTermId: AppCubit.get(context).selectedDropDownSubjectTerm?.subjectTermId,
                                    subjectName: CacheHelper.getData(
                                        key: spUserType) == userTypeAdmin ?
                                    AppCubit
                                        .get(context)
                                        .selectedDropDownSubjectTerm
                                        ?.subjectName
                                        : AppCubit
                                        .get(context)
                                        .selectedDropDownSubject
                                        ?.subjectName,
                                    termName: AppCubit
                                        .get(context)
                                        .selectedDropDownAcademicTerms
                                        ?.academicTermsName,
                                    yearName: AppCubit
                                        .get(context)
                                        .selectedDropDownAcademicYears
                                        ?.academicYearsNumber
                                        .join('/')
                                        .toString(),
                                    subCategoryId: CacheHelper.getData(
                                        key: spUserType) == userTypeAdmin ?
                                    AppCubit
                                        .get(context)
                                        .selectedDropDownSubCategory
                                        ?.subCategoryId
                                        : AppCubit
                                        .get(context)
                                        .selectedSubCategoryCoordinator!
                                        .subCategoryId,
                                    fileYear: AppCubit
                                        .get(context)
                                        .selectedDropDownAcademicYears!
                                        .academicYearsId,
                                    fileTerm: AppCubit
                                        .get(context)
                                        .selectedDropDownAcademicTerms!
                                        .academicTermsId,
                                    subCategoryName: CacheHelper.getData(key: spUserType) == userTypeAdmin ? AppCubit
                                        .get(context)
                                        .selectedDropDownSubCategory!
                                        .subCategoryName.first
                                    : AppCubit.get(context).selectedSubCategoryCoordinator?.subCategoryName.first,
                                    categoryName: AppCubit
                                        .get(context)
                                        .selectedDropDownCategory!
                                        .categoryName,
                                    sectionId: AppCubit
                                        .get(context)
                                        .selectedDropDownSection!
                                        .sectionId,
                                    categoryId: AppCubit
                                        .get(context)
                                        .selectedDropDownCategory!
                                        .categoryId,
                                    fileId: fileId,
                                    sectionName: AppCubit
                                        .get(context)
                                        .selectedDropDownSection!
                                        .sectionName,
                                    departmentId: AppCubit
                                        .get(context)
                                        .selectedDepartmentDialog!
                                        .departmentId,
                                    subjectId: CacheHelper.getData(
                                        key: spUserType) == userTypeAdmin
                                        ? AppCubit
                                        .get(context)
                                        .selectedDropDownSubjectTerm
                                        ?.subjectId
                                        : AppCubit
                                        .get(context)
                                        .selectedDropDownSubject
                                        ?.subjectId,
                                  );
                                  AppCubit.get(context).clearDialog();
                                  UploadCubit
                                      .get(context)
                                      .fileSize = 0;
                                }
                              }),
                        ],
                      ),
                    ),
                  );
                },
              ),
        );
      },
    );
  }
}

class FileChoosedContainer extends StatefulWidget {
  const FileChoosedContainer({
    super.key,
  });

  @override
  State<FileChoosedContainer> createState() => _FileChoosedContainerState();
}

class _FileChoosedContainerState extends State<FileChoosedContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCubit , UploadStates>(
      builder: (context, uploadState) {
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 1.5,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.2,
          // or any other suitable height value
          decoration: BoxDecoration(
            color: defaultColorGray,
            border: Border.all(
                color: defaultColorGreen, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Name : ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${UploadCubit
                            .get(context)
                            .fileName}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Size : ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${UploadCubit
                            .get(context)
                            .fileSize} megabytes',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}