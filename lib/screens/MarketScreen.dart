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
          Container(
            height: 300,
            child: ListView.builder(
              itemBuilder: (ctx, i) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.all(20),
                width: 200,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: ClipRRect(
                          child: Image.network(imageUrl, fit: BoxFit.cover,),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "title",
                            style: TextStyle(fontSize: 40),
                          ),
                          Spacer(),
                          Text(
                            "145 \$",
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                    SmoothStarRating(
                      isReadOnly: true,

                    )
                  ],
                ),
              ),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
