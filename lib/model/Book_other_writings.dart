import 'Book_detail.dart';

class Book_other_writings {

  final String email;
  final String writer_name;
  final String book_title;
  final String book_subtitle;
  final String book_no;


  final List<Book_detail> book_detail;


  Book_other_writings({this.email, this.writer_name, this.book_title,
    this.book_subtitle, this.book_no,
    this.book_detail});


  factory Book_other_writings.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Book_other_writings(
      email : json['email'],
      writer_name: json['writer_name'],
      book_title: json['book_title'],
      book_subtitle: json['book_subtitle'],
      book_no: json['book_no'],

      book_detail: json['book_detail'],

    ) : null;
  }
}
