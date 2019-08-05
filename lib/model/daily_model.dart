class DailyModel {
  final String dailyListNo;
  final String dailyTitle;
  final String dailySentence;
  final String dailyWriter;
  final String dailyFrom;
  final String dailyDate;
  final String showCount;
  final String allCount;

  DailyModel({
    this.dailyListNo,
    this.dailyTitle,
    this.dailySentence,
    this.dailyWriter,
    this.dailyFrom,
    this.dailyDate,
    this.showCount,
    this.allCount
  });

  factory DailyModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? DailyModel(
      dailyListNo: json['daily_list_no'] == null ? '' : json['daily_list_no'],
      dailyTitle: json['daily_title'] == null ? '' : json['daily_title'],
      dailySentence: json['daily_sentence'] == null ? '' : json['daily_sentence'],
      dailyWriter: json['daily_writer'] == null ? '' : json['daily_writer'],
      dailyFrom: json['daily_from'] == null ? '' : json['daily_from'],
      dailyDate: json['daily_date'] == null ? '' : json['daily_date'],
      showCount: json['show_count'] == null ? '' : json['show_count'],
      allCount: json['all_count'] == null ? '' : json['all_count'],
    )
        : null;
  }
}
