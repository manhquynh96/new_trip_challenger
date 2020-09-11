import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_challenger/home/home_page.dart';
import 'package:new_trip_challenger/login/login_page.dart';
import 'package:new_trip_challenger/model/user_model.dart';
import 'package:new_trip_challenger/validate/validate.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final databaseReference = Firestore.instance;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _radioValue = -1;
  int range;
  int minute;
  int kcal;
  int count = 0;

  String date;
  DateTime _dateTime = DateTime.now();

  bool isShow = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  Widget _buildGender() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Text(
            'Gender:',
            style: TextStyle(fontSize: 17, color: Colors.black45),
          ),
          Expanded(
            flex: 1,
            child: RadioListTile(
              value: 0,
              groupValue: _radioValue,
              title: Text(
                'Male',
                style: TextStyle(fontSize: 17, color: Colors.black45),
              ),
              onChanged: (newValue) => setState(() => _radioValue = newValue),
              activeColor: Colors.orange,
              selected: false,
            ),
          ),
          Expanded(
            flex: 1,
            child: RadioListTile(
              value: 1,
              groupValue: _radioValue,
              title: Text(
                'Female',
                style: TextStyle(fontSize: 17, color: Colors.black45),
              ),
              onChanged: (newValue) => setState(() => _radioValue = newValue),
              activeColor: Colors.orange,
              selected: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextTop() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 23, top: 123),
          child: Text(
            'REGISTER',
            style: TextStyle(fontSize: 30, color: Colors.orange),
          ),
        ),
      ],
    );
  }

  Widget _buildFormInput() {
    return Container(
      width: double.infinity,
      height: 290,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextFormField(
                controller: _nameController,
                icon: Icon(
                  Icons.person,
                  color: Colors.orange[300],
                ),
                text: 'Full name',
                obscureText: false,
                maxlength: 30,
                validator: validateName,
              ),
              _buildTextFormField(
                controller: _emailController,
                icon: Icon(
                  Icons.email,
                  color: Colors.orange[300],
                ),
                text: 'Email address',
                obscureText: false,
                maxlength: 50,
                validator: validateEmail,
              ),
              _buildTextFormField(
                controller: _passController,
                icon: Icon(
                  Icons.lock,
                  color: Colors.orange[300],
                ),
                text: 'Password',
                obscureText: true,
                maxlength: 8,
                validator: validatePass,
              ),
              Row(
                children: [
                  _buildTextFieldWeightHeight(
                    controller: _heightController,
                    icon: Icon(
                      Icons.accessibility,
                      color: Colors.orange[300],
                    ),
                    text: 'Height',
                    validator: validateHeight,
                  ),
                  _buildTextFieldWeightHeight(
                    controller: _weightController,
                    icon: Icon(
                      Icons.android,
                      color: Colors.orange[300],
                    ),
                    text: 'Weight',
                    validator: validateWeight,
                  ),
                ],
              ),
              _buildDate(),
              _buildGender(),
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
    TextEditingController controller,
    String Function(String) validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: controller,
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
      ),
    );
  }

  Widget _buildTextFieldWeightHeight({
    Icon icon,
    String text,
    TextEditingController controller,
    String Function(String) validator,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: controller,
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
          maxLength: 3,
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.black26,
      ))),
      child: InkWell(
        onTap: () {
          setState(() {
            isShow = true;
          });
        },
        child: Row(
          children: [
            Icon(
              Icons.date_range,
              color: Colors.orange[300],
              size: 17,
            ),
            Text(
              date ?? 'Date of birth',
              style: TextStyle(fontSize: 17, color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRegis({String text, Function callback}) {
    return Container(
      width: double.infinity,
      height: 48,
      // alignment: Alignment.center,
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
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: TextStyle(color: Colors.black),
          ),
          GestureDetector(
            child: Text('Login', style: TextStyle(color: Colors.orange)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
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
              isShow
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 43,
                          margin: const EdgeInsets.only(top: 100),
                          color: Colors.orange,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      isShow = false;
                                      date =
                                          '${_dateTime.month}/${_dateTime.day}/${_dateTime.year}';
                                    },
                                  );
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 210,
                          child: CupertinoDatePicker(
                            backgroundColor: Colors.orange[100],
                            initialDateTime: _dateTime,
                            use24hFormat: true,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (dateTime) {
                              print(dateTime);
                              setState(
                                () {
                                  _dateTime = dateTime;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Column(
                        children: [
                          _buildButtonRegis(
                            text: 'Register',
                            callback: () {
                              if (_formKey.currentState.validate()) {
                                _register();
                              }
                            },
                          ),
                          _buildTextBot(),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  FirebaseUser user;

  Future<void> _register() async {
    user = (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passController.text))
        .user;
    if (user != null) {
      setState(() {
        user.email;

        createRecord();

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }

  void createRecord() async {
    await databaseReference
        .collection('users')
        .document('${user.uid}')
        .setData(UserModel(
          id: '${user.uid}',
          name: _nameController.text,
          email: _emailController.text,
          height: _heightController.text,
          weight: _weightController.text,
          date: date,
          gender: _radioValue,
          range: range,
          minute: minute,
          kcal: kcal,
        ).toJson());
  }
}
