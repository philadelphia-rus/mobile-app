import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/utils/app_colors.dart';

import '../../service/auth_service.dart';
import '../../utils/app_routes.dart';
import '../profile/bloc/profile_bloc.dart';

class KnowledgeBasePage extends StatelessWidget {
  KnowledgeBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [_Header()],
      ),
    );
  }

}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: AppColors.color7e56e8,
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.logout_rounded),
              tooltip: 'Logout',
              onPressed: () {
                context.push(Routes.profile);
              },
            ),
          ),
        ],
      ),
    );
  }
}
