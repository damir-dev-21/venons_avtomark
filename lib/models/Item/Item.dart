import 'package:hive/hive.dart';

part 'Item.g.dart';

@HiveType(typeId: 1)
class Item {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String gtin;
  @HiveField(2)
  String name;
  @HiveField(3)
  int announce;
  @HiveField(4)
  int scanned;

  Item(this.id, this.gtin, this.name, this.announce, this.scanned);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gtin': gtin,
      'name': name,
      'announce': announce,
      'scanned': scanned
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        json['id'] as int,
        json['gtin'] as String,
        json['name'] as String,
        json['announce'] as int,
        json['scanned'] as int);
  }
}
