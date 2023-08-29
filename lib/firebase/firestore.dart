import 'package:cloud_firestore/cloud_firestore.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreStorage {
  static late FirebaseFirestore fireStore;

  static void init() {
    fireStore = FirebaseFirestore.instance;
  }
}