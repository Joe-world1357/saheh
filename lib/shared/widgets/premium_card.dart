import 'package:flutter/material.dart';

enum CardElevation { flat, elevated, glass, neon }

class PremiumCard extends StatefulWidget {
  final Widget child;
  final CardElevation elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final VoidCallback? onTap;
  final bool enableHoverEffect;
  final Color? customColor;
  final Gradient? gradient;
  
  const PremiumCard({
    super.key,
    required this.child,
    this.elevation = CardElevation.elevated,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    this.enableHoverEffect = true,
    this.customColor,
    this.gradient,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.01).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    if (!widget.enableHoverEffect) return;
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? 16;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: _buildDecoration(context, borderRadius),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  onHover: _onHover,
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Container(
                    padding: widget.padding ?? const EdgeInsets.all(16),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _buildDecoration(BuildContext context, double borderRadius) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor;
    
    switch (widget.elevation) {
      case CardElevation.flat:
        return BoxDecoration(
          color: widget.customColor ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        );
        
      case CardElevation.elevated:
        return BoxDecoration(
          color: widget.customColor ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: _isHovered ? theme.colorScheme.primary.withOpacity(0.3) : borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: _isHovered ? 12 : 4,
              offset: Offset(0, _isHovered ? 4 : 1),
            ),
          ],
        );
        
      case CardElevation.glass:
        return BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        );
        
      case CardElevation.neon:
        return BoxDecoration(
          gradient: widget.gradient,
          color: widget.gradient == null ? (widget.customColor ?? theme.colorScheme.surface) : null,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: _isHovered ? theme.colorScheme.primary : borderColor,
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        );
    }
  }
}
