import 'package:adv_exam_2/model/book_model.dart';
import 'package:adv_exam_2/servis/db%20servis/db_servis.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

var dbController = Get.put(DbController());

class DbController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    DbHelper.dbHelper.database;
    await readDataDb();
  }

  RxList<BookModel> dataListForDb = <BookModel>[].obs;
  var txtTitle = TextEditingController();
  var txtAuthor = TextEditingController();
  var txtGenre = TextEditingController();
  var txtStatus = TextEditingController();
  var txtRating = TextEditingController();

  Future<void> addDataToDb({
    required String title,
    required String author,
    required String genre,
    required String status,
    required int rating,
  }) async {
    await DbHelper.dbHelper.addData(
      title,
      author,
      genre,
      status,
      rating,
    );
    await readDataDb();
  }

  Future<void> updateDateDb({
    required String title,
    required String author,
    required String genre,
    required String status,
    required int rating,
    required int id,
  }) async {
    BookModel book = BookModel(
      title: title,
      rating: rating,
      author: author,
      genre: genre,
      status: status,
      id: id,
    );
    await DbHelper.dbHelper.update(book);
    readDataDb();
  }

  Future<void> deleteDataDb({required var id}) async {
    await DbHelper.dbHelper.deleteData(id);
    await readDataDb();
  }

  Future<void> readDataDb() async {
    List data = await DbHelper.dbHelper.readData();
    dataListForDb.value = data
        .map(
          (e) => BookModel.fromMap(e),
        )
        .toList();
  }
}
