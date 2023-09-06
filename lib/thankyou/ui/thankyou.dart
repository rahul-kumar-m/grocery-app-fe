import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_fe/route.dart';

import '../../data/user.dart';
import '../bloc/thankyou_bloc.dart';

@RoutePage(name: "thankyoupage")
class ThankYou extends StatefulWidget {
  final User user;
  const ThankYou({super.key, required this.user});

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  final ThankyouBloc thankYouBloc=new ThankyouBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thankYouBloc.add(ThankYouInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThankyouBloc, ThankyouState>(
      bloc:thankYouBloc,
      listenWhen:(previous,current) => current is ThankYouActionState,
      listener: (context, state) {
        if (state is ThankYouForwardActionState){
          context.router.popTop();
          context.router.push(HomePageroute(user: widget.user));
        }
      },
      buildWhen: (previous,current) => current is ThankYouActionState,
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.teal,
            body: Center(
              child: Image.asset("asset/images/thank_you.png"),
            )
        );
      },
    );
  }
}
