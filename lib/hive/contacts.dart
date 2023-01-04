import 'package:hive/hive.dart';

part 'contacts.g.dart';

@HiveType(typeId: 0)
class Contacts {
  @HiveField(0)
  String name;

  @HiveField(1)
  String country;

  @HiveField(2)
  String number;

  Contacts({
    required this.name,
    required this.country,
    required this.number,
  });
}
