import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../api/pdf_api.dart';
import 'pdf_viewer.dart';

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
        title: const Text('Horários'),
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
                    var fileName = file.name;
                    return ListTile(
                      title: Text(file.name),
                      onTap: () async {
                        var url = '/files/$fileName';
                        final file = await PDFApi.loadFirebase(url);

                        if (file == null) return;
                        openPDF(context, file);
                      },
                      trailing: const Icon(Icons.file_open, color: Colors.black),
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

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewer(file: file)),
      );
}
