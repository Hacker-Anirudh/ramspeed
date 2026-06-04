class Math {
  static String toRAMSpeed(double MT, double bus, double channels) {
    String speed;
    double tempval = (MT * bus * channels) / 8;
    if (tempval < 1000) {
      speed = "$tempval MB/s";
      return speed;
    } else if (tempval < 1000000) {
      double rval = tempval / 1000;
      speed = "$rval GB/s";
      return speed;
    } else {
      double rval = tempval / 1000000;
      speed = "$rval TB/s";
      return speed;
    }
  }
}
