import 'package:graduateproject/models/section/section_model.dart';
import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogSubjectTermUpload extends StatefulWidget {
  const DialogSubjectTermUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSubjectTermUpload> createState() => _DialogSubjectTermUploadState();
}

class _DialogSubjectTermUploadState extends State<DialogSubjectTermUpload> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: CacheHelper.getData(key: spUserType) == userTypeAdmin ? AppCubit.get(context)
                  .selectedDropDownSubjectTerm
                  ?.subjectName ??
                  '' : AppCubit.get(context)
                  .selectedDropDownSubject?.subjectName
                  ?? ''
          ),
          onTap: () {
            if(CacheHelper.getData(key: spUserType)==userTypeAdmin){
              if(AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId == '-1'){
                showToast(message: 'Please select academic term', state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).subjectTermList.isEmpty){
                showToast(message: 'Don\'t have subject in this term', state: ToastStates.ERROR);
              }
              else {
                showCustomDropDownDialog(
                    iconFunction: () {
                      AppCubit.get(context).changeSubjectClear();
                      maybePop(context);
                    },
                    context: context,
                    title: 'Subject',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit.get(context)
                            .subjectTermList
                            .map((subjectTerm) => Column(
                              children: [
                                Container(
                          height: 55,
                          decoration: BoxDecoration(
                                  border: (AppCubit.get(context)
                                      .selectedDropDownSubjectTerm
                                      ?.subjectId ??
                                      '') ==
                                      subjectTerm.subjectId
                                      ? Border.all(color: Colors.blue)
                                      : null),
                          child: CustomActionDropDownDialog(
                                  title: subjectTerm.subjectName ?? '',
                                  fontWeight: FontWeight.bold,
                                  onTap: () {
                                    AppCubit.get(context).changeSubjectTerm(
                                        subjectModel: subjectTerm);
                                    AppCubit.get(context)
                                        .selectedDropDownSection =
                                        SectionModel(
                                          sectionName: sectionCollection,
                                          subjectId: '-1',
                                          userId: '-1',
                                          sectionId: '-1',
                                        );
                                    AppCubit.get(context).sectionList.clear();
                                    AppCubit.get(context)
                                        .selectedDropDownSubCategory =
                                        SubCategoryModel(
                                          subCategoryName: ['Sub Category'],
                                          subCategoryId: '-1',
                                          categoryId: '-1',
                                        );
                                    AppCubit.get(context).getSection(
                                        context: context,
                                        subjectId: AppCubit.get(context)
                                            .selectedDropDownSubjectTerm
                                            ?.subjectTermId);
                                    AppCubit.get(context)
                                        .subCategoryList
                                        .clear();
                                    AppCubit.get(context).getSubCategory(
                                        context: context,
                                        categoryId: AppCubit.get(context)
                                            .selectedDropDownCategory
                                            ?.categoryId);
                                  }),
                        ),
                                Divider(),
                              ],
                            ))
                            .toList()));
              }
            }
            else {
              if(AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId == '-1'){
                showToast(message: 'Please select academic term', state: ToastStates.ERROR);
              }
              else if(AppCubit.get(context).subjectList.isEmpty){
                showToast(message: 'Don\'t have subject in this term', state: ToastStates.ERROR);
              }
              else {
                showCustomDropDownDialog(
                    iconFunction: () {
                      AppCubit.get(context).changeSubjectClear();
                      maybePop(context);
                    },
                    context: context,
                    title: 'Subject',
                    child: CustomDropDownDialog(
                        actionDropDownList: AppCubit.get(context)
                            .uniqueSubjectList
                            .map((subjectTerm) => Container(
                          decoration: BoxDecoration(
                              border: (AppCubit.get(context)
                                  .selectedDropDownSubject
                                  ?.subjectId ??
                                  '') ==
                                  subjectTerm.subjectId
                                  ? Border.all(color: Colors.blue)
                                  : null),
                          child: CustomActionDropDownDialog(
                              title: subjectTerm.subjectName ?? '',
                              fontWeight: FontWeight.bold,
                              onTap: () async {
                                 AppCubit.get(context).changeSubject(
                                    subjectModel: subjectTerm);
                                // if(CacheHelper.getData(key: spUserType) == userTypeAdmin){
                                //   AppCubit.get(context)
                                //       .selectedDropDownSection =
                                //       SectionModel(
                                //         sectionName: sectionCollection,
                                //         subjectId: '-1',
                                //         userId: '-1',
                                //         sectionId: '-1',
                                //       );
                                //   AppCubit.get(context).sectionList.clear();
                                //    AppCubit.get(context).getSection(
                                //       context: context,
                                //       subjectId: AppCubit.get(context).selectedDropDownSubjectTerm?.subjectTermId);
                                // }
                                // else {
                                  AppCubit.get(context)
                                      .selectedDropDownSection =
                                      SectionModel(
                                        sectionName: sectionCollection,
                                        subjectId: '-1',
                                        userId: '-1',
                                        sectionId: '-1',
                                      );
                                  AppCubit.get(context).sectionList.clear();
                                   AppCubit.get(context).getSection(
                                      context: context,
                                      subjectId: AppCubit.get(context).selectedDropDownSubject?.subjectTermId);
                                   print('subjectTermId    ${AppCubit.get(context).selectedDropDownSubject?.subjectTermId}');
                                   print('subjectCoordinator   ${AppCubit.get(context).selectedDropDownSubject?.subjectCoordinator}');
                                   print('academicTermId   ${AppCubit.get(context).selectedDropDownSubject?.academicTermId}');
                                // }

                                // AppCubit.get(context).sectionList.clear();
                                // AppCubit.get(context).getSection(
                                //     context: context,
                                //     subjectId: AppCubit.get(context)
                                //         .selectedDropDownSubjectTerm
                                //         ?.subjectTermId);
                                AppCubit.get(context)
                                    .subCategoryIsCoordinatorList
                                    .clear();
                                AppCubit.get(context).coordinatorIdList.clear();
                                AppCubit.get(context)
                                    .selectedSubCategoryCoordinator =
                                    SubCategoryModel(
                                      subCategoryName: ['Sub Category'],
                                      subCategoryId: '-1',
                                      categoryId: '-1',
                                    );
                                AppCubit.get(context).getSubCategoryIsCoordinator(
                                  subjectId: AppCubit.get(context).selectedDropDownSubject?.subjectTermId,
                                    context: context,
                                    categoryId: AppCubit.get(context)
                                        .selectedDropDownCategory
                                        ?.categoryId);
                              }),
                        ))
                            .toList()));
              }
            }

          },
        );
    });
  }
}

