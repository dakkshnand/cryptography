class RijndaelAES{
  List<int> rk;
  int Nr;

  RijndaelAES(){
    rk = List<int>(60);
    Nr = 14;
  }

  void destroy(){
    rk.fillRange(0, rk.length, 0);
  }
}