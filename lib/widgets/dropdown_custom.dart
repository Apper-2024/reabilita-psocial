import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final String? dropdownValue;
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButton({
    super.key,
    this.dropdownValue,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hint,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400, color: verde1),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: preto1, width: 1),
          ),
          height: 50,
          child: DropdownButton<String>(
            hint: Text(widget.hint),
            padding: const EdgeInsets.all(8),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            dropdownColor: Colors.white,
            value: _currentValue,
            isExpanded: true,
            underline: Container(),
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            items: widget.items.toSet().toList().map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
