import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  late String id;
  late String category;
  late String title;
  late String description;
  late List price;
  late List images;
  late List sizes;

  ProductData.fromDocument(DocumentSnapshot? snapshot) {
    id = snapshot!.id;
    title = snapshot.get('title');
    description = snapshot.get('description');
    price = snapshot.get('price');
    images = snapshot.get('images');
    sizes = snapshot.get('sizes');
  }

  Map<String, dynamic> toResumeMap(String size) {
    return {
      'title': title,
      'description': description,
      'price': price[sizes.indexOf(size)],
    };
  }
}