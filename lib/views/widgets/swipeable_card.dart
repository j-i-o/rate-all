import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/category_card.dart';

class SwipeableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTap;
  final bool categoryStyle;

  const SwipeableCard({
    super.key,
    required this.child,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
    this.categoryStyle = false,
  });

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late double maxSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: widget.categoryStyle ? -130 : -70,
      upperBound: 0,
      value: 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.delta.dx;

    if (_controller.value < -maxSlide) {
      _controller.value = -maxSlide;
    }

    if (_controller.value > 0) {
      _controller.value = 0;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx < -300) {
      _controller.animateTo(-maxSlide);
      return;
    }

    if (details.velocity.pixelsPerSecond.dx > 300) {
      _controller.animateTo(0);
      return;
    }

    if (_controller.value.abs() > maxSlide / 2) {
      _controller.animateTo(-maxSlide);
    } else {
      _controller.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    maxSlide = widget.categoryStyle ? 150 : 120;
    return TapRegion(
      onTapOutside: (event) => _controller.animateTo(0),
      child: ClipRect(
        child: Stack(
          children: [
            //Background buttons
            Positioned.fill(
              right: 5,
              child: Builder(
                builder: (context) {
                  if (widget.categoryStyle) {
                    return Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _ActionButton(
                          categoryStyle: widget.categoryStyle,
                          color: Colors.blue,
                          icon: Icons.edit_rounded,
                          onTap: () {
                            widget.onEdit();
                            _controller.animateTo(0);
                          },
                        ),
                        _ActionButton(
                          categoryStyle: widget.categoryStyle,
                          color: Colors.red,
                          icon: Icons.delete_rounded,
                          onTap: () {
                            _controller.animateTo(0);
                            widget.onDelete();
                          },
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            _ActionButton(
                              categoryStyle: widget.categoryStyle,
                              color: Colors.blue,
                              icon: Icons.edit_rounded,
                              onTap: () {
                                widget.onEdit();
                                _controller.animateTo(0);
                              },
                            ),
                            _ActionButton(
                              categoryStyle: widget.categoryStyle,
                              color: Colors.red,
                              icon: Icons.delete_rounded,
                              onTap: () {
                                _controller.animateTo(0);
                                widget.onDelete();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            //Foreground card
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final fullWidth = constraints.maxWidth;
                    final visibleWidth = fullWidth + _controller.value;

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(width: visibleWidth, child: child),
                    );
                  },
                );
              },
              child: GestureDetector(
                onHorizontalDragUpdate: _handleDragUpdate,
                onHorizontalDragEnd: _handleDragEnd,
                onTap: () {
                  if (_controller.value == 0) {
                    //Está cerrado
                    widget.onTap?.call();
                  } else {
                    _controller.animateTo(0);
                  }
                },
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final bool categoryStyle;

  const _ActionButton({
    required this.color,
    required this.icon,
    required this.onTap,
    required this.categoryStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: categoryStyle ? EdgeInsets.symmetric(vertical: 4.0): EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: 60,
        height: categoryStyle ? null : 50,
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: color,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: onTap,
            child: Center(child: Icon(icon, color: Colors.white, size: 30)),
          ),
        ),
      ),
    );
  }
}
