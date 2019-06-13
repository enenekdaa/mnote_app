class Book_detail {

  final String chapter_no;
  final String chapter_title;
  final String chapter_start_date;

  Book_detail( {

    this.chapter_no, this.chapter_title, this.chapter_start_date
  });

  factory Book_detail.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Book_detail(
      chapter_no : json['chapter_no'],
      chapter_title: json['chapter_title'],
      chapter_start_date: json['chapter_start_date'],
    ) : null;
  }
}
