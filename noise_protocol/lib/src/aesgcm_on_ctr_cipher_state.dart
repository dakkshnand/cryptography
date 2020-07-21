import 'package:cryptography/src/secret_key.dart';
import 'package:noise_protocol/noise_protocol.dart';

class AESGCMOnCtrCipherState implements CipherState{
  AESGCMOnCtrCipherState();

  @override
  // TODO: implement cipher
  NoiseCipher get cipher => throw UnimplementedError();

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
  Future<void> rekey() {
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