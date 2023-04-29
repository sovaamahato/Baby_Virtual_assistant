import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = false;
  TextEditingController userTexteditingController = TextEditingController();
  final SpeechToText speechToText = SpeechToText();

  String recordedaudiotext = "";
  void initializeSpeechText() async {
    await speechToText.initialize();
    setState(() {});
  }

  void startListningNow() async {
    Focus.of(context).unfocus();
    await speechToText.listen(onResult: onSpeechToTextResult);
    setState(() {});
  }

  void stopListningNow() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechToTextResult(SpeechRecognitionResult recognitionResult) {
    recordedaudiotext = recognitionResult.recognizedWords;
    print("recorded words: ");
    print(recordedaudiotext);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSpeechText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset(
            "lib/images/volume.png",
            color: Color.fromARGB(255, 4, 47, 121),
          ),
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purpleAccent.shade100, Colors.deepPurple])),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset(
            "lib/images/atom.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "OpenAI",
          style: TextStyle(color: Color.fromARGB(255, 8, 59, 146)),
        ),
        titleSpacing: 7,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //image
            Center(
              child: InkWell(
                onTap: () {
                  speechToText.isListening
                      ? stopListningNow()
                      : startListningNow();
                },
                child: speechToText.isListening
                    ? Center(
                        child: LoadingAnimationWidget.beat(
                          size: 300,
                            color: speechToText.isListening
                                ? Colors.deepPurple
                                : isloading
                                    ? Colors.deepPurple[400]!
                                    : Colors.deepPurple[200]!),
                      )
                    : Image.asset(
                        "lib/images/audio-waves.png",
                        height: 300,
                        width: 300,
                      ),
              ),
            )
            //text
            ,
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                //textfield
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: userTexteditingController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "How can i help you?"),
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                //button
                InkWell(
                  onTap: () {},
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.deepPurpleAccent),
                    duration: const Duration(microseconds: 1000),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
