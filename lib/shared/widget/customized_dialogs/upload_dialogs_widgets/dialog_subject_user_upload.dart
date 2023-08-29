import 'package:graduateproject/models/section/section_model.dart';
import 'package:graduateproject/modules/admin/admin_cubit/admin_cubit_imports.dart';
import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogSubjectUserUpload extends StatefulWidget {
  const DialogSubjectUserUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogSubjectUserUpload> createState() => _DialogSubjectUserUploadState();
}

class _DialogSubjectUserUploadState extends State<DialogSubjectUserUpload> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: AppCubit.get(context)
                  .selectedDropDownSubject
                  ?.subjectCoordinator ??
                  ''),
          onTap: () {

            showCustomDropDownDialog(
                iconFunction: (){
                  AppCubit.get(context).changeSubjectClear();
                  maybePop(context);
                },
                context: context,
                title: 'Subject',
                child: CustomDropDownDialog(
                    actionDropDownList: AppCubit.get(context)
                        .uniqueSubjectList
                        .map((subject) => Container(
                      decoration: BoxDecoration(
                          border: (AppCubit.get(
                              context)
                              .selectedDropDownSubject
                              ?.subjectId ??
                              '') ==
                              subject
                                  .subjectId
                              ? Border.all(
                              color: Colors.blue)
                              : null),
                      child:
                      CustomActionDropDownDialog(
                          title: subject
                              .subjectCoordinator ??
                              '',
                          fontWeight:
                          FontWeight.bold,
                          onTap: () {
                            AppCubit.get(context)
                                .changeSubject(
                                subjectModel:
                                subject);
                            AppCubit.get(context).selectedDropDownSection = SectionModel(
                              sectionName: sectionCollection,
                              subjectId: '-1',
                              userId: '-1',
                              sectionId: '-1',
                            );
                            AppCubit.get(context).sectionList.clear();
                            AppCubit.get(context).selectedSubCategoryCoordinator = SubCategoryModel(
                                categoryId: '-1', subCategoryId: '-1', subCategoryName: ['Sub category']);
                            AppCubit.get(context).getSection(context: context,
                                subjectId: AppCubit.get(context).selectedDropDownSubject?.subjectId);
                            AppCubit.get(context).coordinatorIdList.clear();
                            AppCubit.get(context).subCategoryIsCoordinatorList.clear();
                            AppCubit.get(context).getSubCategoryIsCoordinator(
                                subjectId:
                                AppCubit.get(context)
                                    .selectedDropDownSubject?.subjectTermId,
                                context: context,
                                categoryId: AppCubit
                                    .get(context)
                                    .selectedDropDownCategory?.categoryId
                            );
                          }),
                    ))
                        .toList()));
          },
        );
    });
  }
}

