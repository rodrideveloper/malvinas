import 'package:Malvinas/main.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Malvinas/register_page.dart';
import 'package:Malvinas/utilidades/authentication_client.dart';
import 'package:Malvinas/utilidades/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  final _authClient = AuthenticationClient();

  bool _isProgress = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
             centerTitle: true,
         
          backgroundColor: ColoresApp.color_negro,
          elevation: 0,
          /* shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))))*/
        
          title: const Text('Iniciar Sesion'),
        
        ),
        body: SizedBox(  height: screenHeight - keyboardHeight,
          child: SingleChildScrollView(
            
             physics:  AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
            
            height: screenHeight,
                color: ColoresApp.color_fondo,
                child: Form(
                  
                  key: _formKey,
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                       decoration: BoxDecoration(
                    
                    ),
                    child: Container(
                     
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.all(20),
                      child: Image.asset('assets/img/malvinas.png'),
                    ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        validator: Validator.email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          label: Text('Email'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                      
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        validator: Validator.password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          label: Text('Password'),
      
                        ),
                      ),
                      const SizedBox(height: 24),
                      _isProgress
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(
                         ColoresApp.color_negro),),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      _isProgress = true;
                                    });
                              
                                    final User user = await _authClient.loginUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    setState(() {
                                      _isProgress = false;
                                    });
          
          
                                    
          
                                    if (user != null) {
                                 Navigator.of(context).pushNamedAndRemoveUntil('/inicio', (route) => false,arguments:{'user':user} );
                                    }
                                  }
                                },
                                child: const Padding(
                                  
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'Iniciar Sesion',
                                    style: TextStyle(fontSize: 22.0),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'No tenes cuenta? Click acá para registrarte',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        
          ),
        ),
      ),
    );
  }
}
