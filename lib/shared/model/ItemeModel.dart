class Item {
  late int buyers;
  late int id;
  late String poster;
  late double price;
  late double rating;
  late String title;
  late List images;
  Item(
      {required this.buyers,
      required this.id,
      required this.rating,
      required this.poster,
      required this.price,
      required this.title,
      required this.images});

  Item.fromMap(model) {
    this.buyers = model["buyers"];
    this.id = model["id"];
    this.rating = model["rating"];
    this.price = model["price"];
    this.title = model["title"];
    this.poster = model["poster"];
    this.images = model["images"];
  }

  Map toMap() {
    return {
      "buyers": this.buyers,
      "id": this.id,
      "rating": this.rating,
      "poster": this.poster,
      "title": this.title,
      "price": this.price,
      "images": this.images,
    };
  }
}
