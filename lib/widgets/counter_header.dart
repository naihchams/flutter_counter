import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CounterHeader extends StatelessWidget {
  final String title;

  const CounterHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 75,
      backgroundColor: Color.fromRGBO(117, 93, 236, 1),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      leading: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/images/restore.svg',
            semanticsLabel: 'Restore',
            color: Colors.white,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings_outlined, size: 25),
        ),
      ],
    );
  }
}
