import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const GeevexPWA());
}

class GeevexPWA extends StatelessWidget {
  const GeevexPWA({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geevex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const GeevexHome(),
    );
  }
}

class GeevexHome extends StatefulWidget {
  const GeevexHome({super.key});

  @override
  State<GeevexHome> createState() => _GeevexHomeState();
}

class _GeevexHomeState extends State<GeevexHome> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://geevex.com'));
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // For web platform, launch the URL in a new tab
      launchUrl(Uri.parse('https://geevex.com'));
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // For mobile platforms, use WebView
      return Scaffold(
        body: WebViewWidget(controller: controller),
      );
    }
  }
}
