import 'package:flutter/material.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.filter_list),
          title: const Text('Filter List'),
          subtitle: const Text('Hide and show items'),
          trailing: Switch(
            value: true,
            onChanged: (val) {},
          ),
        ),
        const ListTile(
          leading: Icon(Icons.image_aspect_ratio),
          title: Text('Size Settings'),
          subtitle: Text('Change size of images'),
        ),
        ListTile(
          title: Slider(
            value: 0.5,
            onChanged: (val) {},
          ),
        ),
        ListTile(
          leading: const Icon(Icons.sort_by_alpha),
          title: const Text('Sort List'),
          subtitle: const Text('Change layout behavior'),
          trailing: Switch(
            value: false,
            onChanged: (val) {},
          ),
        ),
      ],
    );
  }
}
