import 'package:flutter/material.dart';

class CoffeeSearchBar extends StatelessWidget {
  const CoffeeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search...',
      onTap: () {},
      backgroundColor: WidgetStateProperty.all(
        Theme.of(context).colorScheme.onPrimary,
      ),
      side: WidgetStateProperty.all(
        BorderSide(
          color: Theme.of(context).colorScheme.primary,
          style: BorderStyle.solid,
        ),
      ),
      elevation: WidgetStateProperty.all(0),
      autoFocus: false,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: 50,
        minWidth: double.infinity,
        minHeight: 50,
      ),
      onSubmitted: (value) {},
      trailing: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
    );
  }
}
