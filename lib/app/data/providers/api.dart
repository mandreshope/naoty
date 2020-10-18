import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/providers/end_point.dart';

const baseUrl = 'https://strapi-naoty.herokuapp.com';

class ApiClient {
  Map<String, String> headers = {};
  Map<String, String> cookies = {};

  final http.Client httpClient;
  ApiClient({@required this.httpClient});

  Future getAll() async {
    try {
      var response = await httpClient.get('$baseUrl${EndPoint.notes}')
      .timeout(Duration(minutes: 1));
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        Iterable iterable = jsonResponse;
        List<NoteModel> result = iterable.map((model) => NoteModel.fromJson(model)).toList();
        return result;
      }else throw 'error server';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

  getId(id){

  }

  delete(id){

  }

  edit(obj){

  }

  Future add(String content) async {
    try {
      var response = await httpClient.post(
        '$baseUrl${EndPoint.notes}', 
        body: {
          'content': content
        },
      ).timeout(Duration(minutes: 1));
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        NoteModel result = NoteModel.fromJson(jsonResponse['data']);
        return result;
      }else throw 'error';
    } on TimeoutException catch (_) {
      throw "Le délai d'attente est dépassé.";
    } on SocketException catch (_) {
      throw "Veuillez vérifier votre connexion Internet.";
    } on Error catch (_) {
      throw _.toString();
    } catch(_){ throw _.toString();}
  }

}