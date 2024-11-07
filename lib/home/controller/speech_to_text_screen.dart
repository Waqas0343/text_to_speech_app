import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_to_speech_app/home/controller/speech_to_text_controller.dart';

class SpeechToTextScreen extends StatelessWidget {
  const SpeechToTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SpeechToTextController controller = Get.put(SpeechToTextController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Speech To Text"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              controller.recognizedText.value.isEmpty
                  ? "Press the button and start speaking"
                  : controller.recognizedText.value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            )),
            const SizedBox(height: 20),
            Obx(() => Icon(
              controller.isListening.value ? Icons.mic : Icons.mic_off,
              color: controller.isListening.value ? Colors.red : Colors.grey,
              size: 80,
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.isListening.value) {
                  controller.stopListening();
                } else {
                  controller.startListening();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Obx(() => Text(
                controller.isListening.value ? "Stop Listening" : "Start Listening",
                style: const TextStyle(fontSize: 20),
              )),
            ),
          ],
        ),
      ),
    );
  }
}