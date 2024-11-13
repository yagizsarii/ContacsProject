import 'package:hive_flutter/hive_flutter.dart';

class AppStorage {
  static final Box localBox = Hive.box("contactsBox");
  static List contactList = [];

  static Future<void> appStorageInitilize() async {
    await Hive.initFlutter();
    await Hive.openBox("contactsBox");
    initializeList();
  }

  static void initializeList() {
    contactList = getList();
  }

  static void addData(String contactName, String contactPhone) {
    contactList.add([contactName, contactPhone]);
    localBox.put("contacts", contactList);
  }

  static void deleteData(int index) {
    contactList.removeAt(index);
    localBox.put("contacts", contactList);
  }

  static List getList() {
    contactList =
        localBox.get('contacts', defaultValue: []); // Hive'dan veriyi alıyoruz
    return contactList;
  }
}
