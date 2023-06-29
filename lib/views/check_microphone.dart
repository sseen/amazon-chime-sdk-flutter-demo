import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';

class CheckMicrophoneView extends StatefulWidget {
  @override
  _CheckMicrophoneViewState createState() => _CheckMicrophoneViewState();
}

class _CheckMicrophoneViewState extends State<CheckMicrophoneView> {

  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  double _noise = 0.0;


  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter(onError);
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    if (!mounted) {
      stop();
      return;
    }
    // this.setState(() {
    //   // if (!this._isRecording) {
    //   //   this._isRecording = true;
    //   // }
    // });
    print(noiseReading.toString());
    setState(() {
      _noise = noiseReading.meanDecibel;
    });
  }
  void onError(Object error) {
    print(error.toString());
    //_isRecording = false;
  }
  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }
  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription!.cancel();
        _noiseSubscription = null;
      }
      //this.setState(() {
        //this._isRecording = false;
      //});
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    start();

    return Container(
      // width: double.infinity,
      // height: 15.0,
      // color: Colors.transparent,
      // child: // Customized progress indicator with rounded corners and height
      // ClipRRect(
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      //   child: SizedBox(
      //     height: 20,
      //     child: LinearProgressIndicator(
      //       minHeight: 20,
      //       value: _noise / 100,
      //       backgroundColor: Color(0xffecf0f1),
      //       color: Color(0xff18bc9c)),
      //     ),
      //   ),
      );
  }
}