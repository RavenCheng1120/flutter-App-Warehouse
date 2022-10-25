import 'package:flutter/material.dart';
import 'package:warehouse/db/warehouse_database.dart';
import '../model/plan_model.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  Future addNote() async {
    final note = PlanModel(
      productType: "type",
      category: "cate",
      productName: "name",
      size: "size",
      number: 10,
      totalCost: 100,
      pricing: 50,
      manufacturer: "manufac",
      createDate: DateTime.now(),
    );
    await WarehouseDatabase.instance.createPlan(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
        onPressed: () {
          setState(() {
            addNote();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<PlanModel>>(
        future: WarehouseDatabase.instance.readAllPlan(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            return Text('Error: $error');
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    tileColor: Colors.amber.shade100,
                    leading: Icon(
                      Icons.image,
                      size: 32,
                      color: Colors.grey.shade800,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        size: 32,
                        color: Colors.red.shade600,
                      ),
                      onPressed: () {
                        setState(() {
                          int? id = snapshot.data?[i].id ??
                              -1; // if snapshot.data[i].id is null, id will be -1
                          WarehouseDatabase.instance.deletePlan(id);
                        });
                      },
                    ),
                    title: Text(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      snapshot.data![i].productName,
                    ),
                    subtitle: Text('${snapshot.data![i].id}'),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
