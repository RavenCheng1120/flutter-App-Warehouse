import 'package:flutter/material.dart';

import '../db/warehouse_database.dart';
import '../model/plan_model.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({super.key});

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  TextEditingController productNameControl = TextEditingController();
  String productTypeInput = "預設";
  final _formKey = GlobalKey<FormState>();

  Future submitAddPlan() async {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("新增計畫"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: [
              inputProductName(),
              const SizedBox(height: 24),
              inputProductType(),
              const SizedBox(height: 24),
              buildSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputProductName() => TextFormField(
        controller: productNameControl,
        decoration: const InputDecoration(
          labelText: '商品名稱',
          hintText: '例：小動物貼紙組',
          icon: Icon(Icons.type_specimen_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入文字';
          } else {
            return null;
          }
        },
      );

  Widget inputProductType() => TextFormField(
        decoration: const InputDecoration(
          labelText: '種類',
          hintText: '例：刀模貼紙',
          icon: Icon(Icons.ballot_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onChanged: (value) => setState(
          () => productTypeInput = value,
        ),
      );

  Widget buildSubmit() => MaterialButton(
        onPressed: () {
          // submitAddPlan();
          if (_formKey.currentState!.validate()) {
            print(productNameControl.text);
          }
        },
        color: Colors.amber.shade600,
        textColor: Colors.black87,
        child: const Text(
          "新增",
          style: TextStyle(fontSize: 20),
        ),
      );
}
