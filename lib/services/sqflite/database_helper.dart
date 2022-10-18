import 'dart:async';
import 'dart:io';

import 'package:eazy_shop/models/cart/cart_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbname = 'rentoDecor2.db';
  static final _tbl_cart_name = 'Cart';
  static final _tbl_user_cart_products = 'UserCartProducts';
  static final product_id = 'product_id';
  static final cart_id = 'cart_id';
  static final id = 'id';
  static final quantity = 'quantity';
  static final _dbversion = 3;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String path = join(_directory.path, _dbname);

    return await openDatabase(path, version: _dbversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tbl_cart_name(
        $cart_id INTEGER PRIMARY KEY
      )
    ''');
    return await db.execute('''
      CREATE TABLE $_tbl_user_cart_products(
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $cart_id INTEGER,
        $product_id INTEGER,
        $quantity INTEGER NOT NULL 
      )
    ''');
  }

  Future createEntryInCartTable(var row) async {
    Database db = await instance.database;
    var cart = row[cart_id];
    Map<String, int> cart_products = {'cart_id': row[cart_id]};
    var samp =
        await db.query(_tbl_cart_name, where: '$cart_id =?', whereArgs: [cart]);
    if (samp.isEmpty) {
      await db.insert(_tbl_cart_name, cart_products);
    } else {
      return 0;
    }
  }

  Future createEntryInCartProducsTable(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var cart = row[cart_id];
    var product = row[product_id];
    var cart_products = await db.rawQuery(
        'SELECT * FROM ${_tbl_user_cart_products} WHERE ${product_id}=? AND ${cart_id}=?',
        [product, cart]);

    if (cart_products.isEmpty) {
      return await db.insert(_tbl_user_cart_products, row);
    } else {
      return 0;
    }
  }

  Future<int> addtoCart(Map<String, dynamic> row) async {
    await createEntryInCartTable(row);
    int entryAddedOrNotFlag = await createEntryInCartProducsTable(row);
    return entryAddedOrNotFlag;
  }

  Future<int> makeCartEmpty(int userId) async {
    Database db = await instance.database;
    return await db.delete(_tbl_user_cart_products,
        where: '$cart_id =?', whereArgs: [userId]);
  }

  Future<List<Map<String, dynamic>>> getCartitem(int userId) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT * FROM $_tbl_user_cart_products where $cart_id=?', [userId]);
  }

  Future updateCartitem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int cartId = row[cart_id];
    int productId = row[product_id];
    return await db.update(_tbl_user_cart_products, row,
        where: '$cart_id = ? AND $product_id=?',
        whereArgs: [cartId, productId]);
  }

  Future<int> deleteCartItem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int cartId = row[cart_id];
    int productId = row[product_id];
    return await db.delete(_tbl_user_cart_products,
        where: '$cart_id = ? AND $product_id=?',
        whereArgs: [cartId, productId]);
  }

  Future<int> getCount(int userId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT COUNT (*) FROM $_tbl_user_cart_products where $cart_id=?',
        [userId]);
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> TrunccateTable() async {
    Database db = await instance.database;
    await db.delete(_tbl_cart_name);
    var result = await db.delete(_tbl_user_cart_products);
    return result;
  }

  Future<List<CartsModel>> getcartItems(int userId) async {
    var cartlist = await getCartitem(userId);
    int count = cartlist.length;
    List<CartsModel> noteList = List<CartsModel>();
    for (int i = 0; i < count; i++) {
      noteList.add(CartsModel.fromMapObject(cartlist[i]));
    }
    return noteList;
  }
}
