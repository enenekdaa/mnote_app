
class ChapterModel {
  String email;
  String writerName;
  String bookTitle;
  String bookSubtitle;
  String chapterNo;
  String chapterTitle;
  String chapterStartDate;
  String contentsAlignCenter;
  String contents;
  String writeShow;

  ChapterModel( {
    this.email, this.writerName, this.bookTitle , this.bookSubtitle, this.chapterNo, this.chapterTitle ,this.chapterStartDate, this.contentsAlignCenter, this.contents ,this.writeShow
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? ChapterModel(
      email : json['email'] == null ? '' : json['email'],
      writerName: json['writer_name'] == null ? '' : json['writer_name'],
      bookTitle: json['book_title'] == null ? '' : json['book_title'],
      bookSubtitle : json['book_subtitle'] == null ? '' : json['book_subtitle'],
      chapterNo: json['chapter_no'] == null ? '' : json['chapter_no'],
      chapterTitle: json['chapter_title'] == null ? '' : json['chapter_title'],
      chapterStartDate : json['chapter_start_date'] == null ? '' : json['chapter_start_date'],
      contentsAlignCenter: json['contents_align_center'] == null ? '' : json['contents_align_center'],
      contents: json['contents'] == null ? '' : json['contents'],
      writeShow : json['write_show'] == null ? '' : json['write_show'],
    ) : null;
  }
}