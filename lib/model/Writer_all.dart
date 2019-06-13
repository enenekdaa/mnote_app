class Writer_all {

  final String writer_email;
  final String writer_name;
  final String writer_intro;

  final String book_count;
  final String subscribe_count;
  final String subscribeYN;


  Writer_all({this.writer_email, this.writer_name, this.writer_intro, this.book_count,
    this.subscribe_count, this.subscribeYN});



  factory Writer_all.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Writer_all(
      writer_email : json['writer_email'],
      writer_name: json['writer_name'],
      writer_intro: json['writer_intro'],
      book_count: json['book_count'],
      subscribe_count: json['subscribe_count'],
      subscribeYN: json['subscribeYN'],

    ) : null;
  }
}
