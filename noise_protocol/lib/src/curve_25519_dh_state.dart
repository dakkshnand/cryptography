import 'dart:ffi';
import 'dart:html';
import 'dart:typed_data';

import 'package:noise_protocol/src/dh_state.dart';
import 'package:noise_protocol/src/crypto/curve_25519.dart';

import 'noise.dart';

class Curve25519DHState implements DHState{
  Uint8List publicKey;
  Uint8List privateKey;
  int mode;

  Curve25519DHState(){
    publicKey = Uint8List(32);
    privateKey = Uint8List(32);
    mode = 0;
  }

  void destroy(){
    clearKey();
  }

  String getDHName(){
    return '22519';
  }

  int getPublicKeyLength(){
    return 32;
  }

  int getPrivateKeyLength(){
    return 32;
  }

  int getSharedKeyLength(){
    return 32;
  }

  void generateKeyPair(){
    Noise.rand(privateKey);
    Curve25519.eval(publicKey, 0, privateKey, null);
    mode = 0x03;
  }

  @override
  void calculate(Uint8List sharedKey, int offset, DHState publicDH) {
    // TODO: implement calculate
      if(!(publicDH is Curve25519DHState)) {
        FormatException('Incomptabile DH algorithms');
      }else {
        var publicDH = Curve25519DHState();
        Curve25519.eval(sharedKey, offset, privateKey, publicDH.publicKey);
      }
  }

  @override
  void clearKey() {
    // TODO: implement clearKey
    Noise.destroy(publicKey);
    Noise.destroy(privateKey);
  }

  @override
  void copyFrom(DHState other) {
    // TODO: implement copyFrom
    if (!(other is Curve25519DHState)){
      FormatException('Mismatched DH key objects');
    } else if (other == this){
      return;
    } else{
      var other = Curve25519DHState();
      Curve25519DHState dh = other;
      privateKey.replaceRange(0, 32, dh.privateKey);
      publicKey.replaceRange(0, 32, dh.publicKey);
    }
  }

  @override
  void getPrivateKey(Uint8List key, int offset) {
    // TODO: implement getPrivateKey
    key.replaceRange(offset, offset+32, privateKey);
  }

  @override
  void getPublicKey(Uint8List key, int offset) {
    // TODO: implement getPublicKey
    key.replaceRange(offset, offset+32, publicKey);
}

  @override
  int getPublicKeyName() {
    // TODO: implement getPublicKeyName
    throw UnimplementedError();
  }

  @override
  bool hasPrivateKey() {
    // TODO: implement hasPrivateKey
    return (mode & 0x02) != 0;
  }

  @override
  bool hasPublicKey() {
    // TODO: implement hasPublicKey
    return (mode & 0x01) != 0;
  }

  @override
  bool isNullPublicKey() {
    // TODO: implement isNullPublicKey
    if((mode & 0x01) == 0){
      return false;
    }
    var temp = 0;
    for(var index = 0; index < 32; index++) {
      temp |= publicKey.elementAt(index);
    }
    return temp == 0;
  }

  @override
  void setPrivateKey(Uint8List key, int offset) {
    // TODO: implement setPrivateKey
    privateKey.replaceRange(0, 32, key.getRange(offset, offset+32));
    Curve25519.eval(publicKey, 0, privateKey, null);
    mode = 0x03;
  }

  @override
  void setPublicKey(Uint8List key, int offset) {
    // TODO: implement setPublicKey
    publicKey.replaceRange(0, 32, key.getRange(offset, offset+32));
    var zero = List<int>.generate(privateKey.length, (index) => 0);
    privateKey.replaceRange(0, privateKey.length, Uint8List.fromList(zero));
  }

  @override
  void setToNullPublicKey() {
    // TODO: implement setToNullPublicKey
    var zeroPriv = List<int>.generate(privateKey.length, (index) => 0);
    var zeroPub = List<int>.generate(publicKey.length, (index) => 0);
    privateKey.replaceRange(0, privateKey.length, Uint8List.fromList(zeroPriv));
    publicKey.replaceRange(0, publicKey.length, Uint8List.fromList(zeroPub));
  }


}