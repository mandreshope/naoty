import 'package:naoty/app/data/models/note_model.dart';

class UserModel {
  String? jwt;
  User? user;

  UserModel({this.jwt, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  bool? confirmed;
  bool? blocked;
  String? sId;
  String? username;
  String? email;
  String? provider;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Role? role;
  List<NoteModel>? notes;
  String? id;

  User(
      {this.confirmed,
      this.blocked,
      this.sId,
      this.username,
      this.email,
      this.provider,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.role,
      this.notes,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    if (json['notes'] != null) {
      notes = <NoteModel>[];
      json['notes'].forEach((v) {
        notes!.add(new NoteModel.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Role {
  String? sId;
  String? name;
  String? description;
  String? type;
  int? iV;
  String? id;

  Role({this.sId, this.name, this.description, this.type, this.iV, this.id});

  Role.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}
