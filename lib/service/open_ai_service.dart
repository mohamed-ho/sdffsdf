import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey =
      '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'; // ضع مفتاح OpenAI هنا

  Future<String> analyzeFace(File imageFile) async {
    final uri = Uri.parse(
        "https://api.openai.com/v1/images/generate"); // API Vision Endpoint

    // تحويل الصورة إلى base64
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // إعداد بيانات الطلب
    final requestBody = jsonEncode({
      "model": "dall-e-2", // نموذج OpenAI للصور
      "image": base64Image,
      "task": "face-detection" // نطلب من OpenAI التعرف على الوجه
    });

    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print("✅ تحليل الوجه ناجح: $responseData");
      return responseData.toString();
    } else {
      print("❌ فشل تحليل الوجه: ${response.body}");
      throw Exception('there are error');
    }
  }
}
