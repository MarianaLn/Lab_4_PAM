import "package:http/http.dart" as http;
import 'dart:convert';
import '../models/wine_model.dart';

abstract class WineDataSource {
  Future<List<WineModel>> fetchWines();
}

class WineDataSourceImpl implements WineDataSource {
  final http.Client client;

  WineDataSourceImpl(this.client);

  @override
  Future<List<WineModel>> fetchWines() async {
    final response = await client.get(Uri.parse('https://api.example.com/wines'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => WineModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching wines');
    }
  }
}
