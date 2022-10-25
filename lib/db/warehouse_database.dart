import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/plan_model.dart';

class WarehouseDatabase {
  static final WarehouseDatabase instance = WarehouseDatabase._init();

  static Database? _database;

  WarehouseDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('warehouse.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final path = join(appDocPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tablePlan (
  ${PlanFields.id} $idType,
  ${PlanFields.productType} $textType,
  ${PlanFields.category} $textType,
  ${PlanFields.productName} $textType,
  ${PlanFields.size} $textType,
  ${PlanFields.number} $integerType,
  ${PlanFields.totalCost} $integerType,
  ${PlanFields.pricing} $integerType,
  ${PlanFields.manufacturer} $textType,
  ${PlanFields.createDate} $textType
  )
''');
  }

  Future<PlanModel> createPlan(PlanModel plan) async {
    final db = await instance.database;
    final id = await db.insert(tablePlan, plan.toJson());
    return plan.copy(id: id);
  }

  Future<PlanModel> readPlan(int id) async {
    final db = await instance.database;
    final map = await db.query(
      tablePlan,
      columns: PlanFields.values,
      where: '${PlanFields.id} = ?',
      whereArgs: [id],
    );

    if (map.isNotEmpty) {
      return PlanModel.fromJson(map.first);
    } else {
      throw Exception('ID $id is not found in readPlan.');
    }
  }

  Future<List<PlanModel>> readAllPlan() async {
    final db = await instance.database;
    const orderByTime = '${PlanFields.createDate} ASC';
    final result = await db.query(tablePlan, orderBy: orderByTime);

    return result.map((json) => PlanModel.fromJson(json)).toList();
  }

  Future<int> updatePlan(PlanModel plan) async {
    final db = await instance.database;

    return db.update(
      tablePlan,
      plan.toJson(),
      where: '${PlanFields.id} = ?',
      whereArgs: [plan.id],
    );
  }

  Future<int> deletePlan(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablePlan,
      where: '${PlanFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
