class UserRegistrationRequest {
  final String userName;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String country;
  final String phoneNumber;
  final String email;
  final bool acceptedTerms;
  final String? referralUserName;
  final String? browserInfo;
  final String? ipAddress;
  final String? operatingSystem;

  UserRegistrationRequest({
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.phoneNumber,
    required this.email,
    required this.acceptedTerms,
    this.referralUserName,
    this.browserInfo,
    this.ipAddress,
    this.operatingSystem,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'confirmPassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName,
      'country': country,
      'phoneNumber': phoneNumber,
      'email': email,
      'acceptedTerms': acceptedTerms,
      if (referralUserName != null) 'referralUserName': referralUserName,
      if (browserInfo != null) 'browserInfo': browserInfo,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (operatingSystem != null) 'operatingSystem': operatingSystem,
    };
  }
}