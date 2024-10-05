import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:sadeem_application/features/constilation/manager/constilation_cubit.dart';
import '../../../generated/assets.dart';

class ConstilationHomeWidget extends StatefulWidget {
  const ConstilationHomeWidget();

  @override
  ExampleScreen2State createState() => ExampleScreen2State();
}

class ExampleScreen2State extends State<ConstilationHomeWidget> {
  int current = -1;
  bool first = true;
  bool sec = false;
  bool third = false;
  bool fourth = false;
  bool fifth = false;
  List nums = [];
  bool _showDebugInfo = false;
  bool _useAsMap = false;
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  Random random = Random();
  bool _isHotspotVisible = false;
  int? _activeHotspotIndex;
  List<Hotspot> theRealStars = [];
  List<Image> panoImages = [
    Image.asset(Assets.stars2dAsadf2),
    Image.asset(Assets.stars2dAsadf2),
    Image.asset(Assets.stars2dAsadf2),
  ];

  @override
  void initState() {
    super.initState();
    // Call getStars only once
    theRealStars = getStars(context, 0);
  }

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  Widget hotspotButton(
      {String? text,
      String? imageasd,
      VoidCallback? onPressed,
      int? index,
      Color color = Colors.white,
      bool large = false,
      Widget? widgets,
      bool selected = false}) {
    return GestureDetector(
      onDoubleTap: () {
        if (!_useAsMap) {
          setState(() {
            _isHotspotVisible = !_isHotspotVisible;
            _activeHotspotIndex = index;
          });
        }
      },
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageasd == null
              ? widgets!
              : Container(
                  child: imageasd == null
                      ? SizedBox()
                      : Image.asset(
                          imageasd!,
                          color: color,
                          width: large ? 30 : 10,
                          height: large ? 30 : 10,
                          fit: BoxFit.fill,
                        ),
                ),
          text != null
              ? Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Center(child: Text(text)),
                )
              : Container(),
        ],
      ),
    );
  }
  Widget hotspotButtons(
      {String? text,
        String? imageasd,
        VoidCallback? onPressed,
        int? index,
        Color color = Colors.white,
        bool large = false,
        Widget? widgets,
        bool selected = false}) {
    return GestureDetector(
      onDoubleTap: () {
        if (!_useAsMap) {
          setState(() {
            _isHotspotVisible = !_isHotspotVisible;
            _activeHotspotIndex = index;
          });
        }
      },
      onTap: (){
        selected = !selected;
        setState(() {

        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child:
                Image.asset(
              imageasd!,
              color: Colors.green,
              width: large ? 30 : 10,
              height: large ? 30 : 10,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    switch (_panoId % panoImages.length) {
      case 0:
        panorama = PanoramaViewer(
          animSpeed: 0.1,
          sensorControl: SensorControl.orientation,
          onViewChanged: onViewChanged,
          hotspots: theRealStars,
          // Use the loaded stars
          child: Image.asset(Assets.stars2dAsadf2),
        );
        break;
      case 1:
        panorama = PanoramaViewer(
          animSpeed: 0.1,
          sensorControl: SensorControl.orientation,
          onViewChanged: onViewChanged,
          hotspots: [],
          child: Image.asset(Assets.stars2dAsadf2),
        );
        break;
      default:
        panorama = PanoramaViewer(
          animSpeed: 0.1,
          sensorControl: SensorControl.orientation,
          onViewChanged: onViewChanged,
          hotspots: [
            Hotspot(
              latitude: 0.0,
              longitude: 120.0,
              width: 40.0,
              height: 40.0,
              widget: hotspotButton(
                  text: "Next scene",
                  imageasd: Assets.stars2dKindpng1517300,
                  index: 6,
                  onPressed: () => setState(() {
                        _panoId = 0;
                      })),
            ),
          ],
          child: panoImages[_panoId],
        );
    }

    return Scaffold(
      body: Stack(
        children: [
          panorama,
          if (_isHotspotVisible)
            Positioned(
              bottom: 100,
              left: 50,
              child: Container(
                height: 400,
                color: Colors.white.withOpacity(0.8),
                child: Text(
                  '- Kepler-10b is so close to its star that it takes less than a day to go all the way around it, which is much faster than Earth.',
                  style: TextStyle(fontSize: 16),
                  maxLines: 10,
                ),
              ),
            ),
          if (_showDebugInfo)
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                '${_lon.toStringAsFixed(3)}, ${_lat.toStringAsFixed(3)}, ${_tilt.toStringAsFixed(3)}',
                style: const TextStyle(
                  backgroundColor: Colors.black54,
                  color: Colors.white,
                ),
              ),
            ),

            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: AnimatedButton(
            //     text: 'Success Dialog',
            //     color: Colors.green,
            //     pressEvent: () {
            //       AwesomeDialog(
            //         context: context,
            //         animType: AnimType.leftSlide,
            //         headerAnimationLoop: false,
            //         dialogType: DialogType.success,
            //         showCloseIcon: true,
            //         title: 'Succes',
            //         desc:
            //         'Dialog description here..................................................',
            //         btnOkOnPress: () {
            //           debugPrint('OnClcik');
            //         },
            //         btnOkIcon: Icons.check_circle,
            //         onDismissCallback: (type) {
            //           debugPrint('Dialog Dissmiss from callback $type');
            //         },
            //       ).show();
            //     },
            //   ),
            // ),

        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0, left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _showDebugInfo = !_showDebugInfo;
                });
              },
              child: Icon(
                  _showDebugInfo ? Icons.visibility_off : Icons.visibility),
            ),

            FloatingActionButton(
              onPressed: () {
                AnimatedButton(
                  text: 'Example Constilation',
                  color: Colors.amber,

                  pressEvent: () {
                    AwesomeDialog(
                      body: Container(
                          child: Image.asset('assets/images/constilation.jpeg')),
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: true,

                      btnOkOnPress: () {},
                    ).show();
                  },
                );
                if(_lon>=20 && _lon<=30 && _lat >= 40 && _lat <= 60 && _tilt >= -10 && _tilt<=10){
                  print('Welcomeeeeeeeeeeee');
                }
              },
              child: Icon(
                  _showDebugInfo ? Icons.find_in_page_outlined : Icons.find_in_page),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (!_useAsMap) {
                    _isHotspotVisible = false;
                  }
                  _useAsMap = !_useAsMap;
                });
              },
              child: Icon(_useAsMap ? Icons.info : Icons.map),
            ),
          ],
        ),
      ),
    );
  }

  List<Hotspot> getStars(BuildContext context, int ix) {
    List<Hotspot> allStars = [];
    print(BlocProvider.of<ConstilationCubit>(context).Constilations);

    int counter =
        BlocProvider.of<ConstilationCubit>(context).Constilations.length;

    if (ix < counter) {
      int starsLength = BlocProvider.of<ConstilationCubit>(context)
              .Constilations[ix]
              .allStars
              ?.length ??
          0;

      for (int i = 0; i < starsLength; i++) {
        var star = BlocProvider.of<ConstilationCubit>(context)
            .Constilations[ix]
            .allStars![i];

        if (star.brightnessPersent! < 0.2) {
          allStars.add(Hotspot(
            latitude: star.y!,
            longitude: star.x!,
            width: 60.0,
            height: 60.0,
            widget: hotspotButton(
              imageasd: Assets.stars2dLeast,
              index: i,
            ),
          ));
        } else if (star.brightnessPersent! < 0.4) {
          allStars.add(Hotspot(
            latitude: star.y!,
            longitude: star.x!,
            width: 60.0,
            height: 60.0,
            widget: hotspotButton(
              imageasd: Assets.stars2dLesser,
              index: i,
            ),
          ));
        } else if (star.brightnessPersent! < 0.6) {
          allStars.add(Hotspot(
            latitude: star.y!,
            longitude: star.x!,
            width: 60.0,
            height: 60.0,
            widget: hotspotButton(
              imageasd: Assets.stars2dKindpng1517300,
              index: i,
            ),
          ));
        } else if (star.brightnessPersent! < 0.8) {
          allStars.add(Hotspot(
            latitude: star.y!,
            longitude: star.x!,
            width: 60.0,
            height: 60.0,
            widget: hotspotButton(
              imageasd: Assets.stars2dS,
              index: i,
            ),
          ));
        } else {
          allStars.add(Hotspot(
            latitude: star.y!,
            longitude: star.x!,
            width: 60.0,
            height: 60.0,
            widget: hotspotButton(
              imageasd: Assets.stars2dSd,
              index: i,
            ),
          ));
        }
      }
    }


    for (int i = 0; i < 100; i++) {
      double randomx = random.nextDouble();
      if (randomx < 0.2) {
        allStars.add(Hotspot(
          latitude: (-1000 + random.nextInt(2000)).toDouble(),
          longitude: (-1000 + random.nextInt(2000)).toDouble(),
          width: 60.0,
          height: 60.0,
          widget: hotspotButton(
            imageasd: Assets.stars2dLeast,
            index: i,
          ),
        ));
      } else if (randomx < 0.4) {
        allStars.add(Hotspot(
          latitude: (-1000 + random.nextInt(2000)).toDouble(),
          longitude: (-1000 + random.nextInt(2000)).toDouble(),
          width: 60.0,
          height: 60.0,
          widget: hotspotButton(
            imageasd: Assets.stars2dLesser,
            index: i,
          ),
        ));
      } else if (randomx < 0.6) {
        allStars.add(Hotspot(
          latitude: (-1000 + random.nextInt(2000)).toDouble(),
          longitude:(-1000 + random.nextInt(2000)).toDouble(),
          width: 60.0,
          height: 60.0,
          widget: hotspotButton(
            imageasd: Assets.stars2dKindpng1517300,
            index: i,
          ),
        ));
      } else if (randomx < 0.8) {
        allStars.add(Hotspot(
          latitude: (2500 + random.nextInt(4000)).toDouble(),
          longitude: (-1000 + random.nextInt(2000)).toDouble(),
          width: 20.0,
          height: 20.0,
          widget: hotspotButton(
            imageasd: Assets.stars2dS,
            index: i,
          ),
        ));
      } else {
        allStars.add(
            Hotspot(
          latitude: (-1000 + random.nextInt(2000)).toDouble(),
          longitude: (-1000 + random.nextInt(2000)).toDouble(),
          width: 60.0,
          height: 60.0,
          widget: hotspotButton(
            imageasd: Assets.stars2dSd,
            index: i,
          ),
        ));



      }
      allStars.add(Hotspot(
        latitude: (-1000 + random.nextInt(2000)).toDouble(),
        longitude: (-1000 + random.nextInt(2000)).toDouble(),
        width: 60.0,
        height: 60.0,
        widget: hotspotButton(
          imageasd: Assets.stars2dLesser,
          index: i,
        ),
      ));
    }

    allStars.add(Hotspot(
      latitude: 500,
      longitude: 500,
      width: 60.0,
      height: 60.0,
      widget: hotspotButtons(
          imageasd: Assets.starsStar,
          large: true,
          index: 1021,
          selected: first,
          color: first ? Colors.green : Colors.white,

          ),
    ));
    allStars.add(Hotspot(
      latitude: 500,
      longitude: 500,
      width: 60.0,
      height: 60.0,
      widget: hotspotButtons(
          imageasd: Assets.starsDe,
          large: true,
          index: 1021,

          onPressed: () {
          sec = true; setState(() {

          });
      }),
    ));
    // allStars.add(Hotspot(
    //   latitude: 500,
    //   longitude: 500,
    //   width: 60.0,
    //   height: 60.0,
    //   widget: hotspotButton(
    //       imageasd: Assets.starsLayer2,
    //
    //       large: true,
    //       index: 1021,
    //       onPressed: (){
    //
    //       }
    //   ),
    // ));

    allStars.add(Hotspot(
      latitude: 480,
      longitude: 510,
      width: 60.0,
      height: 60.0,
      widget:
      hotspotButtons(
        large: true,
        imageasd: Assets.starsStar,
        index: 1021,
        selected: nums.contains(1),
        color: nums.contains(1) ? Colors.green : Colors.white,
        // onPressed: () {
        //   setState(() {
        //     nums.add(1);
        //   });
        // }
      ),
    ));
    allStars.add(Hotspot(
      latitude: 475,
      longitude: 510,
      width: 60.0,
      height: 60.0,
      widget: Column(
        children: [
          GestureDetector(
            onTap: (){
              nums.add(2);
              setState(() {

              });
            },
            child: Visibility(
                visible: !nums.contains(2),
                child: Image.asset(
                  Assets.starsStar,
                  width: 30,
                  height: 30,

                  fit: BoxFit.fill,
                )),
          ),
          GestureDetector(
            onTap: (){
              nums.remove(2);
              setState(() {

              });
            },
            child: Visibility(
                visible: nums.contains(2),
                child: Image.asset(
                  Assets.starsStar,
                  color: Colors.green,
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                )),
          ),
        ],
      )
    ));
    allStars.add(Hotspot(
      latitude: 465,
      longitude: 550,
      width: 60.0,
      height: 60.0,
      widget: hotspotButtons(
          large: true,
          selected: nums.contains(3),
          color: nums.contains(3) ? Colors.green : Colors.white,
          imageasd: Assets.starsStar,
          index: 1021,
          onPressed: () {
            setState(() {
              nums.contains(3);
            });
          }),
    ));
    allStars.add(Hotspot(
      latitude: 462,
      longitude: 485,
      width: 60.0,
      height: 60.0,
      widget: hotspotButtons(
          large: true,
          selected: nums.contains(4),
          color: nums.contains(4) ? Colors.green : Colors.white,
          imageasd: Assets.starsStar,
          index: 1021,
          onPressed: () {
            setState(() {
              nums.add(4);
            });
          }),
    ));

    return allStars;
  }
}
