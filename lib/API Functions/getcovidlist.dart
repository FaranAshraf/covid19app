import 'package:covid19app/API%20Functions/getapiresponse.dart';

Future<List> getCovid19List() async {
  List covid19List = [];
  // Use await to wait for the future to complete
  var response = await getAPIResponse();
  for (var i = 0; i < response.length; i = i + 30) {
    covid19List.add(response[i]);
  }
  return covid19List;
}
