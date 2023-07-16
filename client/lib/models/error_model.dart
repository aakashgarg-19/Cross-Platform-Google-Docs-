// This is the model class for the error response
class ErrorModel {
  // error is the error message
  final String? error;
  // data is the final dynamic data
  final dynamic data;

  // ErrorModel is the constructor for the ErrorModel class
  ErrorModel({this.error, this.data});

  // fromJson is a factory method that returns an ErrorModel object
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json['error'],
      data: json['data'],
    );
  }
}