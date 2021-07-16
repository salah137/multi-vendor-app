class UserModel {
  late  String name;
  late String userProfile;
  late  List products;
  late String email;

  UserModel(
      {required this.name, required this.userProfile, required this.products, required email});

  UserModel.fromJson(model) {
    this.name = model['name'];
    this.userProfile = model['userProfile'];
    this.products = model['products'];
    this.email = model['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "userProfile": this.userProfile,
      "products": this.products,
      "email": this.email,
    };
  }
}
