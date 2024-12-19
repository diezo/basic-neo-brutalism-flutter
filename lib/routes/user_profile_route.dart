import 'package:flutter/material.dart';
import '../components/neo_brutal_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserProfileRoute extends StatefulWidget {
  const UserProfileRoute({super.key});

  final String userDisplayName = "John Behr";
  final String userUsername = "behr";

  final String userPictureUrl =
      "https://i.ibb.co/zmZRnPk/istockphoto-1388253782-612x612-1.jpg";

  @override
  State<StatefulWidget> createState() => _UserProfileRoute();
}

class _UserProfileRoute extends State<UserProfileRoute> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  late FToast followingToast;
  bool following = false;

  @override
  void initState() {
    super.initState();

    secureStorage.read(key: "following").then((val) {
      setState(() => following = (val != null && val == "yes"));
    });

    followingToast = FToast();
    followingToast.init(context);
  }

  void toggleFollow() {
    setState(() {
      following = !following;

      secureStorage.write(key: "following", value: following ? "yes" : "no");

      if (!following) {
        if (kIsWeb) {
          ScaffoldMessenger.of(context).clearSnackBars();
        } else {
          followingToast.removeCustomToast();
          followingToast.removeQueuedCustomToasts();
        }
        return;
      }

      final String message = "You're now following @${widget.userUsername}";

      if (kIsWeb) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } else {
        followingToast.removeCustomToast();
        Fluttertoast.showToast(msg: message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdfd96),
      body: Container(
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 5),
          borderRadius: BorderRadius.circular(20),
          color: Color(0xfff4d738),
        ),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(6, 7),
                        spreadRadius: -3)
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    widget.userPictureUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  widget.userDisplayName,
                  style: TextStyle(
                    fontFamily: "LexendMega",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                "@${widget.userUsername}",
                style: TextStyle(
                  fontFamily: "LexendMega",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0x80000000),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeoBrutalButton(
                      text: following ? "FOLLOWING" : "FOLLOW",
                      backgroundColor:
                          following ? Color(0xfff8d6b3) : Color(0xffff6b6b),
                      splashColor:
                          following ? Color(0xfff8d6b3) : Color(0xffffa07a),
                      strokeColor: Colors.black,
                      textColor: following ? Color(0xffff6b6b) : Colors.black,
                      // textColor: Colors.black,
                      onPressed: toggleFollow,
                    ),
                    NeoBrutalButton(
                      text: "MESSAGE",
                      backgroundColor: Color(0xff69d2e7),
                      splashColor: Color(0xffa7dbd8),
                      strokeColor: Colors.black,
                      textColor: Colors.black,
                      margin: EdgeInsets.only(left: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
