import 'package:flutter/material.dart';
import 'package:grocery_app_fe/route.dart';
import 'package:grocery_app_fe/data/user.dart';
import 'package:grocery_app_fe/login/Bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app_fe/main.dart';
import 'package:auto_route/auto_route.dart';
//import 'package:grocery_app_fe/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage(name:"loginPageRoute")
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}
final _appRouter = MyRouter();

@override
Widget build(BuildContext context){
  return MaterialApp.router(
    routerConfig: _appRouter.config(),
  );
}
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final LoginBloc loginBloc = new LoginBloc();


  double proportion=0.2;


  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFieldFocusNode = FocusNode();
  final FocusNode _textFieldFocusNode2 = FocusNode();


  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _scrollToTop(){
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc.add(LoginLoadingEvent());
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform form submission or other actions here
      String username = _usernameController.text.toString();
      String password = _passwordController.text;
      //print(username+password);
      final User user=User(username: username, password: password);
      loginBloc.add(LoginButtonClickedEvent(user: user));

    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc:loginBloc,
      listenWhen: (context,state)=> state is LoginActionState,
      listener: (context, state) {
        if (state is LoginUserNotFoundActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User does not exist !!")));
          _usernameController.text="";
          _passwordController.text="";
          setState(() {
          });
        }
        else if (state is LoginPasswordIncorrectActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Incorrect!!")));
          _passwordController.text="";
          setState(() {
          });
        }
        else if (state is LoginSuccessfulActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful"),dismissDirection: DismissDirection.up,));
          _usernameController.text="";
          _passwordController.text="";
          setState(() {
          });
        }
        else if(state is LoginForwardToProductPageActionState){
            final fstate = state as LoginForwardToProductPageActionState;
            //context.router.popTop();
            context.router.push(HomePageroute(user:fstate.user));
        }

      },
      buildWhen: (previous,current)=>current is !LoginActionState,
      builder: (BuildContext context, LoginState state) {

        switch(state.runtimeType){
          case LoginLoadedState:
            return SingleChildScrollView(
        controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.25,
                    width: 190.0,
                    padding: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Image.asset("asset/new_logo.png"),
                  ),
                  SizedBox(height: 100,),
                  Container(
                    height: MediaQuery.of(context).size.height*0.375,
                    width: 380,
                    child: Card(
                      elevation: 25,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Form(
                          key:_formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  //scrollController: _scrollController,
                                  //scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+10),
                                  focusNode: _textFieldFocusNode,
                                  onTapOutside: (p){
                                    _scrollToTop();
                                  },
                                  onTap: (){
                                    //proportion=0.5;
                                    _scrollToBottom();

                                  },
                                  validator: (value){
                                    if (value==null||value.isEmpty){
                                      return 'Please enter your Username';
                                    }
                                    return null;
                                  },
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'User Name',
                                      hintText: 'Enter valid username'

                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(

                                  //scrollController: _scrollController,
                                  focusNode: _textFieldFocusNode2,
                                  onTapOutside: (p){
                                    _scrollToTop();
                                  },
                                  onTap: (){
                                    //proportion=0.5;
                                    _scrollToBottom();

                                  },
                                  validator: (value){
                                    if (value==null||value.isEmpty){
                                      return 'Please enter your Password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      hintText: 'Enter your secure password'

                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              FilledButton(
                                onPressed: () {
                                  // Perform login logic here
                                  _submitForm();
                                },
                                child: Text('Login'),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //
                              //   children: [
                              //     Text("Not Registered?"),
                              //     TextButton(onPressed: (){context.router.push(SignupPageRoute());}, child: Text("Sign Up",style: TextStyle(color: Colors.blue), ))
                              //   ],
                              // )
                            ],

                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*proportion,),
                ],
              ),
            );
          case LoginPageErrorState:
            return Scaffold(
              body:Center(
                child:Text("ERROR"),
              )
            );
          default:
            return Scaffold();
        }

      },
    );
  }
}
