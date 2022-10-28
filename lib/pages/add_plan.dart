import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/warehouse_database.dart';
import '../model/plan_model.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({super.key});

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  TextEditingController productNameControl = TextEditingController();
  TextEditingController productTypeControl = TextEditingController();
  TextEditingController categoryControl = TextEditingController();
  TextEditingController sizeControl = TextEditingController();
  TextEditingController numberControl = TextEditingController();
  TextEditingController totalCostControl = TextEditingController();
  TextEditingController pricingControl = TextEditingController();
  TextEditingController manufacturerControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future submitAddPlan() async {
    final note = PlanModel(
      productType: productTypeControl.text,
      category: categoryControl.text,
      productName: productNameControl.text,
      size: sizeControl.text,
      number: int.parse(numberControl.text),
      totalCost: int.parse(totalCostControl.text),
      pricing: int.parse(pricingControl.text),
      manufacturer: manufacturerControl.text,
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
              buildDisplayText('種類'),
              const SizedBox(height: 12),
              inputProductName(),
              const SizedBox(height: 24),
              inputProductType(),
              const SizedBox(height: 24),
              inputCategory(),
              const SizedBox(height: 24),
              buildDisplayText('規格'),
              const SizedBox(height: 12),
              inputSize(),
              const SizedBox(height: 24),
              inputNumber(),
              const SizedBox(height: 24),
              inputPricing(),
              const SizedBox(height: 24),
              buildDisplayText('製造'),
              const SizedBox(height: 12),
              inputManufacturer(),
              const SizedBox(height: 24),
              inputTotalCost(),
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
          labelText: '名稱',
          hintText: '例：小動物貼紙組',
          icon: Icon(Icons.type_specimen_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入名稱';
          } else {
            return null;
          }
        },
      );

  Widget inputProductType() => TextFormField(
        controller: productTypeControl,
        decoration: const InputDecoration(
          labelText: '商品品項',
          hintText: '例：刀模貼紙',
          icon: Icon(Icons.ballot_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入品項';
          } else {
            return null;
          }
        },
      );

  Widget inputCategory() => TextFormField(
        controller: categoryControl,
        decoration: const InputDecoration(
          labelText: '系列/類別',
          hintText: '例：森林動物系列',
          icon: Icon(Icons.category_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入系列';
          } else {
            return null;
          }
        },
      );

  Widget inputSize() => TextFormField(
        controller: sizeControl,
        decoration: const InputDecoration(
          labelText: '尺寸',
          hintText: '例：高 5cm X 寬 4cm',
          icon: Icon(Icons.height_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入規格';
          } else {
            return null;
          }
        },
      );

  Widget inputNumber() => TextFormField(
        controller: numberControl,
        decoration: const InputDecoration(
          labelText: '數量',
          hintText: '例：50',
          icon: Icon(Icons.numbers_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入數量';
          } else {
            return null;
          }
        },
      );

  Widget inputPricing() => TextFormField(
        controller: pricingControl,
        decoration: const InputDecoration(
          labelText: '販售單價',
          hintText: '例：30',
          icon: Icon(Icons.money),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        inputFormatters: <TextInputFormatter>[
          // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入單價';
          } else {
            return null;
          }
        },
      );

  Widget inputManufacturer() => TextFormField(
        controller: manufacturerControl,
        decoration: const InputDecoration(
          labelText: '製造商',
          hintText: '例：XX影印店',
          icon: Icon(Icons.manage_accounts_sharp),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入製造商';
          } else {
            return null;
          }
        },
      );

  Widget inputTotalCost() => TextFormField(
        controller: totalCostControl,
        decoration: const InputDecoration(
          labelText: '總成本',
          hintText: '例：1000',
          icon: Icon(Icons.attach_money_rounded),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請輸入總成本';
          } else {
            return null;
          }
        },
      );

  Widget buildDisplayText(String str) => Text(
        str,
        style: const TextStyle(
          fontSize: 16,
          decoration: TextDecoration.overline,
          color: Color.fromARGB(255, 177, 61, 7),
        ),
      );

  Widget buildSubmit() => MaterialButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            submitAddPlan();
            Navigator.pop(context);
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
