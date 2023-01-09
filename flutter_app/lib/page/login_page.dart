import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/index.dart';
import 'package:flutter_app/model/login_response.g.dart';
import 'package:flutter_app/utils/images.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  static final FormFieldValidator<String> accountValidator = (value) {
    if (value!.isEmpty || value.length < 4 && value.length > 20) {
      return '账户长度不正确';
    }
    return null;
  };

  static final FormFieldValidator<String> passwordValidator = (value) {
    if (value!.isEmpty || value.length < 4 && value.length > 20) {
      return '密码长度不正确';
    }
    return null;
  };

  Duration get loginTime => Duration(milliseconds: 100);

  Future<String> _authUser(LoginData data) async {
    DataResult dataresult =
        await IndexDao.getLoginDao(data.name, data.password);
    LoginResponse loginResponse = dataresult.data;

    return Future.delayed(loginTime).then((_) async {
      if (loginResponse.code == 1) {
        await IndexDao.IsLoginDao();
        return "";
      } else
        return "用户名或密码错误！";
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '施耐克扫码',
      logo: Assets.IC_LAUNCHER,
      onLogin: _authUser,
      //onSignup: _authUser,
      userType: LoginUserType.name,
      hideForgotPasswordButton: true,
      //hideSignUpButton: true,
      hideProvidersTitle: true,
      userValidator: accountValidator,
      passwordValidator: passwordValidator,
      messages: LoginMessages(
          userHint: '账户',
          passwordHint: '密码',
          loginButton: '登录',
          flushbarTitleError: "登录错误",
          flushbarTitleSuccess: "登录成功"),
      theme: LoginTheme(
        titleStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Quicksand',
          fontSize: 12,
          letterSpacing: 4,
        ),
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed("/index");
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
