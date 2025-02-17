import 'package:adv_exam_2/model/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Fire {
  Fire._();

  static Fire fire = Fire._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> addDataFire(BookModel book) async {
    await _fireStore
        .collection("user")
        .doc(book.id.toString())
        .set(BookModel.toMap(book));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readDataFire() {
    return _fireStore.collection("user").snapshots();
  }
}
