import 'chapter_model.dart';
class BookModel {
  String email;
  String writerName;
  String bookTitle;
  String bookNo;
  String bookShow;
  String complete;
  String bookSubtitle;
  String bookStartDate;
  String bookCompleteDate;
  String bookCoverImgNo;
  String bookIntro;
  List<ChapterModel> bookDetail;

  BookModel({
    this.email,
    this.writerName,
    this.bookTitle,
    this.bookNo,
    this.bookShow,
    this.complete,
    this.bookSubtitle,
    this.bookStartDate,
    this.bookCompleteDate,
    this.bookCoverImgNo,
    this.bookIntro,
    this.bookDetail,
  });

  // http://icomerict.cafe24.com/untitled_note/cover/book_cover_img_no값.jpg

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? BookModel(
            email: json['email'] == null ? '' : json['email'],
            writerName: json['writer_name'] == null ? '' : json['writer_name'],
            bookTitle: json['book_title'] == null ? '' : json['book_title'],
            bookNo: json['book_no'] == null ? '' : json['book_no'],
            bookShow: json['book_show'] == null ? '' : json['book_show'],
            complete: json['complete'] == null ? '' : json['complete'],
            bookStartDate:
                json['book_start_date'] == null ? '' : json['book_start_date'],
//            bookCoverImgNo: 'http://icomerict.cafe24.com/untitled_note/cover/0.jpg',
            bookCoverImgNo:  json['book_cover_img_no'] == null ? '' : json['book_cover_img_no'],
//            bookCompleteDate: json['book_complete_date'] == null
//                ? ''
//                : 'http://icomerict.cafe24.com/untitled_note/cover/0.jpg',
            bookDetail: json['book_detail'] == null ? [] : json['book_detail'],
            bookSubtitle:
                json['book_subtitle'] == null ? '' : json['book_subtitle'],
            bookIntro:
                json['book_intro'] == null ? '' : json['book_intro'],
          )
        : null;
  }
}
