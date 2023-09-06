import 'package:grocery_app_fe/data/getQuantity.dart';

class ProductDataModel{
  final int id;
  final String name;
  final String type;
  final int price;
  final int quantity;
  final String imageUrl;
  int current_quantity=0;


  ProductDataModel(
      {
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
  Future<void> updateQtyCurrent(cart_id) async {
    this.current_quantity=await getQuantity(cart_id, this.id);
  }

}