import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_vendors_ecommerse_app/shared/model/ItemeModel.dart';
import 'package:multi_vendors_ecommerse_app/shared/sharedpref.dart';
import '/shared/cubit/AppStates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/shared/model/UserMoel.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          InitialState(),
        );

  static Map<String,dynamic> user = {};

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
        Helper.putData("isStart", 1);
        Helper.putData("userUid", value.user.uid);
        emit(SignUpState());
      },
    ).catchError(
      (erro) {
        emit(
          SignUpErrorState(),
        );
        print(erro);
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
        Helper.putData("isStart", 1);
        Helper.putData("user uid", value.user.uid);
        emit(SigningState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(
          SigninErrorState(),
        );
      },
    );
  }

  void getAllData() async {
    emit(GetingDataLoadingState());
    print(Helper.getDataString("userUid")!);
    await FirebaseFirestore.instance.collection("users").get().then(
      (value) {
        allUsers = value.docs.toList();
        print(allUsers);
      },
    );
    await FirebaseFirestore.instance.collection("itemes").get().then(
      (value) {allItemes = value.docs.toList();
      print(allItemes);
      },
    );

    if(Helper.getDataString("userUid") != null) {
      await FirebaseFirestore.instance.collection("users").doc(Helper.getDataString('uerUid')!).get().then((value) {
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
}
