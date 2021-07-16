import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendors_ecommerse_app/shared/cubit/AppStates.dart';
import '/layouts/HomeLayout.dart';
import '/screens/Sign Up and Sin In/LoginScreen.dart';
import '/screens/Sign Up and Sin In/RegisterScreen.dart';
import '/shared/cubit/AppCubit.dart';
import 'observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AppCubit()..getAllData(),
      child: BlocConsumer<AppCubit,AppState>(
        builder: (ctx,state){
          AppCubit cubit = BlocProvider.of(ctx);
          return  MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                  bodyText1: TextStyle(fontFamily: "Teko Bold"),
                  bodyText2: TextStyle(fontFamily: "Teko Light"))),
          home: state is GetingDataLoadingState ? Scaffold(body: Center(child: CircularProgressIndicator())):RegisterScreen(),
        );
        },
        listener: (ctx,state){},
      ),
    );
  }
}
