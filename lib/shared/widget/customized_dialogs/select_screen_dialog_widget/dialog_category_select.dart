import 'package:graduateproject/modules/admin/admin_imports/admin.dart';
import 'package:graduateproject/modules/upload/upload.dart';
import 'package:graduateproject/shared/network/local/local_storage/cache_helper.dart';
import 'package:graduateproject/shared/widget/drop_down_dialog/drop_down_dialog.dart';


class DialogCategorySelect extends StatefulWidget {
  const DialogCategorySelect({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogCategorySelect> createState() => _DialogCategorySelectState();
}

class _DialogCategorySelectState extends State<DialogCategorySelect> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {

        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: AppCubit.get(context)
                  .selectedDropDownCategory
                  ?.categoryName ??
                  ''),
          onTap: () {
            if (AppCubit.get(context)
                .selectedDropDownAcademicYears
                ?.academicYearsId ==
                '-1') {
              showToast(
                  message: 'Please select the year',
                  state: ToastStates.ERROR);

            }
            else if (AppCubit.get(context)
                .selectedDropDownAcademicTerms
                ?.academicTermsId ==
                '-1') {
              showToast(
                  message: 'Please select the term',
                  state: ToastStates.ERROR);

            }
            else {
              AppCubit.get(context).categoryList.clear();
               AppCubit.get(context).getCategory().whenComplete(() => showCustomDropDownDialog(
                   iconFunction: () {
                     AppCubit.get(context).changeCategoryClear();
                     maybePop(context);
                   },
                   context: context,
                   title: 'Category',
                   child: CustomDropDownDialog(
                       actionDropDownList: AppCubit.get(context)
                           .categoryList
                           .map((category) => Column(
                             children: [
                               Container(
                         height: 55,
                         decoration: BoxDecoration(
                                 border: (AppCubit.get(context)
                                     .selectedDropDownCategory
                                     ?.categoryId ??
                                     '') ==
                                     category.categoryId
                                     ? Border.all(
                                     color: Colors.blue)
                                     : null),
                         child: CustomActionDropDownDialog(
                                 title:
                                 category.categoryName ??
                                     '',
                                 fontWeight: FontWeight.bold,
                                 onTap: () async{
                                   AppCubit.get(context)
                                       .changeCategory(categoryModel: category);
                                   AppCubit.get(context).subCategoryList.clear();
                                   AppCubit.get(context).selectedDropDownSubCategory = SubCategoryModel(
                                     subCategoryName: ['Sub Category'],
                                     subCategoryId: '-1',
                                     categoryId: '-1',
                                   );
                                   AppCubit.get(context).getSubCategory(context: context,
                                       categoryId: AppCubit.get(context).selectedDropDownCategory?.categoryId);
                                   if(AppCubit.get(context).selectedDropDownCategory?.categoryName == subjectModel
                                       && (CacheHelper.getData(key: spUserType) == userTypeAdmin
                                           || CacheHelper.getData(key: spUserType) == userTypeHeadDepartment)) {
                                     AppCubit
                                         .get(context)
                                         .subjectTermList
                                         .clear();
                                     AppCubit
                                         .get(context)
                                         .selectedDropDownSubjectTerm =
                                         SubjectTermModel(
                                           academicTermId: '-1',
                                           subjectName: 'subject',
                                           subjectId: '-1',
                                           subjectTermId: '-1',
                                           departmentId: '-1',
                                           subjectCoordinator: '',
                                           subjectNumber: '-1',
                                         );
                                     AppCubit.get(context).getSubjectsTerms(
                                         departmentId: AppCubit.get(context).selectedDepartmentDialog?.departmentId,
                                         context: context,
                                         academicTermId: AppCubit
                                             .get(context)
                                             .selectedDropDownAcademicTerms
                                             ?.academicTermsId
                                     );
                                   }
                                   else if (AppCubit.get(context).selectedDropDownCategory?.categoryName == subjectModel
                                       && CacheHelper.getData(key: spUserType) == userTypeUser){
                                     AppCubit
                                         .get(context)
                                         .subjectList
                                         .clear();AppCubit
                                         .get(context)
                                         .uniqueSubjectList
                                         .clear();
                                     AppCubit
                                         .get(context)
                                         .selectedDropDownSubject =
                                         SubjectTermModel(
                                           academicTermId: '-1',
                                           subjectName: 'subject',
                                           subjectId: '-1',
                                           subjectTermId: '-1',
                                           departmentId: '-1',
                                           subjectCoordinator: '',
                                           subjectNumber: '-1',
                                         );
                                     await AppCubit.get(context).getSubject(
                                       context: context,
                                       academicTermId: AppCubit.get(context).selectedDropDownAcademicTerms?.academicTermsId,
                                     );
                                   }
                                   else {
                                     AppCubit.get(context).subjectTermList.clear();
                                     AppCubit
                                         .get(context)
                                         .selectedDropDownSubjectTerm =
                                         SubjectTermModel(
                                           academicTermId: '-1',
                                           subjectName: 'subject',
                                           subjectId: '-1',
                                           subjectTermId: '-1',
                                           departmentId: '-1',
                                           subjectCoordinator: '',
                                           subjectNumber: '-1',
                                         );
                                   }
                                 }),
                       ),
                               Divider(),
                             ],
                           ))
                           .toList())));
            }
          },
        );
    });
  }
}
