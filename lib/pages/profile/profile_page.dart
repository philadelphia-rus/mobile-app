import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:go_router/go_router.dart';

import '../../service/api_requests.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import 'bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final authService = Injector().get<AuthService>();
  final String username = 'admin';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(authService: authService),
      child: Scaffold(
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLogoutState) {
              context.go(Routes.signInPage);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 40,
                          color: AppColors.color7e56e8,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.person,
                          size: 40, color: AppColors.color7e56e8),
                      radius: 150.0,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('@$username'),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: InkWell(
                        onTap: () {
                          context.read<ProfileBloc>().add(ProfileLogoutEvent());
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Log out'),
                                Spacer(),
                                Icon(Icons.chevron_right_rounded)
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
