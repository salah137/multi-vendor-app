import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_vendors_ecommerse_app/shared/model/ItemeModel.dart';
import '/shared/cubit/AppStates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/shared/model/UserMoel.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          InitialState(),
        );

  static var user;

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
        user = UserModel(
          name: username,
          userProfile:
              "https://hearhear.org/wp-content/uploads/2019/09/no-image-icon.png",
          products: [],
          email: email,
        );
        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set({
          "name": username,
          "userProfile":
              "https://hearhear.org/wp-content/uploads/2019/09/no-image-icon.png",
          "products": [],
          "email": email,
        });
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
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .get()
            .then(
          (value) {
            user = value.data();
          },
        );
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
    await FirebaseFirestore.instance.collection("users").get().then(
      (value) {
        for (int i = 0; i < value.docs.length; i++) {
          allUsers.add(value.docs[i]);
        }
      },
    );
    await FirebaseFirestore.instance.collection("itemes").get().then(
      (value) {
        for (int i = 0; i < value.docs.length; i++) {
          allItemes.add(value.docs[i]);
        }
      },
    );

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
