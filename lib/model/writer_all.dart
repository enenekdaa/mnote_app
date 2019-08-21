class WriterAll {

  final String writerEmail;
  final String writerName;
  final String writerIntro;

  final String bookCount;
  final String subscribeCount;
  String subscribeYN;


  WriterAll({this.writerEmail, this.writerName, this.writerIntro, this.bookCount,
    this.subscribeCount, this.subscribeYN});



  factory WriterAll.fromJson(Map<String, dynamic> json) {
    return json != null
        ? WriterAll(
      writerEmail : json['writer_email'],
      writerName: json['writer_name'],
      writerIntro: json['writer_intro'],
      bookCount: json['book_count'],
      subscribeCount: json['subscribe_count'],
      subscribeYN: json['subscribeYN'],

    ) : null;
  }
}
