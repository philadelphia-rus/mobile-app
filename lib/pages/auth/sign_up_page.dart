import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/ui/text_fields.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final _loginTextControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: <Widget>[
              Flexible(flex: 2, child: Container()),
              Text(
                'Введите имя',
                style: TextStyle(
                  fontFamily: 'VarelaRound',
                  fontSize: 23,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryTextField(
                controller: _loginTextControler,
                labelText: '',
                labelStyle: TextStyle(),
                validator: (e) {},
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.color7e56e8,),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        // signIn
                        context.go(Routes.road);
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: const Text('Войти', style: TextStyle(fontFamily: 'VarelaRound', fontSize: 20, color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
