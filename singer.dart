class Singer {
  String name;
  String url;
  Singer({required this.name, required this.url});

  static Singer fromJSON(Map<String, dynamic> map) {
    return Singer(name: map['name'], url: map['photo']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Name $name URL $url";
  }
}
