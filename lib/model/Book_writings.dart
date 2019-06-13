class Book_writings {

  final String chapter_no;
  final String chapter_title;
  final String chapter_start_date;


  Book_writings( {

    this.chapter_no, this.chapter_title, this.chapter_start_date
  });

  factory Book_writings.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Book_writings(
      chapter_no : json['chapter_no'],
      chapter_title: json['chapter_title'],
      chapter_start_date: json['chapter_start_date'],
    ) : null;
  }
}
