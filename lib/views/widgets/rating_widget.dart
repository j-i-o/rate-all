import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/rating.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({
    super.key,
    required this.rating,
    this.value,
    this.onChanged,
  });

  final RatingConfig rating;
  final double? value;
  final ValueChanged<double>? onChanged;

  //computada??
  bool get isEditable => onChanged != null;

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late double _currentValue;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value ?? 0;
  }

  @override
  void didUpdateWidget(covariant RatingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _currentValue = widget.value ?? 0;
    }
  }

  void _update(double value) {
    if (!widget.isEditable) return;
    setState(() => _currentValue = value);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.isEditable ? _currentValue : widget.value ?? 0;

    return Row(
      spacing: 0,
      mainAxisSize: MainAxisSize.min,
      children: switch (widget.rating.type) {
        RatingType.thumbs => [
          AnimatedRotation(
            turns: value > 0 ? 2 : 1,
            duration: const Duration(milliseconds: 600),
            child: IconButton(
              onPressed: widget.isEditable
                  ? () => _update(widget.value == 1 ? 0 : 1)
                  : null,
              icon: Icon(
                value > 0 ? Icons.thumb_up_rounded : Icons.thumb_down_rounded,
                color: value > 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
        RatingType.stars => List.generate(
          5,
          (index) => widget.isEditable
              ? IconButton(
                  onPressed: widget.isEditable
                      ? () => _update(index + 1)
                      : null,
                  icon: Icon(
                    Icons.star_rounded,
                    color: index < value ? Colors.amber : Colors.grey,
                  ),
                )
              : Icon(
                  Icons.star_rounded,
                  color: index < value ? Colors.amber : Colors.grey,
                ),
        ),
        RatingType.numeric => [
          if (widget.isEditable)
            SizedBox(
              width: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      onChanged: (value) => _update(double.tryParse(value) ?? 0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Calificación requerida';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Sólo números';
                        }
                        if (double.parse(value) > RatingConfig.numeric.max!.toDouble()) {
                          return 'Calificación inválida';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          Text(
            '${widget.isEditable ? '' : value}/10',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      },
    );
  }
}
