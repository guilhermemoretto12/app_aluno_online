import 'package:flutter/material.dart';

class WarningDetails extends StatelessWidget {
  const WarningDetails({Key? key}) : super(key: key);

  final String text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut luctus ex, sed sollicitudin diam. Mauris molestie ut urna ut tempor. Fusce vulputate egestas dui at pharetra. Aliquam ac sapien libero. Duis feugiat sollicitudin tellus et rutrum. Aliquam ut tempus risus. Aenean eget nunc a sapien maximus dictum sit amet auctor odio. Donec lorem mi, blandit sed bibendum at, vestibulum quis turpis. Nulla euismod nunc sit amet magna iaculis tincidunt. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus eget varius lacus. Maecenas eget suscipit odio, nec maximus nunc. Sed sit amet enim eget mauris tempor aliquet. Mauris tortor turpis, tincidunt quis rhoncus nec, pellentesque tempus sapien.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aviso institucional'),
      ),
      body: Column(children: [
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Título do aviso',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 16, left: 16, right: 16),
            child: Text(text, textAlign: TextAlign.justify))
      ]),
    );
  }
}
