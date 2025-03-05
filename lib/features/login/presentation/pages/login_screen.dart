import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ar_map_project/common/utils/sizes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Xử lý logic đăng nhập ở đây
      String email = _emailController.text;
      String password = _passwordController.text;

      // Ví dụ: In thông tin đăng nhập ra console
      print('Email: $email, Password: $password');

      // TODO: Gọi API đăng nhập hoặc xử lý logic đăng nhập khác
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
        height: ScreenDimensions.height*0.47,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  color: CupertinoColors.systemFill,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Username',
                style: TextStyle(color: CupertinoColors.white),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey2,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(12),
              ),
              CupertinoTextField(
                controller: _passwordController,
                obscureText: true,
                placeholder: 'Password',
                style: TextStyle(color: CupertinoColors.white),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey2,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    child: Text('Login'),
                    onPressed: _submitForm,
                    color: CupertinoColors.label,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    child: Text('Help?'),
                    onPressed: () {
                      // TODO: Xử lý logic quên mật khẩu
                    },
                    color: CupertinoColors.inactiveGray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}