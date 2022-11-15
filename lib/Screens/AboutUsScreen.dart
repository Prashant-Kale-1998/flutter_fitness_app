import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


import '../Themes.dart';
import '../main.dart';
import 'Settings.dart';


class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: WHITE,
            elevation: 0,
            flexibleSpace: customDialogues.header(
              context: context,
              text: " ",
            ),
            leading: Container(),
          ),
          body: SafeArea(

            child: Scaffold(
              backgroundColor: WHITE,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: WebView(
                  initialUrl: 'about:blank',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                    _loadHtmlFromAssets();
                  },
                ),
              ),
            ),
          )
      ),
    );
  }

  Widget header(){
    return Stack(
      children: [

        Container(
          height: 60,
          child: Row(
            children: [
              SizedBox(width: 15,),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Settings()));
                },
                child: Image.asset("assets/back.png",
                  height: 25,
                  width: 22,
                ),
              ),
              // SizedBox(width: 10,),
              // Text(
              //   "about_us",
              //   style: TextStyle(
              //       fontWeight: FontWeight.w600,
              //       color: WHITE,
              //       fontSize: 22
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/aboutus.html');
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}

