// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, empty_catches, use_key_in_widget_constructors, sized_box_for_whitespace, duplicate_ignore, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import 'package:video_player/video_player.dart';
import 'package:restmenus/feedback_model.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:chewie/chewie.dart';
// ignore: unused_import
import 'dart:ui' as ui;

class FeedMe extends StatefulWidget {
  const FeedMe({Key? key});

  @override
  State<FeedMe> createState() => _FeedMeState();
}

class _FeedMeState extends State<FeedMe> {
  List<String> lang = ["Amharic", "english", "chineese", "france", "Arabic"];
  String selectedLang = "english";
  List<FeedbackModel> feedbacks = [];

  List<dynamic> specialnames = [];
  List<dynamic> specialid = [];
  List<dynamic> specialingredients = [];
  List<dynamic> specialvideos = [];
  List<dynamic> specialprices = [];
  List<dynamic> subnames = [];
  List<dynamic> subid = [];
  List<dynamic> subingredients = [];
  List<dynamic> subvideos = [];
  List<dynamic> subprices = [];
  List jsonfeedback = [];
  List catagorylist = [];
  var catagorynumber = 0;

  getFeedbackFromSheet() async {
    var url = Uri.parse(
        "https://script.google.com/macros/s/AKfycbze5p_oU5Eq-njQsNfyCHjGixlsaMPJQGl0Zgca0buUwOYi-Vd2c21UyZ_zfFZi4w4R/exec");

    var response = await http.get(url);
    jsonfeedback = convert.jsonDecode(response.body);

    //print(jsonfeedback);
    setState(() {
      catagorylist =
          jsonfeedback[2].map((item) => item['name'].toString()).toList();
      specialnames =
          jsonfeedback[3].map((item) => item['name'].toString()).toList();
      specialid = jsonfeedback[3].map((item) => item['id'].toString()).toList();
      specialingredients = jsonfeedback[3]
          .map((item) => item['ingredients'].toString())
          .toList();
      specialvideos =
          jsonfeedback[3].map((item) => item['video'].toString()).toList();
      specialprices =
          jsonfeedback[3].map((item) => item['price'].toString()).toList();
    });
  }

  getsubcatagory() async {
    subnames = await jsonfeedback[catagorynumber]
        .map((item) => item['name'].toString())
        .toList();
    subid = await jsonfeedback[catagorynumber]
        .map((item) => item['id'].toString())
        .toList();
    subingredients = await jsonfeedback[catagorynumber]
        .map((item) => item['ingredients'].toString())
        .toList();
    subvideos = await jsonfeedback[catagorynumber]
        .map((item) => item['video'].toString())
        .toList();
    subprices = await jsonfeedback[catagorynumber]
        .map((item) => item['price'].toString())
        .toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFeedbackFromSheet();
    //getsubcatagory();
  }

  bool show = false;

