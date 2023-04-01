import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/auth_service.dart';
import 'bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: IconButton(
          icon: const Icon(Icons.logout_rounded),
          tooltip: 'Logout',
          onPressed: () async {
            context.read<ProfileBloc>().add(ProfileLogoutEvent());
          },
        ),
    );
  }
}
