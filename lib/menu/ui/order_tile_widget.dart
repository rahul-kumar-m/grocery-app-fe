import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_fe/data/getQuantity.dart';
import 'package:grocery_app_fe/home/bloc/home_bloc.dart';
import 'package:grocery_app_fe/menu/bloc/menu_bloc.dart';

import '../../data/order.dart';
import '../../data/user.dart';
//import 'package:grocery_app_fe/cart/bloc/cart_bloc.dart';




class OrderTileWidget extends StatefulWidget {
  final Orders order;
  final Bloc bloc;
  final int OrderNumber;
  final User user;

  const OrderTileWidget({super.key, required this.order, required this.bloc, required this.OrderNumber, required this.user});



  @override
  State<OrderTileWidget> createState() => _CartProductTileWidgetState();
}

class _CartProductTileWidgetState extends State<OrderTileWidget> {
  double factor=0.15;
  @override
  Widget build(BuildContext context) {

    return(widget.order.no_of_products!='0')? Container(

        margin:EdgeInsets.fromLTRB(10, 10, 10, 5),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width*0.8,
        height:MediaQuery.of(context).size.height*factor ,
        decoration: BoxDecoration(
          border:Border.all(color:Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.9),

        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Number: ${widget.OrderNumber}",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text("No. Of Products: ${widget.order.no_of_products}",

            ),
            //Text("Cart ID: ${widget.order.cart_id}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" Total Cost: \u20B9${widget.order.price}",
                    style:TextStyle(fontWeight: FontWeight.bold,)
                ),
                FilledButton(onPressed: (){widget.bloc.add(MenuOrderViewEvent(cart_id: widget.order.cart_id, user: widget.user));}, child: Text("View Order"))
              ],
            )
          ],
        )
    ):SizedBox(width: 0,);

  }
}
