import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Noti with ChangeNotifier {
  var notifications = 0;

  Future<void> getNotification() async {
    final url = 'https://flutter-updated.firebaseio.com/notification.json';

    final response = await http.get(url);
    final extract = json.decode(response.body);

    notifications = extract;
    notifyListeners();
    //return extract.toString();
  }

  void clearNotification() async {
    notifications = 0;
    notifyListeners();
    final url = 'https://flutter-updated.firebaseio.com/notification.json';
    final respose = await http.put(url,body: json.encode(0));
  }

//  Future get notifications async{
//    await _getNotification();
//    print(_notifications);
//     return _notifications;
//   }
}
