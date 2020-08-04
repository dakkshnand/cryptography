import 'dart:typed_data';

import 'package:noise_protocol/src/destroyable.dart';

class GHASH implements Destroyable{
  List<int> H;
  Uint8List Y;
  int posn;

  GHASH(){
    H = List(2);
    Y = Uint8List(16);
    posn = 0;
  }
  void reset_new(Uint8List key, int offset){

  }

  void reset_retain(){

  }

  void update(Uint8List data, int offset, int length){

  }

  void finish(Uint8List tag, int offset, int length){

  }

  void pad(){

  }

  @override
  void destroy() {
    // TODO: implement destroy
  }

  int readBigEndian(Uint8List buf, int offset){

  }

  void writeBigEndian(Uint8List buf, int offset, int value){

  }

  void GF128_mul(Uint8List Y, List<int> H){

  }

}