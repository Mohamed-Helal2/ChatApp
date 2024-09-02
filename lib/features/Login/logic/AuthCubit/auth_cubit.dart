import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  bool isobscure = true;
  bool confirmisobscure = true;
  XFile? profilePic;
  File? file;
  String? url;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  isisobscurechabge() {
    isobscure = !isobscure;
    emit(passwordstate(obescure: isobscure));
  }

  confirmpasswordobescure() {
    confirmisobscure = !confirmisobscure;
    emit(passwordstate(obescure: isobscure));
  }

  uloadimage() async {
    file = File(profilePic!.path);
    var imagename = basename(profilePic!.path);
    final storageRef =
        FirebaseStorage.instance.ref("users profile photo/$imagename");
    await storageRef.putFile(file!);
    url = await storageRef.getDownloadURL();

    emit(uploadphotoSucess());
  }

  uploadprofilepicture(XFile Image) {
    profilePic = Image;
    emit(uploadprofilestate());
  }
  // login

  Future<void> LogIn() async {
    emit(loginloading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      emit(loginsucess());
    } on Exception catch (e) {
      emit(loginfailure(error_message: e.toString()));
    }
  }

  void passwordbotsame() {
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      emit(passwordnotsamestate());
    } else {
      createEmail();
      makeuser();
    }
  }

  // Sign up
  void createEmail() async {
    emit(SignUpLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      emit(SignUpSucess());
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFaulure(error_message: 'Make Password Stronger'));
      } else if (e.code == "email-already-in-use") {
        emit(SignUpFaulure(error_message: 'Email Is Exist '));
      }
    }
  }

  void makeuser() async {
    if (profilePic != null) {
      await uloadimage();
    }
    await users.add({
      'name': namecontroller.text,
      'email': emailcontroller.text,
      'status': null,
      'photo': url
    });
    emit(adduserSucess());
  }
}
