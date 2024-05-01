import 'dart:convert';

import 'package:http/http.dart' as https;

getAPIResponse() async {
  var url = Uri.parse(
      'https://api.apify.com/v2/datasets/9eUGCilmJ8HDf60mL/items?format=json&clean=1');
  var response = await https.get(url);
  var responseBody = jsonDecode(response.body);

  return responseBody;
}
