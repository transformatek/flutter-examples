import 'package:flutter/material.dart';

class OrsTestPage extends StatefulWidget {
  const OrsTestPage({Key? key}) : super(key: key);

  @override
  State<OrsTestPage> createState() => _OrsTestPageState();
}

class _OrsTestPageState extends State<OrsTestPage> {
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Text('Calculate Duration', style: TextStyle(color: Colors.black)),
            Text('  Ors', style: TextStyle(color: Colors.grey)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Container()),
    );
  }
}
