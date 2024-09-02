import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:chatty/features/chat_page/data/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  // CollectionReference messages0 =
  //     FirebaseFirestore.instance.collection("messages");
  TextEditingController messagecontroller = TextEditingController();
  bool messagetext = false;
  double sizemic = 40;
  double cont_hieigt = 50.h;
  double cont_width = 50.w;
  double cont_radius = 25;
  final recorder = FlutterSoundRecorder();
  List<MessageModel> messageList = [];
  bool isrecord = false;
  int dr = 0;
  List<AudioPlayer> audioplayers = [];
  List<int?> audiodurations = [];
  List<int?> timeprogrss = [];

  bool isplaying = false;
// images

  void changerecord(double cont_height0, double cont_width0, double sizemic0,
      double cont_radius0) {
    isrecord = !isrecord;
    cont_hieigt = cont_height0;
    cont_width = cont_width0;
    cont_radius = cont_radius0;
    sizemic = sizemic0;
    emit(changeiconstate());
  }

  Future<void> initrecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    emit(recordinitstate());
  }

  void subscribeToRecorderStream() {
    recorder.onProgress!.listen((data) {
      dr = data.duration.inMilliseconds;
      emit(RecordingInProgressstate(duration: dr));
    });
  }

  String? record_name;
  Future<void> startRecording() async {
    // initrecorder();
    print("------------- Start recorder");
    //  audioplayers.forEach((audioPlayer) => audioPlayer.pause());

    // for (int i = 0; i < playbackStates.length; i++) {
    //   // if(playbackStates[i]=PlayerState.)
    //   playbackStates[i] = PlayerState.paused;
    //   //emit(player1(player: playbackStates[i]));
    // }
    //initrecorder();
    record_name =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().second}${DateTime.now().microsecond}";
    try {
      await recorder.startRecorder(
        //codec: Codec.defaultCodec,
        toFile: 'audio${record_name}',
      );
      subscribeToRecorderStream();
    } catch (err) {}
    emit(startrecordstate());
  }

  Future<void> stopRecording({required String docid}) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('messages').doc(docid);
    CollectionReference msgListRef = docRef.collection('msglist');
    try {
      print("---------- sTOP Recording");
      final filepath = await recorder.stopRecorder();
      file = File(filepath!);
      print(">>> ---------- $filepath");
      final storageRef =
          FirebaseStorage.instance.ref("recordes/${record_name}");
      await storageRef.putFile(file!);
      print("---------- DNN");
      String url = await storageRef.getDownloadURL();
      print("-->>>> $url");
      await docRef.update({
        "test_msg": url,
        "last_msg_from": FirebaseAuth.instance.currentUser!.email,
        "last_time": DateTime.now()
      });
      Map<String, dynamic> messageData = {
        'addtime': DateTime.now(),
        'content': url,
        "type": "Record",
        "from_email": FirebaseAuth.instance.currentUser!.email,
        "audiotime": dr,
        "timeprogrss": 0,
        "audioduration": 0,
        "photocaption": null
      };
      await msgListRef.add(messageData);
      print("-----------Sending");
      // recordpath.add(filepath!);
      // playbackStates.add(PlayerState.paused);
      // audoplayers.add(AudioPlayer());
      // audiodurations.add(0);
      // timeprogrss.add(0);
      // audiotimes.add(dr);
      // recorddate.add("${DateTime.now()}");

      // emit(recordsucess(
      //   recorddata: recorddate,
      //   recordnames: recordnames,
      //   recordpath: recordpath,
      //   playbackStates: playbackStates,
      //   audoplayers: audoplayers,
      //   audiodurations: audiodurations,
      //   timeprogrss: timeprogrss,
      //   audiotimes: audiotimes,
      // ));
      dr = 0;
    } catch (err) {}
    emit(stoprecordstate());
  }

  int? indexplaying;
  // bool isplaying=false;
  Playaudio(url, index) async {
    indexplaying = index;
    isplaying = true;
    audioplayers[index].onDurationChanged.listen((Duration duration) {
      audiodurations[index] = duration.inMilliseconds;
      print("++++++++++++++++++ ${audiodurations[index]}");
      emit(audiodurationstate(audioduration0: audiodurations[index]!));
    });
    audioplayers[index].onPositionChanged.listen((Duration p) {
      timeprogrss[index] = p.inMilliseconds;
      emit(timeprogrssstate(timeprogrss0: timeprogrss[index]!));
      print("=+====================== ${timeprogrss[index]}");
    });
    audioplayers[index].onPlayerComplete.listen((_) {
      playbackStates[index] = PlayerState.completed;
      emit(completestate(player: playbackStates[index]));
    });
    await audioplayers[index].play(UrlSource(url));
    emit(Playrecordstate());
  }

  // Stop
  stopmuic(int index, String docid, String messageid) async {
    isplaying = false;
    await audioplayers[index].pause();
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('messages').doc(docid);

    DocumentReference msgListRef = docRef.collection('msglist').doc(messageid);
    // await msgListRef.update({
    //   "timeprogrss": timeprogrss[index],
    //   "audioduration": audiodurations[index],
    // });
  }

  List messagedocs = [];
  longplay(int index, String docid, String messageid) async {
    // DocumentReference docRef =
    //     FirebaseFirestore.instance.collection('messages').doc(docid);

    //     DocumentReference msgListRef = docRef.collection('msglist').doc(messageid);

    // messagedocs = msgListRef.docs;
    audioplayers.forEach((audioPlayer) => audioPlayer.pause());
    // if (isplaying == true) {
    //   playbackStates[indexplaying!] = PlayerState.paused;
    //   audioplayers[indexplaying!] = AudioPlayer().pause() as AudioPlayer;
    // }
    // isplaying ==true ?audioplayers[indexplaying!]=> AudioPlayer.
    for (int i = 0; i < playbackStates.length; i++) {
      if (i == index) {
      } else {
        playbackStates[i] = PlayerState.paused;

        ///  await stopmuic(index, docid, messageid);
        emit(player1(player: playbackStates[i]));
      }
    }
    if (playbackStates[index] == PlayerState.paused ||
        playbackStates[index] == PlayerState.stopped) {
      await Playaudio(messageList[index].content, index);

      playbackStates[index] = PlayerState.playing;
      emit(player2(player: playbackStates[index]));
    } else if (playbackStates[index] == PlayerState.playing) {
      await stopmuic(index, docid, messageid);
      playbackStates[index] = PlayerState.stopped;

      emit(player3(player: playbackStates[index]));
    } else if (playbackStates[index] == PlayerState.completed) {
      await Playaudio(messageList[index].content, index);

      playbackStates[index] = PlayerState.playing;
      emit(player4(player: playbackStates[index]));
    }
  }

  void seekto(int sec, int index) {
    Duration newposition = Duration(seconds: sec);
    audioplayers[index].seek(newposition);
  }

  stopaudio(index) async {
    //  isplaying = false;
    await audioplayers[index].pause();
    // isplaying = false;
    emit(Playrecordstate());
  }

  void chnageicon() {
    if (messagecontroller.text.isNotEmpty) {
      messagetext = true;
    }
    emit(changeiconstate());
  }

  Future addmessage({
    required String docid,
    // required TextEditingController messagecontroller,
  }) async {
    try {
      emit(sendmessageloading());
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('messages').doc(docid);
      CollectionReference msgListRef = docRef.collection('msglist');
      if (messagecontroller.text.isNotEmpty) {
        Map<String, dynamic> messageData = {
          'addtime': DateTime.now(),
          'content': messagecontroller.text,
          "type": "Text",
          "from_email": FirebaseAuth.instance.currentUser!.email,
          "audiotime": null,
          "timeprogrss": null,
          "audioduration": null,
          "photocaption": null
        };
        await msgListRef.add(messageData);
        messagecontroller.clear();
      }
      await docRef.update({
        "last_msg": messagecontroller.text,
        "last_msg_from": FirebaseAuth.instance.currentUser!.email,
        "last_time": DateTime.now()
      });

      if (!isClosed) emit(sendmessagesucess());
    } catch (e) {
      // Handle any errors that occurred during the process
      if (!isClosed) emit(sendmessagefailure());
      emit(sendmessagefailure());
      // You can add further error handling or logging here as needed
    }
    //emit(sendmessagestate());
  }

  final picker = ImagePicker();

