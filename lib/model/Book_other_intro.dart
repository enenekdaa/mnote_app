import 'Book_detail.dart';

class Book_other_intro {

  final String book_no;
  final String member_email;
  final String book_title;
  final String book_subtitle;
  final String book_intro;

  final String writer_name;


  Book_other_intro( {

    this.book_no, this.member_email, this.book_title, this.book_subtitle, this.book_intro, this.writer_name
  });

  factory Book_other_intro.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Book_other_intro(
      book_no : json['book_no'],
      member_email: json['member_email'],
      book_title: json['book_title'],
      book_subtitle: json['book_subtitle'],
      book_intro: json['book_intro'],
      writer_name: json['writer_name'],

    ) : null;
  }
}
