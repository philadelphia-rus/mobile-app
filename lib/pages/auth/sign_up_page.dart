import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/ui/text_fields.dart';

import '../../service/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final authService = Injector().get<AuthService>();

  final _textFormLoginController = TextEditingController();
  final _textFormPasswordController = TextEditingController();
  final _textFormNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(authService: authService),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              _showSnackBar(context: context, text: state.error);
            } else if (state is SignUpSuccess) {
              context.go(Routes.road);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: <Widget>[
                    Flexible(flex: 2, child: Container()),
                    Text(
                      'Регистрация',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 35,
                      ),
                    ),
                    Flexible(flex: 1, child: Container()),
                    Row(
                      children: [
                        Text(
                          'Имя',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    PrimaryTextField(
                      controller: _textFormNameController,
                      labelText: '',
                      labelStyle: TextStyle(),
                      validator: (e) {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Логин',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    PrimaryTextField(
                      controller: _textFormLoginController,
                      labelText: '',
                      labelStyle: TextStyle(),
                      validator: (e) {},
                    ),
                    Row(
                      children: [
                        Text(
                          'Пароль',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    PrimaryTextField(
                      controller: _textFormPasswordController,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.color7e56e8,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              //signUp
                              context.read<SignUpBloc>().add(
                                  SignUpReg(
                                    name: _textFormNameController.text,
                                    login: _textFormLoginController.text,
                                    password: _textFormPasswordController.text,                                    
                                  ),
                                );
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: const Text(
                                  'Регистрация',
                                  style: TextStyle(
                                      fontFamily: 'VarelaRound',
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: CupertinoButton(
                          onPressed: () {
                            context.go(Routes.signInPage);
                          },
                          child: Text(
                            "Вход",
                            style: TextStyle(
                              color: AppColors.color7e56e8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(flex: 3, child: Container()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