//  XFile profilePic;
  //
  String? url;
  TextEditingController photocaption = TextEditingController();
//   showimages() async {
//     final List lastimages = [];
//     final ListpickedImage = await picker.pickMultiImage();
//     if (ListpickedImage.length > 0) {
//       for (var element in ListpickedImage) {
//         lastimages.add(element.path);
//         // file = File(element.path);
//         //     final storageRef =
//         //         FirebaseStorage.instance.ref("message photo/${element.name}");
//         //     await storageRef.putFile(file!);
//         //       url = await storageRef.getDownloadURL();
//       }
//       lastimages1 = lastimages;
//       print(">>>>>>>> -- ${lastimages1.length}");
//       emit(showimagesstatesucess(images: lastimages1));
//       // lastimages1.clear();
//     }
// //    lastimages.clear();
//     emit(showimagesstatefailure());
//   }
// file = File(messagepetho[0]);
  List lastimages1 = [];
  List imagesnames = [];

  Future<void> showimages() async {
    try {
      final List<XFile>? ListpickedImage = await picker.pickMultiImage();
      if (ListpickedImage != null && ListpickedImage.isNotEmpty) {
        lastimages1 = ListpickedImage.map((e) => e.path).toList();
        imagesnames = ListpickedImage.map((e) => e.name).toList();

        emit(showimagesstatesucess(
            images: lastimages1, imagenames: imagesnames));
      } else {
        emit(showimagesstatefailure());
      }
    } catch (e) {
      emit(showimagesstatefailure());
    }
  }

  final PageController pageController = PageController();

  int photonumber = 0;
  changephotonumer({required int index0}) {
    pageController.jumpToPage(index0);
    photonumber = index0;
    emit(changephotonumberstate());
  }

  changephotonumer2({required int index2}) {
    // pageController.jumpToPage(index0);
    photonumber = index2;
    print("/////////////// ");
    emit(changephotonumberstate2());
  }

  File? file;
  // Future<void> sendimages2(
  //     {required String docid, required List messagepetho}) async {
  //   print("===  ---->>> ${messagepetho.length}");
  //   DocumentReference docRef =
  //       FirebaseFirestore.instance.collection('messages').doc(docid);
  //   CollectionReference msgListRef = docRef.collection('msglist');
  //   try {
  //     if (messagepetho.isNotEmpty) {
  //       file = File(messagepetho[0]);
  //       final storageRef =
  //           FirebaseStorage.instance.ref("message photo/testphoto2");
  //       await storageRef.putFile(file!);
  //       url = await storageRef.getDownloadURL();
  //       print("---------------11 ");
  //       await docRef.update({
  //         "test_msg": url,
  //         "last_msg_from": FirebaseAuth.instance.currentUser!.email,
  //         "last_time": DateTime.now()
  //       });
  //       print("---------------222 ");
  //       Map<String, dynamic> messageData = {
  //         'addtime': DateTime.now(),
  //         'content': url,
  //         "type": "Photo",
  //         "from_email": FirebaseAuth.instance.currentUser!.email,
  //         "audiotime": null,
  //         "timeprogrss": null,
  //         "audioduration": null,
  //       };
  //       print("---------------331 ");

  //       await msgListRef.add(messageData);
  //       emit(ImageSendSucess());
  //       if (!isClosed) {
  //         emit(ImageSendFailure());
  //       }
  //     } else {
  //       if (!isClosed) {
  //         emit(ImageSendFailure());
  //       }
  //     }
  //   } catch (e) {
  //     if (!isClosed) {
  //       emit(ImageSendFailure());
  //     }
  //   }
  // }

  Future<void> sendimages(
      {required String docid,
      required List messagepetho,
      required List imagenemo}) async {
    print("===  ---->>> ${messagepetho.length}");
    final Listurls = [];
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('messages').doc(docid);
    CollectionReference msgListRef = docRef.collection('msglist');
    //  try {
    if (messagepetho.isNotEmpty) {
      // file = File(messagepetho[0]);
      // for (var i = 0; i < count; i++) {}
      for (int i = 0; i < messagepetho.length; i++) {
        final storageRef = FirebaseStorage.instance
            .ref("message photo/${imagenemo[i]}${DateTime.now()}");
        file = File(messagepetho[i]);
        await storageRef.putFile(file!);
        url = await storageRef.getDownloadURL();
        Listurls.add(url);
        print("--------------------- ${Listurls.length}");
      }

      print("---------------11 ");
      await docRef.update({
        "last_msg": "Photo",
        "last_msg_from": FirebaseAuth.instance.currentUser!.email,
        "last_time": DateTime.now()
      });
      print("---------------222 ");
      Map<String, dynamic> messageData = {
        'addtime': DateTime.now(),
        'content': Listurls,
        "type": "Photo",
        "from_email": FirebaseAuth.instance.currentUser!.email,
        "audiotime": null,
        "timeprogrss": null,
        "audioduration": null,
        "photocaption": photocaption.text,
      };
      print("---------------331 ");

      await msgListRef.add(messageData);
      emit(ImageSendSucess());
    } else {
      emit(ImageSendFailure());
    }
    // }
    // catch (e) {
    //   // emit(ImageSendFailure());
    // }
  }

  //Map<int, AudioPlayer> audioplayers = {};
  List<PlayerState> playbackStates = [];
  GetMessage({required String docid}) async {
    // CollectionReference docRef =
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(docid)
        .collection('msglist')
        .orderBy('addtime', descending: true)
        .snapshots()
        .listen((event) {
      messageList.clear();
      audioplayers.clear();
      timeprogrss.clear();
      audiodurations.clear();
      playbackStates.clear();
      messagedocs.clear();
      // int n = 0;
      for (var element in event.docs) {
        // print(">>------------------ ${element.id}");
        messageList.add(MessageModel.fromjson(element));
        audioplayers.add(AudioPlayer());
        playbackStates.add(PlayerState.paused);
        timeprogrss.add(element['timeprogrss']);
        audiodurations.add(element['audioduration']);
        messagedocs.add(element.id);
      }

      // print("------------------ ${audioplayers.length}");
      // print("------------------ ${timeprogrss}");
      // print("------------------ ${audiodurations}");
      // print("------------------ ${audioplayers}");
      emit(getmessagestate(messages: messageList));
    });
  }
}
