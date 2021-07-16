import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendors_ecommerse_app/shared/components.dart';
import 'package:multi_vendors_ecommerse_app/shared/cubit/AppCubit.dart';
import 'package:multi_vendors_ecommerse_app/shared/cubit/AppStates.dart';

class MarketScreen extends StatelessWidget {
  MarketScreen({Key? key}) : super(key: key);

  final String imageUrl =
      "https://images.ctfassets.net/hrltx12pl8hq/3MbF54EhWUhsXunc5Keueb/60774fbbff86e6bf6776f1e17a8016b4/04-nature_721703848.jpg?fit=fill&w=480&h=270";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (ctx, state) {
        AppCubit cubit = BlocProvider.of(ctx);
        return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(AppCubit.user["userProfile"]),
          ),
        ),
        actions: [
          CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
                color: Colors.indigo,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Text("tech", style: TextStyle(fontSize: 40),),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("show all"),
                ),
              ],
            ),
            listBuilder(AppCubit.allItemes.where((element) => element["category"] == "tech").toList()),
            SizedBox(height: 30,),    
            Row(
              children: [
                Text("cloths", style: TextStyle(fontSize: 40),),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("show all"),
                ),
              ],
            ),
            listBuilder(AppCubit.allItemes.where((element) => element["category"] == "cloths").toList()),          
            SizedBox(height: 30,),    
            Row(
              children: [
                Text("freelancing", style: TextStyle(fontSize: 40),),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("show all"),
                ),
              ],
            ),
            listBuilder(AppCubit.allItemes.where((element)=> element["category"] == "freelancing").toList()),
            SizedBox(height: 30,),
            Row(
              children: [
                Text('fachion', style: TextStyle(fontSize: 40),),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("show all"),
                ),
              ],
            ),    
            listBuilder(AppCubit.allItemes.where((element) => element['category'] == "fachion").toList())

          ],
        ),
      ),
    );
      },
      listener: (ctx, state){},
    );
  }
}

