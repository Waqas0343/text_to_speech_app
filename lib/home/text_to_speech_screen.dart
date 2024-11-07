import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/home_screen_controller.dart';
import 'controller/speech_to_text_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final TextToSpeechController controller = Get.put(TextToSpeechController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Obx(
                () => RichText(
                  text: TextSpan(
                    children: controller.words.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String word = entry.value;
                      return TextSpan(
                        text: word + ' ',
                        style: TextStyle(
                          fontSize: 16,
                          color: controller.currentWordIndex.value == idx
                              ? Colors.blue
                              : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  controller.changeText(value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Text *',
                  prefixIcon: const Icon(Icons.text_fields_rounded,
                      color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.speakText();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Colors.green,
                        ),
                        child: Text('Speak',
                            style: Get.textTheme.titleSmall
                                ?.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.stopSpeaking();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Colors.red, // Set the text color of the button
                          ),
                          child: Text(
                            'Stop',
                            style: Get.textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: Get.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(()=> SpeechToTextScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                      Colors.indigo,
                    ),
                    child: Text(
                      'Speech To Text',
                      style: Get.textTheme.titleSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
