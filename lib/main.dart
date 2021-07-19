import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendors_ecommerse_app/screens/MarketScreen.dart';
import 'package:multi_vendors_ecommerse_app/shared/cubit/AppStates.dart';
import 'package:multi_vendors_ecommerse_app/shared/sharedpref.dart';
import '/layouts/HomeLayout.dart';
import '/screens/Sign Up and Sin In/LoginScreen.dart';
import '/screens/Sign Up and Sin In/RegisterScreen.dart';
import '/shared/cubit/AppCubit.dart';
import 'observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await Helper.init();
  Widget startScreen =
      Helper.getDataInt("isStart") == null ? RegisterScreen() : HomePage();
  runApp(MyApp(
    startScreen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp({Key? key, required this.startScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AppCubit()..getAllData(),
      child: BlocConsumer<AppCubit, AppState>(
        builder: (ctx, state) {
          AppCubit cubit = BlocProvider.of(ctx);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  elevation: 0,
                ),
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.indigo,
                textTheme: TextTheme(
                    bodyText1: TextStyle(fontFamily: "Teko Bold"),
                    bodyText2: TextStyle(fontFamily: "Teko Light"))),
            home: state is GetingDataLoadingState
                ? Scaffold(body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(padding: EdgeInsets.all(20), child: Image.asset("./assets/images/shopping-1.png"),),
                    CircularProgressIndicator(),
                  ],
                ))
                : startScreen,
          );
        },
        listener: (ctx, state) {},
      ),
    );
  }
}
