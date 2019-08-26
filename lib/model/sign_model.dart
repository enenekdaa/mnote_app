
class SignModel {

  final String result;
  final String accessToken;
  final String refreshToken;

  SignModel( {
    this.result, this.accessToken, this.refreshToken
  });

  factory SignModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? SignModel(
      result : json['result'] == null ? '' : json['result'],
      accessToken: json['access_token'] == null ? '' : json['access_token'],
      refreshToken: json['refresh_token'] == null ? '' : json['refresh_token'],
    ) : null;
  }
}