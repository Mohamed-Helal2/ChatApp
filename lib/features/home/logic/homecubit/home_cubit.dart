import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatty/features/home/data/model/home_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  TextEditingController searchcontroller = TextEditingController();
  List<HomeModel> testuser = [];
  List<HomeModel> Searchuser = [];
  String? searchvalue;
  StreamSubscription<QuerySnapshot>? _usersSubscription;
  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }

  void searchfunction() {
    Searchuser = testuser
        .where(
          (element) =>
              element.name.toLowerCase().contains(searchvalue!.toLowerCase()),
        )
        .toList();
    emit(searchstate(searchfu: searchvalue));
  }

  String? username;
  String? photourl;
  void getalluser1() {
    print("------ enter");
    // onlinechange(state);
    _usersSubscription = FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .listen((querySnapshot) {
      testuser.clear();
      for (var element in querySnapshot.docs) {
        // print("----------- ${element['name']}");
        if (element['email'] == FirebaseAuth.instance.currentUser!.email) {
          username = element['name'];
          photourl = element['photo'];
        }
        // } else
        //  {
        //   testuser.add(HomeModel.fromjson(element.data()));
        // }
        testuser.add(HomeModel.fromjson(element.data()));
      }
      print("------ bbbb");

      emit(getuserdatasucess(alluser: testuser));
    });
  }

  List peopleitailk = [];
  String documentidz = "";
  getpeople({
    required Map between00,
    required String last_msg,
    required String last_time,
    required String last_msg_from,
  }) async {
    peopleitailk.clear();
    bool found = false;
    List between11 = between00['emails'];
    QuerySnapshot querySnapshotq =
        await FirebaseFirestore.instance.collection("messages").get();
    for (var i = 0; i < querySnapshotq.docs.length; i++) {
      List doc_email = querySnapshotq.docs[i]["between"]['emails'];
      if (doc_email.every((element) => between11.contains(element))) {
        print("--------- isound ${doc_email}");

        documentidz = querySnapshotq.docs[i]['docid'];
        print("--------- isound $documentidz");
        found = true;
        emit(getpeaopleitaik());
        break;
      }
    }
    if (found == false) {
      await addmessagebetween2user(
          between: between00,
          last_time: last_time,
          last_msg_from: last_msg_from,
          LastMsg: last_msg);

      print("sss--------- nooooooooooo");
      if (!isClosed) emit(adduserstate());
      //  emit(adduserstate());
    }
  }

  Future addmessagebetween2user({
    required Map between,
    required String last_time,
    required String last_msg_from,
    required String LastMsg,
  }) async {
    print("loooooooooooooooooooooooool");
    CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection("messages");

    try {
      if (!isClosed) {
        DocumentReference newMessageRef = await messagesCollection.add({
          "between": between,
          "last_time": last_time,
          "last_msg_from": last_msg_from,
          "last_msg": LastMsg
        });
        String docId = newMessageRef.id;
        documentidz = docId;
        await newMessageRef.update({"docid": docId});
        emit(addstate());
      }
    } catch (e) {
      if (!isClosed) {
        emit(addstatefailure());
      }
      print("Error adding message: $e");
    }
  }

  deletefakemessage(String docid) async {
    CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection("messages");
    DocumentSnapshot messages = await FirebaseFirestore.instance
        .collection('messages')
        .doc(docid)
        .get();
    if (messages['last_time'] == "") {
      await messagesCollection.doc(docid).delete();
    }
    print("---${messages['between']}");
    // await messagesCollection.doc("yPZr1EJdXbvUCICslMub").delete();
    print("0000DNNN");
  }
}
