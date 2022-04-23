import 'dart:convert';

import 'package:demo_project/Screens/DataConstants.dart';
import 'package:http/http.dart' as http;
class ApiData{
  var link = 'http://cgprojects.in/flutter/';
  
Future  fetchAlbum() async {
  final response = await http
      .get(Uri.parse(link));
 
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.jsonDecode
    var jsonData =json.decode(response.body);
    Dataconstants.currentBookings = jsonData['current_bookings'];
    Dataconstants.packages = jsonData['packages'];

  
    
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

}