import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';
import '../../auth/models/user_model.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserModel? user;

  const ProfileHeaderWidget({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Blue background section
        Container(
          width: double.infinity,
          height: 130,
          color: AppColors.primary,
        ),
        
        // Avatar and info centered and overlapping
        Positioned(
          left: 0,
          right: 0,
          top: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar with white border
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: DecorationImage(
                    image: user?.avatar != null
                        ? NetworkImage(user!.avatar!)
                        : const NetworkImage('https://i.pravatar.cc/150?img=12'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Name
              Text(
                user?.name ?? 'tupex',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              // Email
              Text(
                user?.email ?? 'tupex@mail.com',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
