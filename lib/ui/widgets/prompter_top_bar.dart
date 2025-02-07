import 'package:flutter/material.dart';

class PrompterTopBar extends StatelessWidget {
  const PrompterTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).colorScheme.onSecondary.withAlpha(120),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Script name goes here',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
            ),
            IconButton(
              icon: Icon(Icons.close,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
