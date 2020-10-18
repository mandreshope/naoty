import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naoty/app/data/models/note_model.dart';
import 'package:naoty/app/data/providers/end_point.dart';

const baseUrl = 'http://localhost:1337';

class ApiClient {
  Map<String, String> headers = {};
  Map<String, String> cookies = {};

  final http.Client httpClient;
  ApiClient({@required this.httpClient});

  Future getAll() async {
    try {
      var response = await httpClient.get('$baseUrl${EndPoint.getAll}');
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        Iterable iterable = jsonResponse['data'];
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

  add(obj){

  }

}