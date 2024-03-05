class UserModel {
  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      this.admin = false});
  String username;
  String email;
  String password;

  bool admin;

  factory UserModel.fromJson(json) => UserModel(
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      admin: json["admin"] ?? false);

  toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "admin": admin,
    };
  }
}

class YemekModel {
  YemekModel({
    required this.restoranAdi,
    required this.yemekismi,
    required this.porsiyon,
    required this.konum,
  });
  String restoranAdi;
  String yemekismi;
  int porsiyon;
  String konum;

  factory YemekModel.fromJson(json) => YemekModel(
      restoranAdi: json["restoranAdı"] ?? "",
      yemekismi: json["yemekismi"] ?? "",
      porsiyon: json["porsiyon"] ?? "",
      konum: json["konum"]);
  toJson() {
    return {
      "restoranAdı": restoranAdi,
      "yemekismi": yemekismi,
      "porsiyon": porsiyon,
      "konum": konum
    };
  }
}

class UserAdminModel {
  UserAdminModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.phone,
      required this.restoran,
      this.admin = true});
  String username;
  String email;
  String password;
  String phone;
  String restoran;

  bool admin;

  factory UserAdminModel.fromJson(json) => UserAdminModel(
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      phone: json["phone"] ?? "",
      admin: json["admin"] ?? false,
      restoran: json["restoran"]);

  toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "phone": phone,
      "admin": admin,
      "restoran": restoran
    };
  }
}
