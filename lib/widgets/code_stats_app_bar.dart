import 'package:flutter/material.dart';

class CodeStatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const CodeStatsAppBar({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text("Code::Stats"), primary: true, actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
