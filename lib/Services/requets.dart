import 'package:http/http.dart' as http;

class httpRequest{

    Future<void> PostEvent() async {
      await http.post(
  Uri.parse("https://localhost:44309/api/Events/"),
  body: {
    
  });
    }

}