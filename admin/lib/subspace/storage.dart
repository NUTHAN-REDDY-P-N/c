import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io'; // For mobile file handling

class SubspaceService {
  final String apiKey = '<YOUR_API_KEY>'; // Replace with your actual API key
  final String baseUrl = 'https://judwbcxsuiziyumshahq.supabase.co';

  // Upload file to Subspace
  Future<Map<String, dynamic>> uploadFile(dynamic file) async {
    final url = Uri.parse(
        'https://cors-anywhere.herokuapp.com/https://judwbcxsuiziyumshahq.supabase.co/upload/images');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $apiKey';

    if (kIsWeb) {
      // For web platform
      final fileBytes = file as Uint8List;
      request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
          filename: 'upload.jpg'));
    } else {
      // For mobile platform
      final filePath = file as String;
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
    }

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to upload file: ${response.statusCode}');
    }
  }

  // Download file from Subspace
  Future<http.Response> downloadFile(String fileId) async {
    final url = Uri.parse('$baseUrl/download/$fileId');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $apiKey',
    });

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to download file: ${response.statusCode}');
    }
  }
}
