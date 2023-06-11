import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flip Tunes!"),
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text('About')),
                const PopupMenuItem<int>(value: 1, child: Text('Share')),
                const PopupMenuItem<int>(value: 2, child: Text('More Apps')),
                const PopupMenuItem<int>(
                    value: 3, child: Text('Buy Me A Coffee')),
              ],
            ),
          ],
        ),
        body: ToyApp(),
      ),
    ),
  );
}

void handleClick(int item) {
  switch (item) {
    case 0:
      launchUrl(Uri.parse(
          'https://www.instagram.com/kumar._.bimal/')); // Replace with your "About" URL
      break;
    case 1:
      shareApp(); // Call the shareApp function for sharing functionality
      break;
  }
}

void shareApp() {
  Share.share(
      'Check out this cool FlipTunes app  https://drive.google.com/drive/folders/1aqPV1Jax18H8BkZ-uXDk8ZmUJZbwAvoF',
      subject: 'Hehe download krr lena😁');
}

class ToyApp extends StatelessWidget {
  const ToyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer?
        assetsAudioPlayer; // Add a "?" to indicate it can be null

    void playSound(String soundNumber) {
      assetsAudioPlayer
          ?.stop(); // Use "?" to call the stop() method if assetsAudioPlayer is not null

      assetsAudioPlayer = AssetsAudioPlayer();
      assetsAudioPlayer?.open(
        Audio("assets/note$soundNumber.wav"),
        autoStart: true,
        showNotification: false,
      );
      assetsAudioPlayer?.play();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: DialPad(
            enableDtmf: false,
            //outputMask: "(000) 000-0000",
            hideSubtitle: false,
            backspaceButtonIconColor: Colors.red,
            buttonTextColor: Colors.white,
            dialOutputTextColor: Colors.white,
            keyPressed: (value) {
              print('Key pressed is $value');
              playSound(value); // Call the playSound function
            },
            makeCall: (number) {
              print(number);
            },
          ),
        ),
      ),
    );
  }
}
