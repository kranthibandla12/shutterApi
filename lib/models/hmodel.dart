import 'package:hive/hive.dart';

part 'hmodel.g.dart';

@HiveType(typeId: 0)
class hmodel extends HiveObject {
  // @HiveField(1)
  // String hurls;
  @HiveField(2)
  String hurls;

  hmodel({required this.hurls});
}
