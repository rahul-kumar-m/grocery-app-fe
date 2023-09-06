import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_fe/home/ui/customappbar.dart';

@RoutePage(name:"SignupPageRoute")
class SignUpPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: CustomAppBar(text:"Sign Up"),
      body:  Center(child:SigupForm()),
    );
  }
}

class SigupForm extends StatefulWidget {
  const SigupForm({super.key});

  @override
  State<SigupForm> createState() => _SigupFormState();
}

class _SigupFormState extends State<SigupForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isEmailValid=false;
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform form submission or other actions here
      String username = _usernameController.text.toString();
      String password = _passwordController.text;
      //print(username+password);
      //final User user=User(username: username, password: password);
      //loginBloc.add(LoginButtonClickedEvent(user: user));

    }

  }
  bool _validateEmail(String email) {
    // Define a regular expression pattern for email validation
    final RegExp emailPattern = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'); // Simple pattern, adjust as needed

    return emailPattern.hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

        child: Container(
          height: MediaQuery.of(context).size.height*0.7,
          width: MediaQuery.of(context).size.width*0.9,
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key:_formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          validator: (value){
                            if (value==null||value.isEmpty){
                              return 'Please enter your Username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2),borderRadius: BorderRadius.circular(15)),
                            labelText: 'Username',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _emailController,
                          validator: (value){
                            if (value==null||value.isEmpty){
                              return 'Please enter your Username';
                            }

                            return null;
                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2),borderRadius: BorderRadius.circular(15)),
                            labelText: 'Email',

                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          onChanged: (email) {
                          // Check email pattern validity when the email field changes
                          setState(() {
                          _isEmailValid = _validateEmail(email);
                          });
                          },
                          validator: (value){

                            if (_isEmailValid){
                              return 'Please enter your password';
                            }

                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2),borderRadius: BorderRadius.circular(15)),
                            labelText: 'Password',

                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _confirmPasswordController,
                          validator: (value){
                            if (value==null||value.isEmpty){
                              return 'Confirm Password';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2),borderRadius: BorderRadius.circular(15)),

                            labelText: 'Confirm Password',
                          ),
                        ),
                        SizedBox(height: 32.0),
                        FilledButton(
                          onPressed: () {
                            // Add your signup logic here

                            _submitForm();
                            String username = _usernameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword = _confirmPasswordController.text;

                            // Perform validation and signup process
                            if (password == confirmPassword) {
                              // Passwords match, proceed with signup
                              print('Username: $username');
                              print('Email: $email');
                              print('Password: $password');
                            } else {
                              // Passwords do not match, show an error message
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Password Mismatch'),
                                    content: Text('The entered passwords do not match.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('Sign Up'),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.1,)
            ],
          ),
        ),

    );
  }
}

