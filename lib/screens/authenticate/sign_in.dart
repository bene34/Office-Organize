import 'package:flutter/material.dart';
import 'package:org_off_ia/services/auth.dart';
import 'package:org_off_ia/shared/constants.dart';
import 'package:org_off_ia/shared/loading.dart';
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authentication = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  // text field state
  String email = '';
  String password = '';
  String error = '';




  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Sign in to Office Organize'),
    
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
        key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              TextFormField(
                decoration: decor.copyWith(hintText: 'Enter email'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter an email";
                  }
                  return null;
                },     
                onChanged: (val){
                  setState(() {
                    email = val;
                  });

                }
              ),
              SizedBox(height: 30.0),
              TextFormField(
                obscureText: true,
               decoration: decor.copyWith(hintText: 'Enter password'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter password";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                    
                  

                }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                    child: Text('Login'),
                    style: ButtonStyle(
                     backgroundColor: 
                       MaterialStateProperty.all(Colors.green[400]),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.black))),
                  
                
            
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authentication.signInWithEmailandPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Try again';
                          });
                          setState(() {
                            loading = false;
                          });

                        }
                      }
                    }
                ),
                // adding image 
                 SizedBox(height: 12.0),
                Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                 Image.asset('assets/logo.png')
              


            ],
          ),
        ),
      ),
    );
    }
  }
}