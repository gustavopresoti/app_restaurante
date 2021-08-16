import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();
      return Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              cartProduct.productData!.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cartProduct.productData!.title,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text('Tamanho: ${cartProduct.size}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text('R\$ ${cartProduct.productData!.price[cartProduct.productData!.sizes.indexOf(cartProduct.size)].toDouble().toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: cartProduct.quantity > 1
                        ? () {
                          CartModel.of(context).decProduct(cartProduct);
                        }
                        : null,
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          CartModel.of(context).incProduct(cartProduct);
                        },
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                      ),
                      TextButton(
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                        child: Text('Remover',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('products').doc(cartProduct.category)
            .collection('items').doc(cartProduct.pid).get(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            cartProduct.productData = ProductData.fromDocument(snapshot.data!);

            return _buildContent();
          }else {
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        },
      ),
    );
  }
}
