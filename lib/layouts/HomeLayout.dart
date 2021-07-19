import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/cubit/AppCubit.dart';
import '/shared/cubit/AppStates.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (ctx, state) {
        AppCubit cubit = BlocProvider.of(ctx);
        return Scaffold(
          body: cubit.screens[cubit.index],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home' ),
              BottomNavigationBarItem(icon: Icon(Icons.business), label: "chats")
            ],
            currentIndex: cubit.index,
            onTap: cubit.changIndex,

          ),
        );
      },
      listener: (ctx, state) {},
    );
  }
}
 