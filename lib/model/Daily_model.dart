class Daily_model {

  final String daily_list_no;
  final String daily_title;
  final String daily_sentence;

  final String daily_date;
  final String show_count;
  final String all_count;


  Daily_model( {

    this.daily_date, this.daily_title, this.daily_sentence , this.daily_list_no , this.show_count , this.all_count
  });

  factory Daily_model.fromJson(Map<String, dynamic> json) {
    return json != null
        ? Daily_model(
      daily_date : json['daily_date'],
      daily_title: json['daily_title'],
      daily_sentence: json['daily_sentence'],
      daily_list_no: json['daily_list_no'],
      show_count: json['show_count'],
      all_count: json['all_count'],

    ) : null;
  }
}
