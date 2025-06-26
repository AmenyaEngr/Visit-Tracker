class RegisterUserDto {
  String firstName;
  String lastName;

  RegisterUserDto({required this.firstName, required this.lastName});

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
  };

  factory RegisterUserDto.fromJson(Map<String, dynamic> json) =>
      RegisterUserDto(firstName: json['firstName'], lastName: json['lastName']);
}
