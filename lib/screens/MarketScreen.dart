import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MarketScreen extends StatelessWidget {
  MarketScreen({Key? key}) : super(key: key);

  final String imageUrl =
      "https://images.ctfassets.net/hrltx12pl8hq/3MbF54EhWUhsXunc5Keueb/60774fbbff86e6bf6776f1e17a8016b4/04-nature_721703848.jpg?fit=fill&w=480&h=270";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
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
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}

