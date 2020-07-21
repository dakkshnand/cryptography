import 'dart:typed_data';

import 'package:noise_protocol/src/destroyable.dart';

abstract class DHState extends Destroyable{
  String getDHName();

  int getPublicKeyName();

  int getSharedKeyLength();

  void generateKeyPair();

  void getPublicKey(Uint8List key, int offset);

  void setPublicKey(Uint8List key, int offset);

  void getPrivateKey(Uint8List key, int offset);

  void setPrivateKey(Uint8List key, int offset);

  void setToNullPublicKey();

  void clearKey();

  bool hasPublicKey();

  bool hasPrivateKey();

  bool isNullPublicKey();

  void calculate(Uint8List shareKey, int offset, DHState publicDH);

  void copyFrom(DHState other);

}