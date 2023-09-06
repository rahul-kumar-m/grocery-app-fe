import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_fe/route.dart';

import '../../data/user.dart';
import '../../home/ui/customappbar.dart';
import '../../logout Dialog.dart';
import '../../product tile/product_tile_widget.dart';
import '../bloc/cart_bloc.dart';

@RoutePage(name:"CartPageRoute")
class Cart extends StatelessWidget {
  final User user;
  const Cart({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:CartPage(user:this.user),
    );
  }
}
class CartPage extends StatefulWidget {
  final User user;
  const CartPage({super.key, required this.user});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int cost=0;
  int returnval=0;
  void store(int cost){
    returnval=cost;
    print(returnval);
  }


  void initState() {
    cartBloc.add(CartInitialEvent(user: widget.user));
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (context, state) => state is CartActionState,
        listener: (context, state) {
          if (state is CartUpdatedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Cart Updated"),
              duration: Duration(milliseconds: 300),));

          }
          else if (state is CostUpdateCostActionState ) {
            setState(() {
            });
          }

          else if (state is CartEmptyCartActionState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cart Is Empty"),duration:Duration(milliseconds: 500),));
          }

          else if(state is CartPlaceOrderActionState){
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cart Updated"),duration: Duration(milliseconds: 300),));
            context.router.popTop();
            context.router.push(Thankyoupage(user:widget.user));
          }
          else if(state is CartUserTokenExpiredActionState){
            context.router.popUntilRoot();
            context.router.push(LoginPageRoute());
          }
          else if (state is CartLogoutActionState){
            context.router.popUntilRoot();
            context.router.push(LoginPageRoute());
          }
        },
        buildWhen: (context, state) => state is! CartActionState,

        builder: (context, state) {

          switch (state.runtimeType) {
            case CartLoadedSuccessState:
              final finalSuccessState = state as CartLoadedSuccessState;
              for(int i=0;i<finalSuccessState.products.length;i++){
                cost+=(finalSuccessState.products[i].current_quantity*finalSuccessState.products[i].price);
              }
              return Scaffold(
                backgroundColor: Colors.teal[400],
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).primaryColor,
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                cartBloc.add(CartCheckUserTokenEvent(user: widget.user));
                                //context.router.pop(HomePageroute(user: widget.user));
                                context.router.push(HomePageroute(user: widget.user));
                                }, icon: Icon(Icons.arrow_back,color:Colors.white)),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Text(
                                  "Cart",
                                  style: GoogleFonts.dancingScript(

                                    fontWeight: FontWeight.bold,
                                    color:Colors.white,
                                    fontSize: 30,
                                  ),

                                ),
                              ),
                            ],
                          ),
                          IconButton(onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Do you want to Logout?'),
                                  content: Text('press cancel if you dont want to otherwise press yes'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Close the AlertDialog when the "OK" button is pressed
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Close the AlertDialog when the "OK" button is pressed
                                        Navigator.of(context).pop();
                                        cartBloc.add(CartLogoutEvent());
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }, icon: Icon(Icons.logout,color: Colors.white,))
                        ]
                    ),
                ),
                body: ListView.builder(

                    itemCount: finalSuccessState.products.length,
                    itemBuilder: (context, index) {
                      //homeBloc.add(HomeGetCartProductQuantityEvent(cart_id:finalSuccessState.cart.cart_id,product_id:finalSuccessState.products[index].id));
                      return ProductTileWidget(
                          productDataModel: finalSuccessState.products[index],
                          bloc: cartBloc,
                          user: widget.user);
                    }),
                bottomNavigationBar: NavigationBar(
             backgroundColor: Theme.of(context).primaryColor,
                  destinations: [
                  TextButton(onPressed: (){}, child:Column(
                    children: [
                      Text("Total Cost",style: TextStyle(fontSize: 16,color: Colors.white),),
                      Text("\u20B9 ${cartBloc.cost}",style: TextStyle(color: Colors.white,fontSize: 26),),
                    ],
                  )),
                  ElevatedButton(onPressed: (){
                    cartBloc.add(CartCheckUserTokenEvent(user: widget.user));
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 20,
                          icon: Icon(Icons.notification_add_sharp),
                          title: Text('Order Placed',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          content: Text('Dear ${widget.user.username},\n\n Confirm your Order has been Placed.\n',
                          style:TextStyle(
                            fontSize: 15,
                          ),
                          ),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                // Close the AlertDialog when the "OK" button is pressed
                                Navigator.of(context).pop();
                                cartBloc.add(CartPlaceOrderEvent(user: widget.user));
                              },
                              child: Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );

                    }, child:Text("Place Order") ),

                ],)
                  ,

              );
            case CartLoadedErrorState:
              return Scaffold(
                  body: Center(child: Text("ERROR"),)
              );
            default:
              return SizedBox();
          };
        }
    );
  }
}
