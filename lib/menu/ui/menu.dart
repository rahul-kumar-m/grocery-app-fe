import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_fe/home/ui/customappbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_fe/menu/bloc/menu_bloc.dart';
import 'package:grocery_app_fe/menu/ui/widgetModel/model.dart';
import 'package:grocery_app_fe/route.dart';
import '../../data/user.dart';
import '../../product tile/product_tile_widget.dart';
import 'order_tile_widget.dart';

@RoutePage(name:"MenuRoutePage")
class MenuPage extends StatefulWidget {
  final User user;
  const MenuPage({super.key, required this.user});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final MenuBloc menuBloc=new MenuBloc();
 // final User user;

 // _MenuPageState({required this.user});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuBloc.add(MenuInitialEvent(user:widget.user));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      bloc:menuBloc,
      listenWhen:(previous,current) => current is MenuActionState,

      listener: (context, state) {
        if(state is MenuLogoutActionState){
          context.router.popUntilRoot();
          context.router.push(LoginPageRoute());
        }

      },
      buildWhen: (previous,current) => current is !MenuActionState,
      builder: (context, state) {
        switch (state.runtimeType){
          case MenuLoadedSuccessState:
            final finalSuccessState=state as MenuLoadedSuccessState;
            //print(user.JWT);
            return   Scaffold(
              backgroundColor: Colors.teal,
              appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Row(
        children: [

        Row(
          children: [
            IconButton(onPressed: (){
              context.router.popTop();
              //context.router.popUntil((HomePageroute) => false);
              context.router.push(HomePageroute(user: widget.user));
            }, icon: Icon(Icons.arrow_back,color:Colors.white)),

            Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
            "Your Orders",
            style: GoogleFonts.dancingScript(

            fontWeight: FontWeight.bold,
            color:Colors.white,
            fontSize: 30,
            ),

            ),
            ),
          ],
        ),
        ],
        ),
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
        menuBloc.add(MenuLogoutEvent());
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
              body:ListView.builder(
                  itemCount: finalSuccessState.order.length,
                  itemBuilder: (context,index){
                    //homeBloc.add(HomeGetCartProductQuantityEvent(cart_id:finalSuccessState.cart.cart_id,product_id:finalSuccessState.products[index].id));
                    return OrderTileWidget(order: finalSuccessState.order[index],bloc: menuBloc , OrderNumber: index+1,user: widget.user,) ;
                  }));
          case MenuOrderViewState:
            final finalSuccessState= state as MenuOrderViewState;
            return Scaffold(
                backgroundColor: Colors.teal,
              appBar:AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
              Row(
              children: [

              Row(
                children: [
                  IconButton(onPressed: (){
                    context.router.popTop();
                    context.router.push(MenuRoutePage(user: widget.user));
                  }, icon: Icon(Icons.arrow_back,color:Colors.white)),
                  Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(
                  "Your Orders",
                  style: GoogleFonts.dancingScript(

                  fontWeight: FontWeight.bold,
                  color:Colors.white,
                  fontSize: 30,
                  ),

                  ),
                  ),
                ],
              ),
              ],
              ),
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
              menuBloc.add(MenuLogoutEvent());
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
              body:ListView.builder(
            itemCount: finalSuccessState.products.length,
            itemBuilder: (context, index) {
            //homeBloc.add(HomeGetCartProductQuantityEvent(cart_id:finalSuccessState.cart.cart_id,product_id:finalSuccessState.products[index].id));
            return ProductTileWidget(
            productDataModel: finalSuccessState.products[index],
            bloc: menuBloc,
            user: widget.user);
            })
            );

          default:
            return SizedBox(width: 0,);

        }
      },
    );
  }
}

