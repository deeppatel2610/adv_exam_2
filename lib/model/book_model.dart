class BookModel {
  int? id, rating;
  String title, author, genre, status;

  BookModel({
    this.id,
    required this.title,
    required this.rating,
    required this.author,
    required this.genre,
    required this.status,
  });

  factory BookModel.fromMap(Map m1) {
    return BookModel(
        id: m1['id'],
        title: m1['title'],
        rating: m1['rating'],
        author: m1['author'],
        genre: m1['genre'],
        status: m1['status']);
  }

  static Map<String, Object?> toMap(BookModel bookModel) {
    return {
      'id': bookModel.id,
      'title': bookModel.title,
      'genre': bookModel.genre,
      'author': bookModel.author,
      'rating': bookModel.rating,
      'status': bookModel.status,
    };
  }
}
