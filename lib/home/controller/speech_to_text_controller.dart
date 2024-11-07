import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextController extends GetxController {
  final stt.SpeechToText speechToText = stt.SpeechToText();
  var isListening = false.obs;
  var recognizedText = ''.obs;
  var isInitialized = false.obs;

  void startListening() async {
    if (!isInitialized.value) {
      bool available = await speechToText.initialize(
        onStatus: (status) {
          isListening.value = speechToText.isListening;
        },
        onError: (error) {
          print("Error: $error");
        },
      );
      isInitialized.value = available;
    }

    if (isInitialized.value) {
      speechToText.listen(
        onResult: (result) {
          recognizedText.value = result.recognizedWords;
        },
      );
      isListening.value = true;
    }
  }

  void stopListening() {
    speechToText.stop();
    isListening.value = false;
  }
}
