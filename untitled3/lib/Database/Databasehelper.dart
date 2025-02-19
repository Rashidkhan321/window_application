
import 'dart:math';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Databasehelper{
  static final Databasehelper instance = Databasehelper._init();
  static Database? _database;
  factory Databasehelper()=>instance;
  Databasehelper._init();
  // seraching for database
Future<Database?> get database async{
  if(_database!=null) return _database;
  _database =await createdatabase('raweaaatawereuedaawa.db');
  return _database;
}
Future<Database> createdatabase(String  filepath)async{
  final dbpath = await getDatabasesPath();
  final path = await join(dbpath, filepath);
  
  return await openDatabase(path, version: 2, onUpgrade: OncreateDB);
  
  
}
 Future OncreateDB(Database db , int version, int oldversion) async{
   await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            solar_name TEXT NOT NULL,
            solar_quantity INTEGER NOT NULL,
            solar_price INTEGER NOT NULL,
            batory_name TEXT NOT NULL,
            batory_quantity INTEGER NOT NULL,
            bactory_price INTEGER NOT NULL,
            inverter_type TEXT NOT NULL,
            inverter_price INTEGER NOT NULL,
            buyer_name TEXT NOT NULL,
            salesman_name TEXT NOT NULL,
            total_solarprice INTEGER NOT NULL,
            total_price INTEGER NOT NULL,
            date TEXT NOT NULL,
            invertquantity INTEGER NOT NULL,
            othername TEXT NOT NULL,
            otherquantity INTEGER NOT NULL,
            otherprice INTEGER NOT NULL,
            total_battery_price INTEGER NOT NULL,
            total_invertprice INTEGER NOT NULL,
            total_otherprice INTEGER NOT NULL
          )
        ''');
   //
   //             tottalinvertprice INTEGER NOT NULL,
   await db.execute('''
      CREATE TABLE solar (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price INTEGER NOT NULL
      )
    ''');

   await db.execute('''
      CREATE TABLE inverte (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price INTEGER NOT NULL
        
       
      )
    ''');

   await db.execute('''
      CREATE TABLE batteries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price INTEGER NOT NULL
      )
    ''');

   await db.execute('''
      CREATE TABLE other (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price INTEGER NOT NULL
      )
    ''');
   await db.execute('''
      CREATE TABLE solarquantity (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total_price INTEGER NOT NULL,
        number INTEGER NOT NULL,
        stock INTEGER NOT NULL,
        sold INTEGER NOT NULL
       )
    ''');
   await db.execute('''
      CREATE TABLE invertrquantity (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total_price INTEGER NOT NULL,
        number INTEGER NOT NULL,
        stock INTEGER NOT NULL,
        sold INTEGER NOT NULL
       )
    ''');

   await db.execute('''
      CREATE TABLE bateryquantity (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total_price INTEGER NOT NULL,
        number INTEGER NOT NULL,
        stock INTEGER NOT NULL,
        sold INTEGER NOT NULL
       )
    ''');
   await db.execute('''
      CREATE TABLE otherquantity (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total_price INTEGER NOT NULL,
        number INTEGER NOT NULL,
        stock INTEGER NOT NULL,
        sold INTEGER NOT NULL
       )
    ''');
   await db.execute('''
      CREATE TABLE stack (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
         solar INTEGER NOT NULL,
         inverter INTEGER NOT NULL,
         battery INTEGER NOT NULL,
         other INTEGER NOT NULL
       )
    ''');
 }

  Future incrementsolarstachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET solar = solar + ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  Future incrementbatterystachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET battery = battery + ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  Future incrementinverterstachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET inverter = inverter + ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  Future incrementotherstachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET other = other + ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  //decrement values
  Future decrementsolarstachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET solar = solar - ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  Future decrementbatterystachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET battery = battery - ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  Future decrementinverterstachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET inverter = inverter - ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  Future decrementotherstachupdate(final int incrementNumber) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE stack SET other = other - ? WHERE id = ?',
      [incrementNumber, 1],  // Replace 1 with the actual row ID if needed
    );
    print('add tosolar  '+incrementNumber.toString());
  }
  // Check if invertrquantity table is empty
  Future<void> stactDefaultIfNeeded() async {
    final db = await database;

    // Check if the table is empty
    var result = await db?.rawQuery("SELECT COUNT(*) FROM stack");

    if (result != null && result.isNotEmpty && result[0]['COUNT(*)'] == 0) {
      // Insert default values if no rows exist
      await db?.insert(
        'stack',
        {'solar':0,'inverter':0, 'battery':0, 'other':0}, // Initial values
      );
    }
  }
  Future<List<Map<String, dynamic>>?> stac()async{
  final db = await database;
  final data = await db?.query('stack');
  return data;
  }
 // total number of solar
  Future<void> insertsolarQuantity() async {
    final db = await database;
    await db?.insert('solarquantity', {
      'total_price': 0,
      'number': 0,
    });
  }
 // tottal number of invertters
  Future<void> insertInverterQuantity() async {
    final db = await database;
    await db?.insert('invertrquantity', {
      'total_price': 0,
      'number': 0,
    });
  }
//total number of batroires
  Future<void> insertBatteryQuantity() async {
    final db = await database;
    await db?.insert('bateryquantity', {
      'total_price': 0,
      'number': 0,
    });
  }
// total number of other equipments
  Future<void> insertOtherQuantity() async {
    final db = await database;
    await db?.insert('otherquantity', {
      'total_price': 0,
      'number': 0,
    });
  }
  // add solar data
  Future updatedSolarQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE solarquantity SET number = number - ?, stock = stock + ?, sold = sold + ?  WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  //add battery data
  Future updatedbatteryQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE bateryquantity SET number = number - ?, stock = stock + ?, sold = sold + ? WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  // add invertrs data
  Future updatedinvertrQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE invertrquantity SET number = number - ?, stock = stock + ?, sold = sold + ? WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  // add other equipments data
  Future updatedotherQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE otherquantity SET number = number - ?, stock = stock + ?, sold = sold + ? WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }


  // update solar data
  Future updateSolarQuantity(final int incrementNumber, final int incrementPrice) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE solarquantity SET number = number + ?, total_price = total_price + ? WHERE id = ?',
      [incrementNumber, incrementPrice, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  //update battery data
  Future updatebatteryQuantity(final int incrementNumber, final int incrementPrice) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE bateryquantity SET number = number + ?, total_price = total_price + ? WHERE id = ?',
      [incrementNumber, incrementPrice, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  // update invertrs data
  Future updateinvertrQuantity(final int incrementNumber, final int incrementPrice) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE invertrquantity SET number = number + ?, total_price = total_price + ? WHERE id = ?',
      [incrementNumber, incrementPrice, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  // update other equipments data
  Future updateotherQuantity(final int incrementNumber, final int incrementPrice) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE otherquantity SET number = number + ?, total_price = total_price + ? WHERE id = ?',
      [incrementNumber, incrementPrice, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }

  Future<List<Map<String, dynamic>>?> getInverterQuantity() async {
    final db = await database;
    final data =await db?.query('invertrquantity');
    return data!;
  }

  Future<List<Map<String, dynamic>>?> getBatteryQuantity() async {
    final db = await database;
     final data = await db?.query('bateryquantity');
    return data!;
  }

  Future<List<Map<String, dynamic>>?> getOtherQuantity() async {
    final db = await database;
    final data = await db?.query('otherquantity');
    return data!;
  }
  Future<List<Map<String, dynamic>>?> getsolarqunantiy() async {
    final db = await database;
    final data = await db?.query('solarquantity');
    return data!;
  }



  Future insertdata(
       String solarName,
       int solarQuantity,
       int solarPrice,
       String batoryName,
       int batoryQuantity,
       int bactoryPrice,
       String inverterType,
       int inverterPrice,
       String buyerName,
       String salesmanName,
       String date,
       int invertqunatity,
       String othername,
       int otherquntity,
       int otherprice

       ) async{
     int total_solr_price = solarQuantity * solarPrice;
     int total_battery_price = batoryQuantity * bactoryPrice;
     int total_invert_price = invertqunatity * inverterPrice;
     int total_other_price = otherquntity * otherprice;
     int   totalPrice = total_solr_price + total_other_price + total_invert_price + total_battery_price;

  final db = await database;
  db?.insert('notes',  {
    'solar_name': solarName,
    'solar_quantity': solarQuantity,
    'solar_price': solarPrice,
    'batory_name': batoryName,
    'batory_quantity': batoryQuantity,
    'bactory_price': bactoryPrice,
    'inverter_type': inverterType,
    'inverter_price': inverterPrice,
    'buyer_name': buyerName,
    'salesman_name': salesmanName,
    'total_solarprice': total_solr_price,
    'total_price': totalPrice,
    'date':date,
    'invertquantity':invertqunatity ,
    'othername' : othername,
    'otherquantity': otherquntity,
    'otherprice' :otherprice,
    'total_battery_price': total_battery_price,
    'total_invertprice': total_invert_price,
    'total_otherprice' : total_other_price




  });
  }
  //update the data
  Future updatadta(
      int id,
      String solarName,
      int solarQuantity,
      int solarPrice,
      String batoryName,
      int batoryQuantity,
      int bactoryPrice,
      String inverterType,
      int inverterPrice,
      String buyerName,
      String salesmanName,
      String date,
      int invertqunatity,
      String othername,
      int otherquntity,
      int otherprice

      ) async{
    int total_solr_price = solarQuantity * solarPrice;
    int total_battery_price = batoryQuantity * bactoryPrice;
    int total_invert_price = invertqunatity * inverterPrice;
    int total_other_price = otherquntity * otherprice;
    int   totalPrice = total_solr_price + total_other_price + total_invert_price + total_battery_price;

    final db = await database;
    db?.update('notes',  {
      'solar_name': solarName,
      'solar_quantity': solarQuantity,
      'solar_price': solarPrice,
      'batory_name': batoryName,
      'batory_quantity': batoryQuantity,
      'bactory_price': bactoryPrice,
      'inverter_type': inverterType,
      'inverter_price': inverterPrice,
      'buyer_name': buyerName,
      'salesman_name': salesmanName,
      'total_solarprice': total_solr_price,
      'total_price': totalPrice,
      'date':date,
      'invertquantity':invertqunatity ,
      'othername' : othername,
      'otherquantity': otherquntity,
      'otherprice' :otherprice,
      'total_battery_price': total_battery_price,
      'total_invertprice': total_invert_price,
      'total_otherprice' : total_other_price





    },
    where: 'id=?',
    whereArgs: [id]);
  }
  // to delete the data
  Future removedata(int id) async{
  final db =await database;
  db?.delete('notes',where: 'id=?',whereArgs: [id]);
  }
  // to retrive the data
Future<List<Map<String, dynamic>>?> billdata()async{
  final db = await database;
  final data = await db?.query('notes');
  return data;
}
  Future<int> insertSolar(String name, int quantity, int price) async {
    final db = await database;
    return await db!.insert('solar', {
      'name': name,
      'quantity': quantity,
      'price': price,
    });
  }

  Future insertInverter(String name, int quantity, int price) async {
    final db = await database;
    return await db?.insert('inverte', {
      'name': name,
      'quantity': quantity,
      'price': price,
    });
  }

  Future<int> insertBattery(String name, int quantity, int price) async {
    final db = await database;
    return await db!.insert('batteries', {
      'name': name,
      'quantity': quantity,
      'price': price,
    });
  }

  Future<int> insertOther(String name, int quantity, int price) async {
    final db = await database;
    return await db!.insert('other', {
      'name': name,
      'quantity': quantity,
      'price': price,
    });
  }


  Future<List<Map<String, dynamic>>?> getSolarData() async {
    final db = await database;
    final data =await db?.query('solar');
    return data;
  }

  Future<List<Map<String, dynamic>>?> getInverterData() async {
    final db = await database;
    final data =await db?.query('inverte');
    return data;
  }

  Future<List<Map<String, dynamic>>> getBatteryData() async {
    final db = await database;
    return await db!.query('batteries');
  }

  Future<List<Map<String, dynamic>>> getOtherData() async {
    final db = await database;
    return await db!.query('other');
  }
  // Check if solarquantity table is empty
  Future<void> insertsolarDefaultIfNeeded() async {
    final db = await database;

    // Check if the table is empty
    var result = await db?.rawQuery("SELECT COUNT(*) FROM solarquantity");

    if (result != null && result.isNotEmpty && result[0]['COUNT(*)'] == 0) {
      // Insert default values if no rows exist
      await db?.insert(
        'solarquantity',
        {'total_price': 0, 'number': 0,'stock': 0, 'sold': 0}, // Initial values
      );
    }
  }
  // Check if invertrquantity table is empty
  Future<void> insertinvertDefaultIfNeeded() async {
    final db = await database;

    // Check if the table is empty
    var result = await db?.rawQuery("SELECT COUNT(*) FROM invertrquantity");

    if (result != null && result.isNotEmpty && result[0]['COUNT(*)'] == 0) {
      // Insert default values if no rows exist
      await db?.insert(
        'invertrquantity',
        {'total_price': 0, 'number': 0,'stock': 0, 'sold': 0}, // Initial values
      );
    }
  }
  // Check if batteryquantity table is empty
  Future<void> insertbattoryDefaultIfNeeded() async {
    final db = await database;

    // Check if the table is empty
    var result = await db?.rawQuery("SELECT COUNT(*) FROM  bateryquantity");

    if (result != null && result.isNotEmpty && result[0]['COUNT(*)'] == 0) {
      // Insert default values if no rows exist
      await db?.insert(
        'bateryquantity',
        {'total_price': 0, 'number': 0,'stock': 0, 'sold': 0}, // Initial values
      );
    }
  }
  // Check if otherquantity table is empty
  Future<void> insertotherDefaultIfNeeded() async {
    final db = await database;

    // Check if the table is empty
    var result = await db?.rawQuery("SELECT COUNT(*) FROM otherquantity");

    if (result != null && result.isNotEmpty && result[0]['COUNT(*)'] == 0) {
      // Insert default values if no rows exist
      await db?.insert(
        'otherquantity',
        {'total_price': 0, 'number': 0,'stock': 0, 'sold': 0}, // Initial values
      );
    }
  }

  //delete functions

  Future deleteSolarQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE solarquantity SET number = number + ?, stock = stock - ?, sold = sold - ?  WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  //add battery data

  Future deletebatteryQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE bateryquantity SET number = number + ?, stock = stock - ?, sold = sold - ? WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  // add invertrs data
  Future deleteinvertrQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE invertrquantity SET number = number + ?, stock = stock - ?, sold = sold - ? WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }
  // add other equipments data
  Future deleteotherQuantity(final int incrementNumber, final int stock, final revue) async {
    final db = await database;
    await db?.rawUpdate(
      'UPDATE otherquantity SET number = number + ?, stock = stock - ?, sold = sold - ? WHERE id = ?',
      [incrementNumber, stock, revue, 1],  // Replace 1 with the actual row ID if needed
    );
    print(incrementNumber.toString());
  }

}


