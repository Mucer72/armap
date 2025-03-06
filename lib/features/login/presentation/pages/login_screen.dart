import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ar_map_project/common/utils/sizes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Login Failed"),
          content: Text(e.toString()),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: ScreenDimensions.height*0.45,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Log in", style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
                CupertinoTextField(
                  controller: _usernameController,
                  placeholder: "Username",
                  prefix: Icon(CupertinoIcons.person),
                ),
                CupertinoTextField(
                  controller: _passwordController,
                  placeholder: "Password",
                  obscureText: true,
                  prefix: Icon(CupertinoIcons.lock),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                      color: CupertinoColors.systemGrey3,
                      child: Row(children: [
                        Icon(CupertinoIcons.question_circle),
                        SizedBox(width: 4),
                        Text("Help")
                      ]),
                      onPressed: () {},
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      transform: _isLoading ? Matrix4.diagonal3Values(1.1, 1.1, 1) : Matrix4.identity(),
                      child: CupertinoButton(
                      color: CupertinoColors.systemGrey,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                        onPressed: _isLoading ? null : _login,
                        child: _isLoading
                            ? CupertinoActivityIndicator()
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Login"),
                                SizedBox(width: 4),
                                Icon(CupertinoIcons.arrow_right_circle_fill, color: CupertinoColors.white),
                                
                              ]),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
