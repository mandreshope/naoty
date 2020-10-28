import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:naoty/app/data/models/me_model.dart';
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/models/user_model.dart';
import 'package:naoty/app/data/providers/end_point.dart';
import 'package:naoty/app/tools/tools.dart';

const baseUrl = 'https://strapi-naoty.herokuapp.com';

class ApiClient {

  final GetStorage token = GetStorage();
  Duration timeout = Duration(minutes: 1);

  final http.Client httpClient;
  ApiClient({@required this.httpClient});

  Future getAll(String userId, int limit) async {
    try {
      var response = await httpClient.get('$baseUrl${EndPoint.notes}?users_permissions_user=$userId&_limit=$limit&_sort=createdAt:DESC')
      .timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        Iterable iterable = jsonResponse;
        List<NoteModel> result = iterable.map((model) => NoteModel.fromJson(model)).toList();
        return result;
      }else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future me() async {
    try {
      var response = await httpClient.get('$baseUrl${EndPoint.me}', headers:  {
        "Authorization": "Bearer ${token.read(tokenBox)}",
      })
      .timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        MeModel result = MeModel.fromJson(jsonResponse);
        return result;
      }else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future getUser(String id) async {
    try {
      var response = await httpClient.get('$baseUrl${EndPoint.user}$id', headers:  {
        "Authorization": "Bearer ${token.read(tokenBox)}",
      })
      .timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        MeModel result = MeModel.fromJson(jsonResponse);
        return result;
      }else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future delete(id) async {
    try {
      var response = await httpClient.delete(
        '$baseUrl${EndPoint.notes}$id', headers:  {
        "Authorization": "Bearer ${token.read(tokenBox)}",
      }).timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      }else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future edit(String id, String content) async {
    try {
      var response = await httpClient.put(
        '$baseUrl${EndPoint.notes}$id', 
        body: {
          'content': content
        },
      ).timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        NoteModel result = NoteModel.fromJson(jsonResponse);
        return result;
      }else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future add(String content, String userId) async {
    try {
      var response = await httpClient.post(
        '$baseUrl${EndPoint.notes}', 
        body: {
          'content': content,
          "users_permissions_user": userId
        },
      ).timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        NoteModel result = NoteModel.fromJson(jsonResponse);
        return result;
      }else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future login(String identifier, String password) async {
    try {
      var response = await httpClient.post(
        '$baseUrl${EndPoint.login}', 
        body: {
          'identifier': identifier,
          'password': password
        },
      ).timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        UserModel result = UserModel.fromJson(jsonResponse);
        return result;
      }else if(response.statusCode == 400) {
        throw "Identifiant ou mot de passe invalide.";
      }else throw "Erreur serveur.";
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future register(String username, String email, String password) async {
    try {
      var response = await httpClient.post(
        '$baseUrl${EndPoint.register}', 
        body: {
          'username': username,
          'email': email,
          'password': password
        },
      ).timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        UserModel result = UserModel.fromJson(jsonResponse);
        return result;
      }else if(response.statusCode == 400) {
        var jsonResponse = json.decode(response.body);
        throw jsonResponse["data"][0]["messages"][0]["message"];
      }
      else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future forgotPassword(String email) async {
    try {
      var response = await httpClient.post(
        '$baseUrl${EndPoint.forgotPassword}', 
        body: {
          'email': email
        },
      ).timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      }else throw 'Erreur serveur.';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  Future resetPassword(String code, String password, String passwordConfirmation) async {
    try {
      var response = await httpClient.post(
        '$baseUrl${EndPoint.resetPassword}', 
        body: {
          'code': code,
          'password': password,
          'passwordConfirmation': passwordConfirmation
        },
      ).timeout(timeout);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        UserModel result = UserModel.fromJson(jsonResponse);
        return result;
      }else throw 'Code incorrect';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

}