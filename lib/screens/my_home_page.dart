import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totp/totp.dart';
import 'package:totp_generator/controller/cryptography.dart';
import 'package:totp_generator/model/passwordModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String key = "Your16CharacterK";
  String plainText = "lorem ipsum example example";
  String? password;
  late String totp_value;
  Cryptography crypto = Cryptography();
  final Future<SharedPreferences> _prep = SharedPreferences.getInstance();
  TextEditingController _secretKey = TextEditingController();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> readCount() async {
    final path = await _localPath;
    print("${path} hai ");
    final f = File('$path/password.txt');
    return f.writeAsString('kooi');
  }

  Future<String> read(String filename) async {
    final path = await _localPath;

    final f = File('$path/$filename');

    final content = await f.readAsString();
    print(content);
    return content;
  }

  @override
  void initState() {
    // read("password.txt");
    // decry(key);
    // _prep.then((value) {
    //   String a = value.getString('decrypt') ?? 'null';
    //   print(a);
    //   return a;
    // });
    // print(_prep);
    test();
    // pass decrypted secret to totps package
    super.initState();
  }

  test() async {
    String key = "Your16CharacterK";
    var str = "hello halid";
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    // encrypt string
    Cryptography _crypto = Cryptography();
    var encrypted_str64 = _crypto.encrypt(key, str).base64;

    // store encrypted string to shared prefs
    await prefs.setString('test', encrypted_str64);

    // read str from shared prefs
    var stored_str64 = prefs.getString('test') ?? 'null';

    // decrypt str
    var decrypted_str = _crypto.decrypt64(key, stored_str64);

    print(decrypted_str);
    final totp = Totp(secret: '12345678901234567890'.codeUnits);
    final value = totp.now();
    setState(() {
      password = value;
    });
  }

  AlertDialog _alertDialog() {
    return AlertDialog(
      title: Text('ALert'),
      content: TextFormField(
          controller: _secretKey,
          decoration: InputDecoration(hintText: "Enter the secret key")),
      actions: [
        TextButton(
            onPressed: () {
              final totp = Totp(secret: _secretKey.text.codeUnits);
              totp_value = totp.now();
              items.add(totp_value);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: Text('Enter')),
      ],
    );
  }

  @override
  void dispose() {
    _secretKey.dispose();
    super.dispose();
  }

  List<String> items = ['hai', "kooi"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Password Genartor")),
        backgroundColor: Colors.amberAccent,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.password_rounded),
                    title: Text(items[index]),
                  );
                }),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: SizedBox(
                      height: 50,
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _alertDialog();
                              });
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
