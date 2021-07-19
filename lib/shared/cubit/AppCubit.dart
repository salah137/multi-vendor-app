import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_vendors_ecommerse_app/screens/ChatsScreen.dart';
import 'package:multi_vendors_ecommerse_app/screens/MarketScreen.dart';
import 'package:multi_vendors_ecommerse_app/shared/model/ItemeModel.dart';
import 'package:multi_vendors_ecommerse_app/shared/sharedpref.dart';
import '/shared/cubit/AppStates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/shared/model/UserMoel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          InitialState(),
        );

  static Map<String, dynamic> user = {};

  static List allUsers = [];
  static List allItemes = [];

  Future signUp(email, password, username) async {
    emit(SignUpLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) async {
        print(value.user.email);
        print(value.user.uid);
        print(username);
        user = {
          "name": username,
          "userProfile":
              "https://hearhear.org/wp-content/uploads/2019/09/no-image-icon.png",
          "products": [],
          "email": email,
        };
        print(user);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set(user);
        await Helper.putData("user uid", value.user.uid).then((value) async {
          await Helper.putData("isStart", 1);
          emit(SignUpState());
        }).catchError(
      (error) {
        print(error.toString());
        emit(
          SignUpErrorState(),
        );
                Fluttertoast.showToast(
            msg: error.toString().substring(error.toString().indexOf("]")+1),
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            
            );
        print(error);
      });
      },
    );
  }

  Future signIn(email, password) async {
    emit(SigninLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .get()
            .then(
          (value) {
            user = value.data();
            print(user);
          },
        );
        await Helper.putData("user uid", value.user.uid).then((value) async {
          await Helper.putData("isStart", 1);
          emit(SigningState());
        });
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(
          SigninErrorState(),
        );
                Fluttertoast.showToast(
            msg: error.toString().substring(error.toString().indexOf("]")+1),
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            
            );
        print(error);
      },
    );
  }

  void getAllData() async {
    emit(GetingDataLoadingState());
    await FirebaseFirestore.instance.collection("users").get().then(
      (value) {
        allUsers = value.docs.toList();
        print(allUsers);
      },
    );
    await FirebaseFirestore.instance.collection("itemes").get().then(
      (value) {
        allItemes = value.docs.toList();
        print(allItemes);
      },
    );

    if (Helper.getDataString("user uid") != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(Helper.getDataString('user uid')!)
          .get()
          .then((value) {
        user = value.data();
      });
    }
    emit(GetAllDataState());
  }

  bool checkNames(name) {
    for (var i in allUsers) {
      if (name == i["name"]) {
        return false;
      }
    }
    return true;
  }

  bool checkEmail(email) {
    for (var i in allUsers) {
      if (email == i["email"]) {
        return false;
      }
    }
    return true;
  }

  List<Widget> screens = [
    MarketScreen(),
    ChatsScreen(),
  ];
  int index = 0;
  void changIndex(int i){
    index = i;
    emit(ChangeScreen());
  }
}
