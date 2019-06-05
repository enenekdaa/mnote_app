class Chapter_detail {

  final String email;
  final String writer_name;
  final String book_title;

  final String book_subtitle;
  final String chapter_no;
  final String chapter_title;
  final String chapter_start_date;
  final String contents_align_center;
  final String contents;
  final String write_show;

  Chapter_detail( {

    this.email, this.writer_name, this.book_title , this.book_subtitle, this.chapter_no, this.chapter_title ,this.chapter_start_date, this.contents_align_center, this.contents ,this.write_show
  });

  factory Chapter_detail.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Chapter_detail(
      email : json['email'],
      writer_name: json['writer_name'],
      book_title: json['book_title'],

      book_subtitle : json['book_subtitle'],
      chapter_no: json['chapter_no'],
      chapter_title: json['chapter_title'],

      chapter_start_date : json['chapter_start_date'],
      contents_align_center: json['contents_align_center'],
      contents: json['contents'],

      write_show : json['write_show'],

    ) : null;
  }
}