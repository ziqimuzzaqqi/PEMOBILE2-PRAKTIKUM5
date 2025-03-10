import 'package:http/http.dart' as http;

void main() async {
  final response = await http.get(
    Uri.parse("https://cms.cicd.my.id/items/fr_banners"),
  );
  if (response.statusCode == 200) {
    print(response.body);
  }
}