  int focusedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double wdth = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: hight * 0.09,
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Image.network(
                    'https://res.cloudinary.com/dxvzzdaln/image/upload/v1708252404/videos/image/restlogo_zdl5oa.png',
                    height: hight * 0.3,
                    width: wdth * 0.25,
                  ),
                  // Image.asset(
                  //   'assets/logo.png',
                  //   height: hight * 0.3,
                  //   width: wdth * 0.25,
                  // ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(1, 20, 1, 0),
                    width: wdth * 0.5,
                    height: hight * 0.3,
                    alignment: Alignment.topLeft,
                    child: Text(
                      " \t\t\t\t\t\t\t\t\t\t\t\t\t WELCOME TO  \n \t\t AMANADDIS RESTAURANT  \n \t\t\t\t\t\t\t\t\t\t\t\t\t FOOD MENU",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: wdth * 0.03,
                        color: const Color.fromARGB(255, 12, 56, 92),
                      ),
                    ),
                  ),
                  // Initialize selectedLang with a default value

                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: DropdownButton<String>(
                      value: selectedLang, // Specify the selected value
                      items: lang
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: wdth * 0.03,
                                    color:
                                        const Color.fromARGB(255, 12, 56, 92),
                                  ),
                                ),
                              ))
                          .toList(),
                      hint: const Text('language'),
                      onChanged: (value) {
                        setState(() {
                          selectedLang = value
                              .toString(); // Update selectedLang with the new value
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Container(

                  //   margin: const EdgeInsets.only(left: 5),
                  //   child: DropdownButton<String>(
                  //     items: lang
                  //         .map((item) => DropdownMenuItem<String>(
                  //               value: item,
                  //               child: Text(
                  //                 item,
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: wdth * 0.03,
                  //                   color:
                  //                       const Color.fromARGB(255, 12, 56, 92),
                  //                 ),
                  //               ),
                  //             ))
                  //         .toList(),
                  //     hint: const Text('english'),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedLang = value.toString();
                  //       });
                  //     },
                  //     icon: const Icon(
                  //       Icons.arrow_drop_down_sharp,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              width: wdth,
              height: hight * 0.06,
              child: ListView.builder(
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 4,
                //   crossAxisSpacing: 10.0,
                //   mainAxisSpacing: 10.0,
                // ),
                scrollDirection: Axis.horizontal,
                itemCount: catagorylist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        show = false;

                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            show = true;
                          });
                        });

                        catagorynumber = index;
                        getsubcatagory();
                        // show=true;
                      });
                    },
                    child: Container(
                      // height: hight * 0.08,
                      width: wdth * 0.25,
                      padding: EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 12, 56, 92),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: EdgeInsets.all(5),

                      // child: FittedBox(
                      child: Center(
                        child: Text(
                          catagorylist[index],
                          style: TextStyle(
                            fontSize: wdth * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ),
                    ),
                  );
                  //                 ElevatedButton(
                  //                   onPressed: () {
                  //                     setState(() {

                  //                       show=false;

                  //                       Future.delayed(const Duration(seconds: 3), () {
                  //                         setState(() {
                  //                           show=true;
                  //                         });

                  // });

                  //                        catagorynumber = index;
                  //                       getsubcatagory();
                  //                      // show=true;
                  //                     });

                  //                   },
                  //                   style: ElevatedButton.styleFrom(
                  //                     primary: const Color.fromARGB(255, 12, 56, 92),
                  //                     shape: RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(8.0),
                  //                     ),
                  //                     elevation: 5.0,
                  //                   ),
                  //                   child: Center(
                  //                     child: Text(
                  //                       catagorylist[index],
                  //                       style: TextStyle(
                  //                         fontSize: wdth * 0.03,
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 );
                },
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: hight * 0.83,
              width: wdth,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: hight * 0.03,
                    width: wdth * 0.33,
                    child: Text(
                      'HOUSE SPECIAL',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: wdth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    //  color: Colors.blue,
                    height: hight * 0.3,
                    width: wdth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: specialvideos.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: wdth * 0.9,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 12, 56, 92),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                specialnames[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: wdth * 0.03),
                              )),
                            ),
                            Container(
                                width: wdth * 0.9,
                                height: hight * 0.2,
                                color: const Color.fromARGB(255, 12, 56, 92),
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: VideoContainer(
                                    videoUrl: specialvideos[index])),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 12, 56, 92),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: wdth * 0.9,
                              child: Center(
                                  child: Text(
                                specialprices[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: wdth * 0.03),
                              )),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  Container(
                      child: (show)
                          ? Container(
                              //  color: Colors.amber,
                              height: hight * 0.6,
                              width: wdth,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: subvideos.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          width: wdth * 0.9,
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 12, 56, 92),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            subnames[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: wdth * 0.03),
                                          )),
                                        ),
                                        Container(
                                            width: wdth * 0.9,
                                            height: hight * 0.3,
                                            color: const Color.fromARGB(
                                                255, 12, 56, 92),
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: VideoContainer(
                                                videoUrl: subvideos[index])),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 12, 56, 92),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0),
                                            ),
                                          ),
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          width: wdth * 0.9,
                                          child: Center(
                                              child: Text(
                                            subprices[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: wdth * 0.03),
                                          )),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              //  color: Colors.brown,
                              height: hight * 0.6,
                              width: wdth,
                              child: Image.network(
                                  'https://res.cloudinary.com/dxvzzdaln/image/upload/v1708002377/videos/image/advertise-your-business-here-300x232_unoioj.png'),
                            )),
                  Container(
                    width: wdth,
                    height: hight * 0.08,
                    // color: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            // color: Colors.amber,
                            width: wdth,
                            height: hight * 0.1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Developed by  AmanAddis software plc',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: wdth * 0.03),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      ' Contact us:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: wdth * 0.03),
                                    ),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                  //        Container(child: ,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoContainer extends StatefulWidget {
  final String videoUrl;

  const VideoContainer({super.key, required this.videoUrl});

  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  ChewieController? _chewieController;
  late VideoPlayerController _videoPlayerController;
  bool _isInitializing = true;
  bool _isControllerInitialized = false;
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    // Dispose the Chewie controller first to ensure it doesn't use the video player controller
    _chewieController?.dispose();
    // Then dispose the video player controller
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    // Add listener to check when the controller is initialized
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isInitialized) {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          // autoPlay: true,
          looping: true,
          showControls: false,
          autoInitialize: true,
          //   allowPlaybackSpeedChanging: false,
          //  allowFullScreen: false,
        );
        // _chewieController?.addListener(_onVideoEnded);
        setState(() {
          _isInitializing = false;
          _isControllerInitialized = true;
        });
      }
    });

    // Initialize the video player controller
    await _videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return _isControllerInitialized // Check if the controller is initialized
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: VisibilityDetector(
              key: Key(widget.videoUrl),
              onVisibilityChanged: (visibilityInfo) {
                if (_chewieController != null) {
                  if (visibilityInfo.visibleFraction >= 0.75) {
                    _chewieController?.play();
                  } else if (visibilityInfo.visibleFraction <= 0.5) {
                    _chewieController?.pause();
                  }
                }
              },
              child: _isInitializing
                  ? const Center(child: CircularProgressIndicator())
                  : _chewieController != null
                      ? Chewie(
                          controller: _chewieController!,
                        )
                      : const SizedBox.shrink(),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
