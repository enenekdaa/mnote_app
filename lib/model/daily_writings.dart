class DailyWritings {
  final String email;
  final String bookNo;
  final String chapterNo;

  final String chapterTitle;
  final String writerName;
  final String contents;

  final String contentsAlignCenter;
  final String chapterStartDate;
  final String dailyDate;


  DailyWritings({this.email, this.bookNo, this.chapterNo, this.chapterTitle,
      this.writerName, this.contents, this.contentsAlignCenter,
      this.chapterStartDate, this.dailyDate});

  factory DailyWritings.fromJson(Map<String, dynamic> json) {
    return json != null
        ? DailyWritings(
      email : json['email'] == null ? '' : json['email'],
      bookNo: json['book_no']  == null ? '' : json['book_no'],
      chapterNo: json['chapter_no']  == null ? '' : json['chapter_no'],
      chapterTitle: json['chapter_title']  == null ? '' : json['chapter_title'],
      writerName: json['writer_name']  == null ? '' : json['writer_name'],
      contents: json['contents']  == null ? '' : json['contents'],
      contentsAlignCenter: json['contents_align_center']  == null ? '' : json['contents_align_center'],
      chapterStartDate: json['chapter_start_date']  == null ? '' : json['chapter_start_date'],
      dailyDate: json['daily_date']  == null ? '' : json['daily_date'],
    ) : null;
  }
}
