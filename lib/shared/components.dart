import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget listBuilder(list) => Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, i) => itemeBuilder(list[i]),
        itemCount: 10,
        scrollDirection: Axis.horizontal,
      ),
    );

Widget itemeBuilder(iteme) => Container(
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
                child: Image.network(
                  iteme["image"],
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "${iteme['title']}",
                  style: TextStyle(fontSize: 40),
                ),
                Spacer(),
                Text(
                  "${iteme["price"]} \$",
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
          ),
          SmoothStarRating(
            isReadOnly: true,
            rating: iteme["rating"],
          )
        ],
      ),
    );
