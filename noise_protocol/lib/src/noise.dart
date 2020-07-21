import 'dart:math';
import 'dart:typed_data';

import 'package:noise_protocol/src/curve_25519_dh_state.dart';
import 'package:pointycastle/export.dart';
import '../noise_protocol.dart';
import 'aesgcm_fallback_cipher_state.dart';
import 'aesgcm_on_ctr_cipher_state.dart';
import 'chacha_poly_state.dart';
import 'dh_state.dart';

class Noise{
  static int MAX_PACKET_LEN = 65535;
  static FortunaRandom random = FortunaRandom();

  static void rand(Uint8List data){
    data = random.nextBytes(data.length);
  }

  static bool forceFallbacks = false;

  static DHState createDH(String name){
    try{
      if (name == '25519') {
        return Curve25519DHState();
      }
    } on FormatException{
      print('Unknown Noise DH state algorithm name:' + name);
    }
  }

  static CipherState createCipher(String name){
    if(name == 'AESGCM'){
      if (forceFallbacks){
        return AESGCMFallbackCipherState();
      }
      try{
        return AESGCMOnCtrCipherState();
      } on FormatException{
        return AESGCMFallbackCipherState();
      }
    } else if (name == 'ChaChaPoly'){
      return ChaChaPolyState();
    }
  }

  static destroy(Uint8List array){
    array.fillRange(0, array.length, 0);
  }
}