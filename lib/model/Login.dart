class Login {

  final String email;
  final String writer_name;
  final String book_title;
  final String book_no;

  final String book_show;
  final String complete;
  final String book_start_date;
  final String book_complete_date;

  Login( {

    this.email, this.writer_name, this.book_title, this.book_no, this.book_show, this.complete, this.book_start_date, this.book_complete_date
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Login(
      email : json['email'],
      writer_name: json['writer_name'],
      book_title: json['book_title'],
      book_no: json['bbook_no'],
      book_show: json['book_show'],
      complete: json['complete'],
      book_start_date: json['book_start_date'],
      book_complete_date: json['book_complete_date'],
    ) : null;
  }
}
