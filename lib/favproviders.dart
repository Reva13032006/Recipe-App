import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class Favproviders  extends ChangeNotifier{
  List<Map<String,Object>> _fav=[];
  List<Map<String,Object>> get fav=> _fav;
  Favproviders(){
    loadFav();
  }
  void addFav(Map <String,Object> item){
    _fav.add(item);
    saveFav();
    notifyListeners();
  }

  void removeFav(Map <String,Object> item){
    _fav.removeWhere((element)=>element['title']==item['title']);
    saveFav();
    notifyListeners();
  }

  bool isfav(Map<String,Object> item){
    return _fav.any((element)=>element['title']==item['title']);
  }

  Future<void> loadFav() async{
    final prefs=await SharedPreferences.getInstance();
    final favList=prefs.getStringList('favList')??[];

    _fav=favList.map((e)=>Map<String,Object>.from(jsonDecode(e))).toList();
    notifyListeners();
  }
 
 Future<void> saveFav() async{
    final prefs=await SharedPreferences.getInstance();
    final favList=fav.map((e)=>jsonEncode(e)).toList();
    await prefs.setStringList('favList', favList);
  }
}