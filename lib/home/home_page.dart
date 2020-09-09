import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_challenger/login/login_page.dart';
import 'package:new_trip_challenger/model/user_model.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  final String uuid;

  HomePage({this.uuid});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int range;
  int minute;
  int kcal;
  int count = 0;
  String _uuid;

  @override
  void initState() {
    super.initState();

    _uuid = widget.uuid;

    if (_uuid != null) {
      _getInfoUser();
    }
  }

  _getInfoUser() async {
    final documentSnapshot =
        await Firestore.instance.collection("users").document(_uuid).get();

    UserModel user = UserModel.fromJson(documentSnapshot.data);

    print(user.toJson());
  }

  Widget _buildImageHome() {
    return Image.asset(
      'assets/images/20.jpg',
      width: double.infinity,
      height: 230,
      fit: BoxFit.fill,
    );
  }

  Widget _buildRowMenuLogout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMenu(),
        Scaffold.of(context).openDrawer(),
        _buildLogout(),
      ],
    );
  }

  Widget _buildMenu() {
    return Container(
      margin: const EdgeInsets.only(left: 21, top: 30),
      child: Image.asset(
        'assets/images/ui_30.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLogout() {
    return Container(
      margin: const EdgeInsets.only(left: 21, top: 30),
      child: IconButton(
        icon: Image.asset(
          'assets/images/logout.png',
          width: 20,
          height: 20,
        ),
        onPressed: () async {
          final user = await _auth.currentUser;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ),
    );
  }

  Widget _buildBodyList() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 143),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
        color: Colors.orange[50],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 17),
            _buildFormRunBike(
              imageLead: Image.asset(
                'assets/icons/icon_run.png',
                width: 33,
                height: 35,
              ),
              textLead: 'Running',
            ),
            _buildFormRunBike(
              imageLead: Image.asset(
                'assets/icons/icon_bike.png',
                width: 33,
                height: 35,
              ),
              textLead: 'Bike racing',
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Image.asset('assets/images/cal_week.png',
                    fit: BoxFit.cover)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormRunBike({
    Image imageLead,
    String textLead,
    TextEditingController controller,
  }) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/2x/ui_21.png',
          height: 216,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 41),
              child: imageLead,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 31),
              child: Text(
                textLead,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Flexible(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 50),
                    child: Image.asset(
                      'assets/images/3x/ui_22.png',
                      width: 108.76,
                      height: 108.76,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 35, top: 87),
                    child: Text(
                      '$range km\nVietnam Grand Prix',
                      style: TextStyle(fontSize: 9),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildIconTimeKcal(
                        image: Image.asset(
                          'assets/icons/icon_time.png',
                          width: 15,
                          height: 20,
                        ),
                        text: '$minute minute',
                      ),
                      SizedBox(width: 15, height: 70),
                      _buildIconTimeKcal(
                        image: Image.asset(
                          'assets/icons/icon_kcal.png',
                          width: 15,
                          height: 20,
                        ),
                        text: '$kcal kcal',
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/3x/ui_25.png',
                    width: 155.32,
                    height: 60.22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButtonTrainChall(text: 'Trainning'),
                      SizedBox(width: 5),
                      _buildButtonTrainChall(text: 'Challenge'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextTrip() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        'Trip Challenger',
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIconTimeKcal({String text, Image image}) {
    return Column(
      children: [
        image,
        Text(
          text,
          style: TextStyle(fontSize: 15, color: Colors.black),
        )
      ],
    );
  }

  Widget _buildButtonTrainChall({String text}) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.orange),
      ),
      onPressed: () {},
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Stack(
          children: [
            _buildImageHome(),
            _buildRowMenuLogout(),
            _buildBodyList(),
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: _buildTextTrip(),
            ),
          ],
        ),
      ),
    );
  }
}
