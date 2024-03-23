import 'package:encrypt/encrypt.dart';

class Cryptography {
  final key = "Your16CharacterK";
  final plainText = "lorem ipsum example example";
  String decrypt(String keyString, Encrypted encryptedData) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));

    return encrypter.decrypt(encryptedData, iv: initVector);
  }

  String decrypt64(String keyString, String encryptedData) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));

    return encrypter.decrypt64(encryptedData, iv: initVector);
  }

  List<int> decrypt32(String keyString, Encrypted encryptedData) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    return encrypter.decryptBytes(encryptedData, iv: initVector);
    //return encrypter.decrypt64(encryptedData, iv: initVector);
  }

  Encrypted encrypt(String keyString, String plainText) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);

    return encryptedData;
  }
}
