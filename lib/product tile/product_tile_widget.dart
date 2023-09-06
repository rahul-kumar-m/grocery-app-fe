import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_fe/data/getQuantity.dart';
import 'package:grocery_app_fe/home/bloc/home_bloc.dart';
import 'package:grocery_app_fe/menu/bloc/menu_bloc.dart';
//import 'package:grocery_app_fe/cart/bloc/cart_bloc.dart';

import '../cart/bloc/cart_bloc.dart';
import '../data/product_data_model.dart';
import '../data/user.dart';


class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final Bloc bloc;

  final User user;
  const ProductTileWidget({super.key, required this.productDataModel, required this.bloc,required this.user});

  @override
  State<ProductTileWidget> createState() => _CartProductTileWidgetState(this.productDataModel.current_quantity,this.user);
}

class _CartProductTileWidgetState extends State<ProductTileWidget> {
  bool wishlisted=false;

  int qty;
  final User user;
  _CartProductTileWidgetState(this.qty,this.user);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.bloc.runtimeType==CartBloc && qty!=0){
      widget.bloc.add(CartUpdateCost(update: qty*widget.productDataModel.price));
    }
  }
  @override
  Widget build(BuildContext context) {

    return (widget.bloc.runtimeType==HomeBloc || (widget.bloc.runtimeType==CartBloc && qty!=0) || (widget.bloc.runtimeType==MenuBloc && qty!=0))?Container(

        margin:EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          border:Border.all(color:Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.9),

        ),

        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height:100,

              width: 100,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  image:DecorationImage(
                    fit:BoxFit.cover,

                    image: AssetImage(widget.productDataModel.imageUrl),
                  )
              ),

            ),

            SizedBox(width: 10,),
            Container(
              width: MediaQuery.of(context).size.width*0.6,
                child:Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.productDataModel.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      Text(widget.productDataModel.type),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("\u20B9 ${widget.productDataModel.price}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          (widget.bloc.runtimeType!=MenuBloc)?Row(

                              children:<Widget>[
                                qty==0?FilledButton(
                                  onPressed: (){
                                    widget.bloc.add(HomeCheckUserTokenEvent(user: user));
                                    widget.bloc.add(HomeAddToCartEvent(product_id:widget.productDataModel.id,user:user));
                                    qty=1;
                                    setState(() {
                                    });
                                  },

                                  child: Text("ADD"),


                                ):
                                Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      qty-=1;
                                      if(widget.bloc.runtimeType==HomeBloc) {
                                        widget.bloc.add(HomeCheckUserTokenEvent(user: user));
                                        widget.bloc.add(
                                            HomeUpdateProductInCartEvent(
                                                user: widget.user,
                                                quantity: qty,
                                                product_id: widget
                                                    .productDataModel.id));
                                      }
                                      else{
                                        widget.bloc.add(CartUpdateCost(update: -1*widget.productDataModel.price));
                                        widget.bloc.add(CartCheckUserTokenEvent(user: user));
                                        widget.bloc.add(

                                            CartUpdateProductInCartEvent(
                                                user: widget.user,
                                                quantity: qty,
                                                product_id: widget
                                                    .productDataModel.id));
                                      }
                                      setState(() {

                                      });
                                    },
                                        icon: Icon(Icons.remove_circle_outline)),
                                    Text("${qty}"),
                                    IconButton(onPressed: (){
                                      if(qty<widget.productDataModel.quantity)
                                        {
                                          qty+=1;
                                          if(widget.bloc.runtimeType==HomeBloc) {
                                            widget.bloc.add(HomeCheckUserTokenEvent(user: user));
                                            widget.bloc.add(
                                                HomeUpdateProductInCartEvent(
                                                    user: widget.user,
                                                    quantity: qty,
                                                    product_id: widget
                                                        .productDataModel.id));
                                          }
                                          else{
                                            widget.bloc.add(CartUpdateCost(update: widget.productDataModel.price));
                                            widget.bloc.add(CartCheckUserTokenEvent(user: user));
                                            widget.bloc.add(
                                                CartUpdateProductInCartEvent(
                                                    user: widget.user,
                                                    quantity: qty,
                                                    product_id: widget
                                                        .productDataModel.id));
                                          }
                                        }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Maximum Quantity Reached"),duration: Duration(milliseconds: 500),));
                                      }
                                      setState(() {

                                      });
                                    },
                                        icon: Icon(Icons.add_circle_outline))
                                  ],
                                )

                              ]
                          ):Text("${widget.productDataModel.current_quantity}"),
                        ],
                      )
                    ]
                )
            )


          ],
        )

    ):SizedBox(height: 0,);

  }
}
