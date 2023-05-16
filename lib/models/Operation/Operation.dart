import 'package:hive/hive.dart';
import 'package:venons_automark/models/Item/Item.dart';

part 'Operation.g.dart';

@HiveType(typeId: 0)
class Operation {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int number;
  @HiveField(2)
  final int status;
  @HiveField(3)
  final Map<String, dynamic> warehouse;
  @HiveField(4)
  final Map<String, dynamic> client;
  @HiveField(5)
  final String comment;
  @HiveField(6)
  final List<Item> items;
  @HiveField(7)
  final String date;
  @HiveField(8)
  final bool success;

  Operation(this.id, this.number, this.status, this.warehouse, this.client,
      this.comment, this.items, this.date, this.success);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'status': status,
      'warehouse': warehouse,
      'client': client,
      'comment': comment,
      'items': items,
      'date': date,
      'success': success
    };
  }

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
        json['id'] as int,
        json['number'] as int,
        json['status'] as int,
        json['warehouse'] as Map<String, dynamic>,
        json['client'] as Map<String, dynamic>,
        json['comment'] as String,
        json['items'] as List<Item>,
        json['date'] as String,
        json['success'] as bool);
  }
}
