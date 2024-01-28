import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trad_img/translation_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool textScanning = false;

  XFile? fichier;

  String textScanne = "";

  String finaltextScanne = "";

  String traduite = "traduite";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reconnaissance de Texte dans les images"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && fichier == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (fichier != null) Image.file(File(fichier!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            choisImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            choisImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.black,
                  child: ScreenUtilInit(
                    designSize: const Size(240, 360),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 150,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  textScanne,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.white),
                                ),
                              ),
                            )),
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 0, right: 0),
                              child: Positioned(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  copyText(context: context);
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      size: 20,
                                    )
                                  ],
                                ),
                              )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 3,
                  width: 300,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.black,
                  child: ScreenUtilInit(
                    designSize: const Size(240, 360),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 150,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  finaltextScanne,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.white),
                                ),
                              ),
                            )),
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 0, right: 0),
                              child: Positioned(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  copyTextG(context: context);
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      size: 20,
                                    )
                                  ],
                                ),
                              )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      )),
    );
  }

  void choisImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        fichier = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
        finaltextScanne = (await TranslationApi.tanslatetext(textScanne))!;
      }
    } catch (e) {
      textScanning = false;
      fichier = null;
      textScanne = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    textScanne = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        textScanne = textScanne + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  copyText({required BuildContext context}) async {
    if (textScanne!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: textScanne));
      messageInfo(context: context, text: "Test original copie");
    } else {
      messageInfo(context: context, text: "L'image ne contient pas de texte");
    }
  }

  messageInfo({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  copyTextG({required BuildContext context}) async {
    if (finaltextScanne!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: finaltextScanne));
      messageInfo(context: context, text: "Test taduit copie");
    } else {
      messageInfo(context: context, text: "L'image ne contient pas de texte");
    }
  }

  messageInfos({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void initState() {
    super.initState();
  }
}
