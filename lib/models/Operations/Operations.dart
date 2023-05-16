import 'package:hive/hive.dart';
import 'package:venons_automark/models/Item/Item.dart';

import '../Operation/Operation.dart';

part 'Operations.g.dart';

@HiveType(typeId: 3)
class Operations {
  @HiveField(0)
  late List<Operation> operations;

  Operations(this.operations);
}
