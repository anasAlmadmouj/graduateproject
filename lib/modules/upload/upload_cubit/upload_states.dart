abstract class UploadStates{}

class UploadInitialState extends UploadStates{}
class UploadLoadingState extends UploadStates{}
class UploadSuccessState extends UploadStates{}
class UploadErrorState extends UploadStates {
  final String error;
  UploadErrorState(this.error);
}
class AcceptFileSuccessState extends UploadStates{}
class UploadPickedSuccessState extends UploadStates{}
class UploadPickedErrorState extends UploadStates{}
class PickedFileSuccessState extends UploadStates{}
class UploadCheckSuccessState extends UploadStates{}

