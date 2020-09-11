import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_challenger/home/home_page.dart';
import 'package:new_trip_challenger/register/register_page.dart';
import 'package:new_trip_challenger/validate/validate.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Widget _buildTextTop() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 23, top: 123),
          child: Text(
            'LOGIN',
            style: TextStyle(fontSize: 30, color: Colors.orange),
          ),
        ),
      ],
    );
  }

  Widget _buildFormInput() {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(left: 20, top: 15.78, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.orange[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          Image.asset('assets/images/ui_40.png', fit: BoxFit.fill),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTextFormField(
                controller: _emailController,
                icon: Icon(Icons.email, color: Colors.orange[300]),
                text: 'Email address',
                obscureText: false,
                maxlength: 50,
                validator: validateName,
              ),
              _buildTextFormField(
                controller: _passController,
                icon: Icon(Icons.lock, color: Colors.orange[300]),
                text: 'Password',
                obscureText: true,
                maxlength: 8,
                validator: validatePass,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    String text,
    Icon icon,
    bool obscureText,
    int maxlength,
    String Function(String) validator,
    TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: icon,
          isDense: true,
          prefixIconConstraints: BoxConstraints(
            minHeight: 15,
            minWidth: 15,
          ),
          hintText: text,
          contentPadding: const EdgeInsets.only(left: 30),
        ),
        obscureText: obscureText,
        maxLength: maxlength,
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildButtonLogRegis({String text, Function callback}) {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(left: 20, top: 20.99, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.orange[300],
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10.97,
            right: 14.53,
            child: Image.asset(
              'assets/images/2x/ui_43.png',
              width: 54.82,
              height: 25,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: GestureDetector(
              child: Text(
                text,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              onTap: callback,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBot() {
    return Text(
      'Forgot password?',
      style: TextStyle(fontSize: 13, decoration: TextDecoration.underline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextTop(),
              _buildFormInput(),
              _buildButtonLogRegis(
                text: 'Login',
                callback: () {
                  if (_formKey.currentState.validate()) {
                    _login();
                  }
                },
              ),
              SizedBox(height: 19),
              _buildTextBot(),
              _buildButtonLogRegis(
                text: 'Register',
                callback: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final user = (await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passController.text))
        .user;
    if (user != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage(uuid: user.uid)));
    }
  }
}
