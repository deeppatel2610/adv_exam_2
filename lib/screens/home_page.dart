import 'package:adv_exam_2/controller/db%20controller/db_controller.dart';
import 'package:adv_exam_2/model/book_model.dart';
import 'package:adv_exam_2/servis/fire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              for (int i = 0; i < dbController.dataListForDb.length; i++) {
                BookModel book = BookModel(
                  title: dbController.dataListForDb[i].title,
                  rating: dbController.dataListForDb[i].rating,
                  author: dbController.dataListForDb[i].author,
                  genre: dbController.dataListForDb[i].genre,
                  status: dbController.dataListForDb[i].status,
                  id: dbController.dataListForDb[i].id,
                );
                Fire.fire.addDataFire(book);
              }
            },
            icon: const Icon(Icons.cloud),
          ),
          StreamBuilder(
            stream: Fire.fire.readDataFire(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List data = snapshot.data!.docs;
                List<BookModel> userData = data
                    .map(
                      (e) => BookModel.fromMap(e.data()),
                    )
                    .toList();
                return IconButton(
                  onPressed: () {
                    for (int i = 0; i <= userData.length; i++) {
                      dbController.addDataToDb(
                        title: userData[i].title,
                        author: userData[i].author,
                        genre: userData[i].genre,
                        status: userData[i].status,
                        rating: userData[i].rating!.toInt(),
                      );
                    }
                  },
                  icon: const Icon(Icons.rotate_right_outlined),
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error_outline);
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
        title: const Text(
          "Books",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: .5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            itemCount: dbController.dataListForDb.length,
            itemBuilder: (BuildContext context, int index) {
              return ColorCheng(
                index: index,
                text: dbController.dataListForDb[index].status,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              dbController.txtStatus.clear();
              dbController.txtGenre.clear();
              dbController.txtAuthor.clear();
              dbController.txtTitle.clear();
              return AlertDialog(
                backgroundColor: Colors.blue.shade100,
                title: const Text(
                  'Add Book',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      textInputMethod(
                        controller: dbController.txtTitle,
                        text: "Title",
                      ),
                      textInputMethod(
                        controller: dbController.txtAuthor,
                        text: "Author",
                      ),
                      textInputMethod(
                        controller: dbController.txtStatus,
                        text: "Status",
                      ),
                      textInputMethod(
                        controller: dbController.txtGenre,
                        text: "Genre",
                      ),
                      textInputMethod(
                        controller: dbController.txtRating,
                        text: "Rating",
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () {
                      dbController.addDataToDb(
                        title: dbController.txtTitle.text,
                        author: dbController.txtAuthor.text,
                        genre: dbController.txtGenre.text,
                        status: dbController.txtStatus.text,
                        rating: int.parse(dbController.txtRating.text),
                      );
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        },
        label: const Text(
          "Add Book",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }
}

Card listCardMethod(
    {required BuildContext context, required int index, required Color color}) {
  return Card(
    color: color,
    child: ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    backgroundColor: Colors.blue.shade100,
                    title: const Text(
                      'Add Book',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          textInputMethod(
                            controller: dbController.txtTitle,
                            text: "Title",
                          ),
                          textInputMethod(
                            controller: dbController.txtAuthor,
                            text: "Author",
                          ),
                          textInputMethod(
                            controller: dbController.txtStatus,
                            text: "Status",
                          ),
                          textInputMethod(
                            controller: dbController.txtGenre,
                            text: "Genre",
                          ),
                          textInputMethod(
                            controller: dbController.txtRating,
                            text: "Rating",
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          dbController.updateDateDb(
                              title: dbController.txtTitle.text,
                              author: dbController.txtAuthor.text,
                              genre: dbController.txtGenre.text,
                              status: dbController.txtStatus.text,
                              rating: int.parse(
                                dbController.txtRating.text,
                              ),
                              id: dbController.dataListForDb[index].id!
                                  .toInt());
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () async {
              await dbController.deleteDataDb(
                id: dbController.dataListForDb[index].id!.toInt(),
              );
            },
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      title: Text(
        dbController.dataListForDb[index].title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
        ),
      ),
      subtitle: Text(
        "${dbController.dataListForDb[index].rating} ⭐",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget textInputMethod({required controller, required String text}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "  $text",
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

class ColorCheng extends StatelessWidget {
  const ColorCheng({super.key, required this.text, required this.index});

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (text == "To Read") {
      return listCardMethod(
          context: context, color: Colors.blue.shade200, index: index);
    } else if (text == "Reading") {
      return listCardMethod(
          context: context, color: Colors.yellow.shade100, index: index);
    } else {
      return listCardMethod(
          context: context, color: Colors.grey.shade200, index: index);
    }
  }
}
