import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Reusable widget for displaying network images with error handling and caching
class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? placeholderColor;
  final IconData placeholderIcon;
  final double placeholderIconSize;

  const NetworkImageWidget({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderColor,
    this.placeholderIcon = Icons.medication_outlined,
    this.placeholderIconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholderBgColor = placeholderColor ?? theme.colorScheme.surfaceVariant ?? Colors.grey.shade100;
    final iconColor = theme.colorScheme.onSurfaceVariant ?? Colors.grey.shade400;

    // If no image URL, show placeholder
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder(placeholderBgColor, iconColor);
    }

    // Build container with optional border radius
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildPlaceholder(placeholderBgColor, iconColor),
      errorWidget: (context, url, error) => _buildPlaceholder(placeholderBgColor, iconColor),
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
    );

    // Apply border radius if provided
    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildPlaceholder(Color bgColor, Color iconColor) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Icon(
          placeholderIcon,
          color: iconColor,
          size: placeholderIconSize,
        ),
      ),
    );
  }
}

/// Specialized widget for pharmacy product images
class PharmacyProductImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const PharmacyProductImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return NetworkImageWidget(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      placeholderIcon: Icons.medication_outlined,
      placeholderIconSize: 40,
    );
  }
}

