import 'Book_detail.dart';

class Book_info {

  final String email;
  final String writer_name;
  final String book_title;
  final String book_no;

  final String book_show;
  final String complete;
  final String book_start_date;
  final String book_complete_date;

  final List<Book_detail> book_detail;

  Book_info( {
    this.book_detail ,
    this.email, this.writer_name, this.book_title, this.book_no, this.book_show, this.complete, this.book_start_date, this.book_complete_date
  });

  factory Book_info.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Book_info(
      email : json['email'],
      writer_name: json['writer_name'],
      book_title: json['book_title'],
      book_no: json['bbook_no'],
      book_show: json['book_show'],
      complete: json['complete'],
      book_start_date: json['book_start_date'],
      book_complete_date: json['book_complete_date'],

      book_detail: json['book_detail']
    ) : null;
  }
}
