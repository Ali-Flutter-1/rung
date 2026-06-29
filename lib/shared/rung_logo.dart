import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// The Rung mark. Single source of truth for the logo so a future asset swap
/// touches only this file (the asset path may change later).
const String kRungLogoAsset = 'assets/images/rang_logo.png';

class RungLogo extends StatelessWidget {
  const RungLogo({super.key, this.size = 64});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      kRungLogoAsset,
      width: size,
      height: size,
      filterQuality: FilterQuality.medium,
      // Graceful fallback if the asset is ever missing/renamed.
      errorBuilder: (_, _, _) => Icon(
        Icons.stairs_rounded,
        size: size * 0.7,
        color: AppColors.primary,
      ),
    );
  }
}

/// Logo + "Rung" wordmark in brand teal — used in app bars / headers.
class RungWordmark extends StatelessWidget {
  const RungWordmark({super.key, this.markSize = 28});
  final double markSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RungLogo(size: markSize),
        const SizedBox(width: 8),
        Text(
          'Rung',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryDeep,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}
