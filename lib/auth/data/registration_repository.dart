class RegistrationRepository {
  RegInfo regInfo = RegInfo();

  void setInfo({String? name, String? email, String? password}) {
    regInfo.copyWith(newName: name, newEmail: email, newPassword: password);
  }
}


class RegInfo {
  late final String? name;
  late final String? email;
  late final String? password;
  RegInfo({this.name, this.password, this.email});


  copyWith({String? newName, String? newEmail, String? newPassword}) {
    if (newName != null) name = newName;
    if (newEmail != null) email = newEmail;
    if (newPassword != null) password = newPassword;
  }
}