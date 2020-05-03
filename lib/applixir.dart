library applixir;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppLixir {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Widget adView() {
    return WebView(
      initialUrl: 'https://flutter.dev',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (webViewController) {
        _controller.complete(webViewController);
      },
    );
  }

  void loadAd() async {
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(kAppLixir));
    await _controller.future.then((controller) {
      controller.loadUrl('data:text/html;base64,$contentBase64');
    });
  }
}

const String kAppLixir = '''
<html>
<head>
    <title>entry</title>
    <script type='text/javascript' src="https://cdn.applixir.com/applixir.sdk3.0m.js"></script>
</head>
<body style="background-color: #efe4b0">
<div id="applixir_vanishing_div" hidden>
   <iframe id="applixir_parent" allow="autoplay"></iframe>
</div>
    <script type='application/javascript'>
        function adStatusCallback(status) {
            if (status)
                console.log('Applixir status: ' + status);
        }

        var options = {
            zoneId: 3033, // the zone ID from the "Games" page
            devId: 4100, // optional: your developer ID if using s2s callback
            gameId: 5071, // optional: the ID for this game from the "Games" page for s2s callback
            dMode: 1, // 0 for no MD5 checksum, 1 for MD5 checksum (recommended)
            fallback: 1, // 0 for no fallbacks, 1 will show fallback ads when ads-unavailable
            adStatusCb: adStatusCallback, // optional: function to provide helpful user messages

        };
        invokeApplixirVideoUnit(options);
    </script>

</body>

</html>
''';
