class ApiResponse<T> {
  final int status;
  final String message;
  final String timestamp;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.timestamp,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
      status: json["status"],
      message: json["message"],
      timestamp: json["timestamp"],
      data: json["data"],
    );
  }
}
