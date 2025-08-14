class RequestUserAuth {
  final String userName;
  final String password;
  final String? browserInfo;
  final String? ipAddress;
  final String? operatingSystem;

  RequestUserAuth({
    required this.userName,
    required this.password,
    this.browserInfo,
    this.ipAddress,
    this.operatingSystem,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      if (browserInfo != null) 'browserInfo': browserInfo,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (operatingSystem != null) 'operatingSystem': operatingSystem,
    };
  }
}
