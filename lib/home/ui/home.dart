import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_fe/data/cart_id.dart';
import 'package:grocery_app_fe/data/getQuantity.dart';
import 'package:grocery_app_fe/home/ui/customappbar.dart';

import 'package:grocery_app_fe/product%20tile/product_tile_widget.dart';
import 'package:grocery_app_fe/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_fe/route.dart';

import '../../data/user.dart';
import '../../logout Dialog.dart';
import 'custom_filter_button.dart';

@RoutePage(name:"homePageroute" )
class Homepage extends StatelessWidget {
  final User user;
  const Homepage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Home(user: user)),
    );
  }
}


class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState(this.user);
}

class _HomeState extends State<Home>{

  final User user;
  int _currentIndex = 0;
  _HomeState(this.user);
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent("asc",user:widget.user));
    super.initState();
  }
  final HomeBloc homeBloc=HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc:homeBloc,
        listenWhen:(context,state)=> state is HomeActionState,
        listener: (context, state) {
          if(state is HomeAddToCartActionState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Product Added"),duration: Duration(milliseconds: 400),));
          }
          else if (state is HomeCartUpdatedActionState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cart Updated"),duration: Duration(milliseconds: 400),));
          }
          else if(state is HomeNavigationToCartActionState){
            //context.router.popUntilRoot();
            context.router.popTop();
            context.router.push(CartPageRoute(user:user));
          }
          else if(state is HomeNavigationToMenuActionState){
            context.router.popTop();
            context.router.push(MenuRoutePage(user: user));
          }
          else if(state is HomeUserTokenExpiredActionState){
            context.router.popUntilRoot();
            context.router.push(LoginPageRoute());
          }
          else if(state is HomeLogoutActionState){
            context.router.popUntilRoot();
            context.router.push(LoginPageRoute());
          }
        },
        buildWhen: (context,state)=> state is !HomeActionState,

        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Scaffold(
                  backgroundColor: Colors.teal,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).primaryColor,
                    title:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: TextButton(
                                  onPressed: (){
                                    showMenu(
                                        context: context,
                                        position: RelativeRect.fromLTRB(0, 80,0,0 ),
                                        items: [PopupMenuItem<String>(
                                          value: 'ascending',
                                          child: Text('Current User: ${user.username}'),
                                         // onTap: (){bloc.add(HomeInitialEvent("asc", user: user));},
                                        ),]
                                    );
                                  },
                                  child: Text(
                                  "Rahul's Grocery App",
                                  style: GoogleFonts.dancingScript(

                                    fontWeight: FontWeight.bold,
                                    color:Colors.white,
                                    fontSize: 30,
                                  ),

                                ),
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                    actions: [
                      CustomFilterButton(bloc: homeBloc,user: widget.user),
                      IconButton(onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Do you want to Logout?'),
                              content: Text('Press cancel if you dont want to otherwise Press yes'),
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
                                    homeBloc.add(HomeLogoutEvent());
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      }, icon: Icon(Icons.logout,color: Colors.white,)),


                    ],
                  ),
                  body: Center(child: CircularProgressIndicator(color: Colors.white,))
              );
            case HomeLoadedSuccessState:
              final finalSuccessState=state as HomeLoadedSuccessState;
              return Scaffold(
                backgroundColor: Colors.teal,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  title:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Row(
                    children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: TextButton(
                            onPressed: (){
                              showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(0, 80,0,0 ),
                                  items: [PopupMenuItem<String>(
                                    value: 'ascending',
                                    child: Text('CurrentUser: ${user.username}'),
                                    // onTap: (){bloc.add(HomeInitialEvent("asc", user: user));},
                                  ),]
                              );
                            },
                            child: Text(
                              "Rahul's Grocery App",
                              style: GoogleFonts.dancingScript(

                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                                fontSize: 30,
                              ),

                            ),
                          ),
                        ),
                    ],
                    ),
                    ]
                  ),
                  actions: [
                    CustomFilterButton(bloc: homeBloc,user: widget.user),
                    IconButton(onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Do you want to Logout?'),
                            content: Text('Press cancel if you dont want to otherwise Press yes'),
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
                                  homeBloc.add(HomeLogoutEvent());
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    }, icon: Icon(Icons.logout,color: Colors.white,)),


                  ],
              ),
                body: ListView.builder(
                    itemCount: finalSuccessState.products.length,
                    itemBuilder: (context,index){
                      //homeBloc.add(HomeGetCartProductQuantityEvent(cart_id:finalSuccessState.cart.cart_id,product_id:finalSuccessState.products[index].id));
                      return ProductTileWidget(productDataModel: finalSuccessState.products[index],bloc: homeBloc , user: this.user) ;
                    }),
                bottomNavigationBar: BottomNavigationBar(

                  items: [
                    BottomNavigationBarItem(icon:IconButton(onPressed: (){homeBloc.add(HomeCheckUserTokenEvent(user:user));homeBloc.add(HomeNavigateToMenuEvent());},icon:Icon(Icons.menu)),label: "Your Orders", ),
                    BottomNavigationBarItem(icon: IconButton(onPressed: (){homeBloc.add(HomeCheckUserTokenEvent(user:user));homeBloc.add(HomeNavigateToCartEvent());},icon:Icon(Icons.shopping_cart,)),label:"Cart",),
                  ],
                ),
              );
            case HomeLoadedErrorState:
              return Scaffold(
                  body:Center(child: Text("ERROR"),)
              );
            default:
              return SizedBox();
          };
        }
    );

  }

}
