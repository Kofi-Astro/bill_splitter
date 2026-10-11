import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? value = 0;
  int numberOfPeople = 1;
  double tipAmount = 0;
  double grandTotal = 0;
  double amountPerPerson = 0;
  double? amount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bill Splitter')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefix: Text("GH₵  "),

                hint: Text("Amount"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value);
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter an amount";
                }
                final amountRegex = RegExp(r'^\d+(\.\d{1,2})?$');
                if (!amountRegex.hasMatch(value)) {
                  return "Enter a valid amount. Eg: 123 or 123.45";
                }

                return "Invalid amount";
              },
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(5, (int index) {
                final tipValues = [0, 5, 10, 15, 20, 25];
                return ChoiceChip(
                  label: Text("${tipValues[index]} %"),
                  selected: value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      value = selected ? index : null;

                      tipAmount = (tipValues[index].toInt() / 100) * amount!;
                      grandTotal = tipAmount + amount!;
                      amountPerPerson = grandTotal / numberOfPeople;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Number of people paying: "),
                IconButton(
                  onPressed: () {
                    if (numberOfPeople == 1) {
                      setState(() {
                        numberOfPeople = numberOfPeople;
                      });
                    } else {
                      setState(() {
                        numberOfPeople = numberOfPeople - 1;
                        amountPerPerson = grandTotal / numberOfPeople;
                      });
                    }
                  },
                  icon: Icon(Icons.remove),
                ),
                Text("$numberOfPeople"),
                IconButton(
                  onPressed: () {
                    setState(() {
                      numberOfPeople = numberOfPeople + 1;
                      amountPerPerson = grandTotal / numberOfPeople;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 40),
            Expanded(
              child: Card(
                child: ListView(
                  children: [
                    Text("Breakdown of Bill Payment"),
                    ListTile(
                      title: Text(
                        "Tip Amount: GH₵ ${tipAmount.toStringAsFixed(2)}",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Grand Total: GH₵ ${grandTotal.toStringAsFixed(2)}",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Amount Per Person: GH₵ ${amountPerPerson.toStringAsFixed(2)}",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
