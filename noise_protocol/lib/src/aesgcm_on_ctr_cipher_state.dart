import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography/src/secret_key.dart';
import 'package:noise_protocol/noise_protocol.dart';
import 'package:noise_protocol/src/crypto/ghash.dart';
import 'package:noise_protocol/src/noise.dart';

class AESGCMOnCtrCipherState implements CipherState{
  CipherWithAppendedMac aesCtr_cipher;
  SecretKey keySpec;
  int n;
  Uint8List iv;
  Uint8List hashKey;
  GHASH ghash;

  AESGCMOnCtrCipherState(){
    aesCtr_cipher = CipherWithAppendedMac(aesCtr, Hmac(sha512));
    keySpec = null;
    n = 0;
    iv = Uint8List(16);
    hashKey = Uint8List(16);
    ghash = GHASH();

    var spec = SecretKey(Uint8List(32));

  }

  @override
  // TODO: implement cipher
  NoiseCipher get cipher => NoiseCipher.aesGcm;

  @override
  // TODO: implement counter
  int get counter => n;

  void destroy(){
    ghash.destroy();
    Noise.destroy(hashKey);
    Noise.destroy(iv);
    keySpec = new SecretKey(Uint8List(32));
  }

  String getCipherName(){
    return 'AESGCM';
  }

  int getKeyLength(){
    return 32;
  }

  int getMACLength(){
    return keySpec != null ? 16 : 0;
  }

  bool hasKey(){
    return keySpec != null;
  }

  void setNonce(int nonce){
    n = nonce;
  }

  @override
  Future<List<int>> decrypt(List<int> cipherText, {List<int> aad}) {
    // TODO: implement decrypt
    return aesCtr_cipher.decrypt(cipherText, secretKey: secretKey, nonce: cipher.nonce(counter), aad: aad);
  }

  @override
  Future<List<int>> encrypt(List<int> cipherTex, {List<int> aad}) {
    // TODO: implement encrypt
    return aesCtr_cipher.encrypt(cipherTex, secretKey: secretKey, nonce: cipher.nonce(counter), aad: aad);
  }

  @override
  Future<void> rekey(SecretKey secretKey) async {
    // TODO: implement rekey
    var intZeros = List<int>.generate(32, (index) => 0);
    var zeros = Uint8List.fromList(intZeros);
    var zero_byte = Uint8List(0);
    var list = await cipher.implementation.encrypt(zeros, secretKey: secretKey,
        nonce: cipher.nonce(counter), aad: zero_byte);
    return list.getRange(0, 32);
  }

  @override
  // TODO: implement secretKey
  SecretKey get secretKey => aesCtr_cipher.newSecretKeySync();

  @override
  void initialize(SecretKey secretKey) {
    // TODO: implement initialize
    secretKey = secretKey;
  }

  CipherState fork(Uint8List key, int offset){
    CipherState cipher;
    cipher = AESGCMOnCtrCipherState();
    cipher.initialize(secretKey);
    return cipher;
  }
}