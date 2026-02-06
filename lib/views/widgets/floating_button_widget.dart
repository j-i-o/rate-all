import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/notifiers.dart';

class FloatingButtonWidget extends StatefulWidget {
  const FloatingButtonWidget({super.key, required this.newItem});

  final bool newItem;

  @override
  State<FloatingButtonWidget> createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) => setState(() => showMenu = false),
      child: ValueListenableBuilder(
        valueListenable: accentColorNotifier,
        builder: (context, accentColor, child) {
          return OverflowBox(
            alignment: Alignment.bottomRight,
            minWidth: 0,
            minHeight: 0,
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: Stack(
              alignment: Alignment.bottomRight,
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  bottom: showMenu ? 120 : 0,
                  right: 0,
                  curve: Curves.easeOut,
                  child: IgnorePointer(
                    ignoring: !showMenu,
                    child: AnimatedOpacity(
                      opacity: showMenu ? 1 : 0,
                      duration: const Duration(milliseconds: 150),
                      child: FloatingActionButton.large(
                        heroTag: 'fab-folder',
                        backgroundColor: accentColor,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: const Icon(
                          Icons.folder_copy_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: showMenu && widget.newItem ? 240 : 0,
                  right: 0,
                  curve: Curves.easeOut,
                  child: IgnorePointer(
                    ignoring: !showMenu,
                    child: AnimatedOpacity(
                      opacity: showMenu ? 1 : 0,
                      duration: const Duration(milliseconds: 150),
                      child: FloatingActionButton.large(
                        heroTag: 'fab-eye',
                        backgroundColor: accentColor,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton.large(
                  heroTag: 'fab-main',
                  shape: const CircleBorder(),
                  backgroundColor: showMenu ? Colors.grey[400] : accentColor,
                  onPressed: () => setState(() => showMenu = !showMenu),
                  child: AnimatedRotation(
                    turns: showMenu ? 0.125 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.add, size: 60, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
