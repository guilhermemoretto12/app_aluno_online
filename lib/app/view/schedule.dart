import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _TestState();
}

class _TestState extends State<Schedule> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/files').listAll();
  }

  @override
  Widget build(BuildContext context) {
    void navigate(String path) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(path);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horário de aula'),
      ),
      body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final files = snapshot.data!.items;

              return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    return ListTile(
                      title: Text(file.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.file_open),
                        color: Colors.black,
                        onPressed: () => {},
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(child: Text('Erro ao obter'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
