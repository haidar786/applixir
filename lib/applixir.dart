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
<body style="background-color: #efe4b0">
<div id="applixir_vanishing_div" hidden>
   <iframe id="applixir_parent" allow="autoplay"></iframe>
</div>
    <script type='text/javascript' src="https://cdn.applixir.com/applixir.sdk3.0m.js"></script>

    <script type='application/javascript'>
        function adStatusCallback(status) {
            // This can contain whatever code you like. The err parameter will return the
            // following values (please DO NOT block callback thread or ad will fail):
            //	'ad-blocker' = an ad blocker was detected
            //	'network-error' = network connection not available
            //  'cors-error' = cross-origin error (try clearing browser cache)
            //  'no-zoneId' = the required zoneId value is missing
            //  'ad-started' = an ad has been loaded and is starting
            //  'fb-started' = a fallback has been started by fallback mode
            //	'ad-watched' = an ad was presented and ran successfully
            //  'fb-watched' = a fallback ad was presented and ran successfully
            //	'ad-interrupted' = ad was ended prior to 5 seconds (abnormal end)
            //	'ads-unavailable' = no ads were returned to the player
            //  'sys-closing' = the process has completed and the player is closing.

            if (status)
                console.log('Applixir status: ' + status);

        }

        var options = {
            zoneId: 3033, // the zone ID from the "Games" page
            devId: 4100, // optional: your developer ID if using s2s callback
            gameId: 5071, // optional: the ID for this game from the "Games" page for s2s callback
//            custom1: nnnn, // optional: custom1 value for s2s callback
//            custom2: nnnn, // optional: custom2 value for s2s callback
            dMode: 0, // 0 for no MD5 checksum, 1 for MD5 checksum (recommended)
            fallback: 0, // 0 for no fallbacks, 1 will show fallback ads when ads-unavailable
            adStatusCb: adStatusCallback, // optional: function to provide helpful user messages

        };
        invokeApplixirVideoUnit(options);
    </script>

</body>

</html>
''';
