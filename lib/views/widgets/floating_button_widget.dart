import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/accent_color_provider.dart';
import 'package:flutter_application_1/views/pages/new_category.dart';
import 'package:flutter_application_1/views/pages/new_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatingButtonWidget extends ConsumerStatefulWidget {
  const FloatingButtonWidget({super.key, required this.newItem});

  final bool newItem;

  @override
  ConsumerState createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends ConsumerState<FloatingButtonWidget> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    final accentColor = ref.watch(accentColorProvider);

    return TapRegion(
      onTapOutside: (event) => setState(() => showMenu = false),
      child: OverflowBox(
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
              duration: const Duration(milliseconds: 150),
              bottom: showMenu && widget.newItem ? 120 : 0,
              right: 0,
              curve: Curves.easeOut,
              child: IgnorePointer(
                ignoring: !showMenu,
                child: AnimatedOpacity(
                  opacity: showMenu ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: FloatingActionButton.large(
                    heroTag: null,
                    backgroundColor: accentColor,
                    shape: CircleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewItem()),
                      );
                      setState(() => showMenu = !showMenu);
                    },
                    child: const Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: !showMenu,
              child: AnimatedRotation(
                turns: showMenu ? 0 : -0.125,
                duration: const Duration(milliseconds: 150),
                child: AnimatedOpacity(
                  opacity: showMenu ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: FloatingActionButton.large(
                    heroTag: null,
                    backgroundColor: accentColor,
                    shape: CircleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewCategory()),
                      );
                      setState(() => showMenu = !showMenu);
                    },
                    child: const Icon(
                      Icons.folder_copy_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: showMenu,
              child: AnimatedRotation(
                turns: showMenu ? 0.125 : 0,
                duration: const Duration(milliseconds: 200),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: showMenu ? 0 : 1,
                  child: FloatingActionButton.large(
                    heroTag: 'fab-main',
                    shape: const CircleBorder(),
                    backgroundColor: accentColor,
                    onPressed: () => setState(() => showMenu = !showMenu),
                    child: const Icon(Icons.add, size: 60, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
