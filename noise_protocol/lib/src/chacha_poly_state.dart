import 'dart:typed_data';

import 'package:cryptography/src/secret_key.dart';
import 'package:noise_protocol/noise_protocol.dart';
import 'package:cryptography/cryptography.dart';

class ChaChaPolyState implements CipherState{
  CipherWithAppendedMac chacha20Poly1305Aead;
  List<int> input;
  List<int> output;
  Uint8List polyKey;
  int n;
  bool haskey;
  Nonce nonce;
  Uint8List block;
  List<int> h;
  List<int> r;
  List<int> c;
  List<int> t;
  int position;


  ChaChaPolyState(){
    chacha20Poly1305Aead = Chacha20Poly1305Aead(
      name: 'chacha20Poly1305Aead',
      cipher: chacha20,
    );

    nonce = chacha20Poly1305Aead.newNonce();
    block = Uint8List(16);
    h = List<int>(5);
    r = List<int>(5);
    c = List<int>(5);
    t = List<int>(10);
    position = 0;
    
    input = List<int>(16);
    output = List<int>(16);
    polyKey = Uint8List(16);
    n = 0;
    haskey = false;
  }

  void destroy(){
    var intReplacement = List<int>.generate(chacha20Poly1305Aead.nonceLength, (index) => 0);
    var replacement = Uint8List.fromList(intReplacement);
    nonce.bytes.replaceRange(0, chacha20Poly1305Aead.nonceLength, replacement);
    block.replaceRange(0, 16, replacement);
    h.replaceRange(0, 5, intReplacement);
    r.replaceRange(0, 5, intReplacement);
    c.replaceRange(0, 5, intReplacement);
    t.replaceRange(0, 10, intReplacement);
  }

  String getCipherName(){
    return chacha20Poly1305Aead.name;
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
  NoiseCipher get cipher => NoiseCipher.chachaPoly;


  @override
  // TODO: implement counter
  int get counter => n;

  @override
  Future<List<int>> decrypt(List<int> cipherText, {List<int> aad}) {
    // TODO: implement decrypt
    return ChaChaPolyState().decrypt(cipherText, aad: aad);
  }


  @override
  Future<List<int>> encrypt(List<int> cipherTex, {List<int> aad}) {
    // TODO: implement encrypt
    return ChaChaPolyState().encrypt(cipherTex, aad: aad);
  }

  @override
  // ignore: missing_return
  Future<void> rekey(SecretKey secretKey) async {
    var intZeros = List<int>.generate(32, (index) => 0);
    var zeros = Uint8List.fromList(intZeros);
    var zero_byte = Uint8List(0);
    var list = await cipher.implementation.encrypt(zeros, secretKey: secretKey,
        nonce: cipher.nonce(counter), aad: zero_byte);
    return list.getRange(0, 32);
  }

  @override
  // TODO: implement secretKey
  SecretKey get secretKey => chacha20Poly1305Aead.newSecretKeySync();


  @override
  void initialize(SecretKey secretKey) {
    // TODO: implement initialize
    secretKey = secretKey;
  }
}