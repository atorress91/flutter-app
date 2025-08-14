class RequestUserAuth {
  final String userName;
  final String password;
  final String? browserInfo;
  final String? operatingSystem;
  final String? ipAddress;

  RequestUserAuth({
    required this.userName,
    required this.password,
    this.browserInfo,
    this.operatingSystem,
    this.ipAddress,
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'password': password,
    'browserInfo': browserInfo,
    'operatingSystem': operatingSystem,
    'ipAddress': ipAddress,
  };
}
