import 'package:hive/hive.dart';

part 'newspaper_model.g.dart';

@HiveType(typeId: 0)
class NewspaperModel {
  @HiveField(0)
  final int page;
  @HiveField(1)
  final String dateTime;
  @HiveField(2)
  final String displayDate;
  NewspaperModel(this.page, this.dateTime, this.displayDate);
}
