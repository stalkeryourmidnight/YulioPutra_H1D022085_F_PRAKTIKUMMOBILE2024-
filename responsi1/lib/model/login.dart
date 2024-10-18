class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;


  Login({
    this.code,
    this.status,
    this.token,
    this.userID,
    this.userEmail,
  });

  factory Login.fromJson(Map<String, dynamic> obj) {
    if (obj['code'] == 200 && obj['status'] == true) {
      var data = obj['data'];
      var user = data != null ? data['user'] : null;

      return Login(
        code: obj['code'],
        status: obj['status'],
        token: data != null ? data['token'] : null,
        userID: user != null && user['id'] != null ? int.tryParse(user['id'].toString()) : null,
        userEmail: user != null ? user['email'] : null,
      );
    } else {
      return Login(
        code: obj['code'],
        status: obj['status'],
      );
    }
  }
}
