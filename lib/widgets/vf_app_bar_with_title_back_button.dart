import 'package:flutter/material.dart';

class VfAppBarWithTitleBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showSearchIcon;
  final bool showFilterIcon;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onFilterPressed;
  final VoidCallback? onBackPressed;

  const VfAppBarWithTitleBackButton({
    Key? key,
    required this.title,
    this.showSearchIcon = true,
    this.showFilterIcon = true,
    this.onSearchPressed,
    this.onFilterPressed,
    this.onBackPressed, // Added onBackPressed callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBackPressed ??
            () {
              Navigator.of(context).pop(); // Default behavior if not provided
            },
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0XFF0070BB),
      centerTitle: true,
      elevation: 4.0,
      actions: [
        if (showSearchIcon)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: onSearchPressed ?? () {},
          ),
        if (showFilterIcon)
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: onFilterPressed ?? () {},
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
