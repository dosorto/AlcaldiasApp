class Data {
  int code;
  var data;
  String message;
  Data({required this.message, required this.code, required this.data});
  @override
  String toString() {
    // TODO: implement toString
    return "COD: " +
        this.code.toString() +
        " MSG: " +
        this.message +
        " DATA:" +
        this.data.toString();
  }
}
