import 'Book_detail.dart';

class Book_today {

  final String daily_list_no;
  final String daily_title;
  final String date;
  final String daily_sentence;

  final String daily_writer;
  final String daily_from;


  Book_today( {

    this.daily_list_no, this.daily_title, this.date, this.daily_sentence, this.daily_writer, this.daily_from
  });

  factory Book_today.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Book_today(
        daily_list_no : json['daily_list_no'],
        daily_title: json['daily_title'],
        date: json['date'],
        daily_sentence: json['daily_sentence'],
        daily_writer: json['daily_writer'],
        daily_from: json['daily_from'],

    ) : null;
  }
}
