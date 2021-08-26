import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_example2/stores/login_store.dart';
import 'package:mobx_example2/widgets/custom_icon_button.dart';
import 'package:mobx_example2/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    autorun((_) {
      print("${loginStore.loggedIn} logado");
      if (loginStore.loggedIn == true) {
        print("logou");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ListScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(32),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Observer(builder: (_) {
                        return CustomTextField(
                          hint: 'E-mail',
                          prefix: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail,
                          enabled: !loginStore.loading,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      Observer(builder: (_) {
                        return CustomTextField(
                          hint: 'Senha',
                          prefix: Icon(Icons.lock),
                          obscure: !loginStore.visiblePassword,
                          onChanged: loginStore.setPassword,
                          enabled: !loginStore.loading,
                          suffix: CustomIconButton(
                            radius: 32,
                            iconData: loginStore.visiblePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onTap: loginStore.isVisible,
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      Observer(builder: (context) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                            child: loginStore.loading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text('Login'),
                            onPressed: (loginStore.isEmailValid &&
                                    loginStore.isPasswordValid &
                                        !loginStore.loading)
                                ? loginStore.login
                                : null,
                          ),
                        );
                      })
                    ],
                  )),
            )),
      ),
    );
  }
}
