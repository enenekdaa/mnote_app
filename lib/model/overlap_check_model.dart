class OverlapCheckModel {

  final String result;

  OverlapCheckModel( {
    this.result
  });

  factory OverlapCheckModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? OverlapCheckModel(
      result : json['result'],
    ) : null;
  }
}