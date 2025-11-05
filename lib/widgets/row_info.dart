import 'package:flutter/cupertino.dart';

class RowInfo extends StatelessWidget {
  const RowInfo(
      {super.key,
      required this.icon,
      required this.contact,
      required this.message,
      required this.mapKey});

  final Icon icon;
  final Map<String, String> contact;
  final String message;
  final String mapKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 20),
        icon,
        Text(
          '${message}= ${contact[mapKey]}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
