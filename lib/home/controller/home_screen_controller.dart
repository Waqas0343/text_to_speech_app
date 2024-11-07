import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  RxString textToSpeak = '''Muhammad,  Waqas Jafar is a highly skilled and experienced Senior Application Consultant with a proven track record in application development, consulting, and digital transformation. With extensive expertise in designing and implementing cutting-edge solutions, Waqas is passionate about helping businesses leverage technology to drive innovation and operational efficiency. His work spans a range of industries, providing tailored applications and system optimizations that meet the unique needs of each client.

As a Senior Application Consultant, Waqas combines technical proficiency with strategic insight. He excels in leading end-to-end application development projects, utilizing his in-depth knowledge of advanced programming frameworks, agile methodologies, and state-of-the-art tools. His collaborative approach and dedication to quality have made him a trusted advisor to clients and a valued leader among his peers'''.obs;
  RxInt currentWordIndex = 0.obs;
  late List<String> words;

  @override
  void onInit() {
    super.onInit();
    words = textToSpeak.value.split(' ');
    initTts();
  }

  void initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);

    flutterTts.setStartHandler(() {
      currentWordIndex.value = 0;
    });
    flutterTts.setProgressHandler((String text, int start, int end, String word) {
      int index = words.indexOf(word);
      if (index != -1) {
        currentWordIndex.value = index;
      }
    });

    flutterTts.setCompletionHandler(() {
      currentWordIndex.value = words.length;
    });
  }

  void speakText() async {
    if (textToSpeak.value.isNotEmpty) {
      await flutterTts.speak(textToSpeak.value);
    }
  }

  void stopSpeaking() async {
    await flutterTts.stop();
    currentWordIndex.value = 0;
  }

  void changeText(String newText) {
    textToSpeak.value = newText;
    words = newText.split(' ');
    currentWordIndex.value = 0;
  }
}
