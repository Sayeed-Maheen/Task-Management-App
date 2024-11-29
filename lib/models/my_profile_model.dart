import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String? status;
  String? message;
  Profile? data;

  Welcome({
    this.status,
    this.message,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Profile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Profile {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? address;
  String? image;
  int? activationCode;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.address,
    this.image,
    this.activationCode,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        image: json["image"],
        activationCode: json["activationCode"],
        isVerified: json["isVerified"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "address": address,
        "image": image,
        "activationCode": activationCode,
        "isVerified": isVerified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
