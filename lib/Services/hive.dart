//Сервис для сохранение данных в кэш
import 'package:hive/hive.dart';


class HiveService{
  isExists({String? boxName}) async {
    final openBox = await Hive.openBox(boxName!);
    int length = openBox.length;
    return length != 0;
  }

  addBoxes<T>(List<T> items, String boxName) async {
    print("adding boxes");
    final openBox = await Hive.openBox(boxName);

    for (var item in items) {
      openBox.add(item);
    }
  }

  getListBoxes<T>(String? boxName) async {
    List<T>?boxList = [];

    final openBox = await Hive.openBox(boxName!);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }
  addObjectOnBoxes(dynamic object, String boxName) async {
    print("add object on box");
    final openBox = await Hive.openBox(boxName);

    openBox.add(object);

  }
  GetObjectBox (String boxName) async {
    dynamic object;

    final openBox = await Hive.openBox(boxName);

    object = openBox.get(boxName);

    return object;

  }
}