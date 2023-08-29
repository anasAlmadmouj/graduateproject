import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduateproject/modules/upload/upload.dart';

class UploadCubit extends Cubit<UploadStates> {
  UploadCubit() : super(UploadInitialState());

  static UploadCubit get(context) => BlocProvider.of(context);

  FilePickerResult? resultPdf;
  String? pdfUrlFile = '';
  Uint8List? memoryPdfFile;
  String? fileName = '';
  double? fileSize = 0;

  selectPdfFile() async {
    resultPdf = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    ))!;
    fileName = resultPdf!.files.single.name;
    fileSize = (resultPdf!.files.single.size / 10000).roundToDouble() / 100;
    emit(PickedFileSuccessState());
  }

  Future<void> uploadFile({
    required String? fileId,
    required String? fileYear,
    required String? fileTerm,
    required String? departmentId,
    required String? subjectId,
    required String? sectionId,
    required String? sectionName,
    required String? categoryId,
    required String? categoryName,
    required String? subCategoryName,
    required String? subCategoryId,
    required String? yearName,
    required String? termName,
    required String? subjectName,
  }) async {
    emit(UploadLoadingState());
    final user = FirebaseAuth.instance.currentUser;
    if (resultPdf != null) {}
    Uint8List? uploadFile = resultPdf?.files.single.bytes!;
    if (uploadFile != null) {
      memoryPdfFile = uploadFile;
    }
    Reference reference = FirebaseStorage.instance
        .ref('Models')
        .child('$categoryName')
        .child('$subCategoryName')
        .child(resultPdf!.files.single.name);
    final UploadTask uploadTask = reference.putData(uploadFile!);
    uploadTask.whenComplete(() async {
      pdfUrlFile = await uploadTask.snapshot.ref.getDownloadURL();
    }).then((value) {
      if (user != null) {
        FilesModel filesModel = FilesModel(
          subCategoryName: subCategoryName,
          termId: fileTerm,
          yearId: fileYear,
          subCategoryId: subCategoryId,
          categoryId: categoryId,
          sectionId: sectionId,
          subjectId: subjectId,
          departmentId: departmentId,
          fileName: fileName,
          fileId: fileId,
          fileUrl: pdfUrlFile,
          sectionName: sectionName,
          yearName: yearName,
          subjectName: subjectName,
          termName: termName,
          userId: user.uid,
        );
        createFile(filesModel: filesModel);
        emit(UploadSuccessState());
      }
    }).catchError((error) {
      emit(UploadErrorState(error.toString()));
    });
  }
} // Function to upload a file and create its corresponding document in Firestore

// Once the file is uploaded, a FilesModel object is created and stored in Firestore
Future<void> createFile({required FilesModel filesModel}) async {
  await FireStoreStorage.fireStore
      .collection(fileCollection)
      .doc(filesModel.fileId ?? '')
      .set(filesModel.toMap());
}
