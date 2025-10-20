import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/storage_service.dart';

/// Reusable User Header Widget
/// Displays user avatar, name, ID, and settings button
/// Used across multiple screens (Dashboard, Withdraw, Balance History, etc.)
class UserHeader extends StatelessWidget {
  final double scale;
  final VoidCallback? onSettingsTap;
  final bool showSettings;

  const UserHeader({
    super.key,
    required this.scale,
    this.onSettingsTap,
    this.showSettings = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final userName = user?.name ?? 'NAFSIN RAHMAN';
        final userId = user?.id.toString() ?? '34874';

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 12 * scale,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User Info
              Expanded(
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 40 * scale,
                      height: 40 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0B8FF),
                        borderRadius: BorderRadius.circular(20 * scale),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13 * scale),
                        child: Padding(
                          padding: EdgeInsets.all(3 * scale),
                          child: Image.asset(
                            'assets/figma_exports/52ec367639c91dd0186e7c21dba64d8ed1375a47.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 24 * scale,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(width: 7 * scale),
                    
                    // User Details
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Oddlini',
                              fontSize: 13 * scale,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'User ID: $userId',
                            style: TextStyle(
                              fontFamily: 'Satoshi',
                              fontSize: 10 * scale,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF7B7B7B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Settings Button
              if (showSettings)
                GestureDetector(
                  onTap: onSettingsTap,
                  child: Image.asset(
                    'assets/figma_exports/d221e5c78d3d50402888e8534c8e50c2ea421f24.png',
                    width: 28 * scale,
                    height: 28 * scale,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.settings,
                      size: 28 * scale,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

