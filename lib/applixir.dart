library applixir;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppLixir {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  Widget adView() {
    return WebView(
      initialUrl: 'https://flutter.dev',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (webViewController){
        _controller.complete(webViewController);
      },
    );
  }
}
