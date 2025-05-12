import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../theme/app_theme.dart';

class WebViewTab extends StatefulWidget {
  const WebViewTab({Key? key}) : super(key: key);

  @override
  State<WebViewTab> createState() => _WebViewTabState();
}

class _WebViewTabState extends State<WebViewTab> {
  late WebViewController _controller;
  bool _isLoading = true;
  String _currentUrl = 'https://mca.spit.ac.in/';
  final TextEditingController _urlController =
      TextEditingController(text: 'https://mca.spit.ac.in/');

  @override
  void initState() {
    super.initState();

    // Check if running on web. WebView is not supported on Flutter Web.
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
                _currentUrl = url;
                _urlController.text = url;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse(_currentUrl));
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If running on web, display a fallback UI
    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: Text(
            'WebView is not supported on the web platform.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _buildUrlBar(),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.home),
        onPressed: () {
          _controller.loadRequest(Uri.parse('https://mca.spit.ac.in/'));
        },
      ),
    );
  }

  Widget _buildUrlBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await _controller.canGoForward()) {
                await _controller.goForward();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
          Expanded(
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Enter URL',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    String url = _urlController.text;
                    if (!url.startsWith('http')) {
                      url = 'https://$url';
                    }
                    _controller.loadRequest(Uri.parse(url));
                  },
                ),
              ),
              onSubmitted: (url) {
                if (!url.startsWith('http')) {
                  url = 'https://$url';
                }
                _controller.loadRequest(Uri.parse(url));
              },
            ),
          ),
        ],
      ),
    );
  }
}
