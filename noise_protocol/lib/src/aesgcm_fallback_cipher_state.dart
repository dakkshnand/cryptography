import 'dart:typed_data';

import 'package:cryptography/src/secret_key.dart';
import 'package:noise_protocol/noise_protocol.dart';
import 'package:noise_protocol/src/crypto/ghash.dart';
import 'package:noise_protocol/src/crypto/rijndael_aes.dart';

import 'noise.dart';

class AESGCMFallbackCipherState implements CipherState{
  RijndaelAES aes;
  int n;
  Uint8List iv;
  Uint8List enciv;
  Uint8List hashKey;
  GHASH ghash;
  bool haskey;

  AESGCMFallbackCipherState(){
    aes = RijndaelAES();
    n = 0;
    iv = Uint8List(16);
    enciv = Uint8List(16);
    hashKey = Uint8List(16);
    ghash = GHASH();
    haskey = false;
  }

  void destroy(){
    aes.destroy();
    ghash.destroy();
    Noise.destroy(hashKey);
    Noise.destroy(iv);
    Noise.destroy(enciv);
  }

  String getCipherName(){
    return 'AESGCM';
  }

  int getKeyLength(){
    return 32;
  }

  int getMACLength(){
    return haskey ? 16 : 0;
  }

  bool hasKey(){
    return haskey;
  }

  @override
  // TODO: implement cipher
  NoiseCipher get cipher => NoiseCipher.aesGcm;

  @override
  // TODO: implement counter
  int get counter => n;

  @override
  Future<List<int>> decrypt(List<int> cipherText, {List<int> aad}) {
    // TODO: implement decrypt
    return cipher.implementation.decrypt(cipherText, secretKey: secretKey, nonce: cipher.nonce(counter), aad: aad);
  }

  @override
  Future<List<int>> encrypt(List<int> cipherTex, {List<int> aad}) {
    // TODO: implement encrypt
    return cipher.implementation.encrypt(cipherTex, secretKey: secretKey, nonce: cipher.nonce(counter), aad: aad);
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
  SecretKey get secretKey => throw UnimplementedError();

  @override
  void initialize(SecretKey secretKey) {
    // TODO: implement initialize
    secretKey = secretKey;
  }

  CipherState fork(Uint8List key, int offset){
    CipherState cipher;
    cipher = AESGCMFallbackCipherState();
    cipher.initialize(secretKey);
    return cipher;
  }

  void setNonce(int nonce){
    n = nonce;
  }

}