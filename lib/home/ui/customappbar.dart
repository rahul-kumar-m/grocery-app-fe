import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_fe/logout%20Dialog.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          //Image.asset('asset/new_logo.png', width: 60, height: 50),
          //SizedBox(width: 30,),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(text,
              style: GoogleFonts.dancingScript(
                
                fontWeight: FontWeight.bold,
                color:Colors.white,
                fontSize: 30,
              ),

            ),
          ),
          IconButton(onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return LogoutDialog();
              },
            );
          }, icon: Icon(Icons.logout,color: Colors.white,))
          // ElevatedButton(onPressed: (){}, child: Text("LOGOUT",
          //           style: GoogleFonts.dancingScript(
          //             backgroundColor: Colors.red,
          //
          //           fontWeight: FontWeight.bold,
          //           color:Colors.white,
          //           fontSize: 20,
          //           ),
          // ),
          //   style: ElevatedButton.styleFrom(backgroundColor:Colors.red),
          // )
      ]
      )
      // Adjust width and height as needed
      // Other AppBar properties can be set here
    );
  }
}
