import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lord_of_quizzs/model/ban_be_object.dart';

class BanBeProvider{
  static Future<List<BanBeObject>> getBanBe(String email) async {
    List<BanBeObject> listBanBe = []; 
    final snapshot = await FirebaseFirestore.instance.collection("ban_be")
    .where('email', isEqualTo: email).where('trang_thai', isEqualTo: 1).get();
    // ignore: no_leading_underscores_for_local_identifiers
     listBanBe = snapshot.docs.map((json) => BanBeObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return listBanBe;
  }

  static Future<List<BanBeObject>> getBanBeRequest(String email) async {
    List<BanBeObject> listBanBe = []; 
    final snapshot = await FirebaseFirestore.instance.collection("ban_be")
    .where('email', isEqualTo: email).where('trang_thai', isEqualTo: 0).get();
    // ignore: no_leading_underscores_for_local_identifiers
     listBanBe = snapshot.docs.map((json) => BanBeObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return listBanBe;
  }

  static Future<List<BanBeObject>> getBanBeAll() async {
    List<BanBeObject> listBanBe = []; 
    final snapshot = await FirebaseFirestore.instance.collection("ban_be")
    .where('trang_thai', isEqualTo: 1).get();
    // ignore: no_leading_underscores_for_local_identifiers
     listBanBe = snapshot.docs.map((json) => BanBeObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return listBanBe;
  }
}