class Daily_writings {

  final String email;
  final String book_no;
  final String chapter_no;

  final String chapter_title;
  final String writer_name;
  final String contents;

  final String contents_align_center;
  final String chapter_start_date;
  final String daily_date;


  Daily_writings({this.email, this.book_no, this.chapter_no, this.chapter_title,
      this.writer_name, this.contents, this.contents_align_center,
      this.chapter_start_date, this.daily_date});



  factory Daily_writings.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Daily_writings(
      email : json['email'],
      book_no: json['book_no'],
      chapter_no: json['chapter_no'],
      chapter_title: json['chapter_title'],
      writer_name: json['writer_name'],
      contents: json['contents'],

      contents_align_center: json['contents_align_center'],
      chapter_start_date: json['chapter_start_date'],
      daily_date: json['daily_date'],

    ) : null;
  }
}
