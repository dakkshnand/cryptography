import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography/src/secret_key.dart';
import 'package:noise_protocol/noise_protocol.dart';
import 'package:noise_protocol/src/crypto/ghash.dart';

class AESGCMOnCtrCipherState implements CipherState{
  NoiseCipher aesCtr_cipher;
  SecretKey keySpec;
  int n;
  Uint8List iv;
  Uint8List hashKey;
  GHASH ghash;

  AESGCMOnCtrCipherState(){
    aesCtr_cipher = CipherWithAppendedMac(aesCtr, Hmac(sha512)) as NoiseCipher;
    keySpec = null;
    n = 0;
    iv = Uint8List(16);
    hashKey = Uint8List(16);
    ghash = GHASH();
  }

  @override
  // TODO: implement cipher
  NoiseCipher get cipher => NoiseCipher.aesGcm;

  @override
  // TODO: implement counter
  int get counter => throw UnimplementedError();

  @override
  Future<List<int>> decrypt(List<int> cipherText, {List<int> aad}) {
    // TODO: implement decrypt
    throw UnimplementedError();
  }

  @override
  Future<List<int>> encrypt(List<int> cipherTex, {List<int> aad}) {
    // TODO: implement encrypt
    throw UnimplementedError();
  }

  @override
  void initializeKey(List<int> cipherTex) {
    // TODO: implement initialize
  }

  @override
  Future<void> rekey(SecretKey secretKey) {
    // TODO: implement rekey
    throw UnimplementedError();
  }

  @override
  // TODO: implement secretKey
  SecretKey get secretKey => throw UnimplementedError();

  @override
  void initialize(SecretKey secretKey) {
    // TODO: implement initialize
  }
}