import 'package:isar/isar.dart';

// Generate file by running `dart run build_runner build`
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
