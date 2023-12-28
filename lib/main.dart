

import 'package:flutter/material.dart';

import 'DataModel.dart';

void main() {
  runApp(const MyApp());
}

List? winrate;
List? totaltrade;
List? winning;
List? losing;
var price = TextEditingController();
var stoploss = TextEditingController();



List<DataModel>? AllData;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void calculate_loss(double price, double stoploss) {
  var amountofstocks = 100 / price;
  var lossamount = price - stoploss;
  var allloss = lossamount * amountofstocks;
  AllData!
      .add(DataModel("Loss", "${amountofstocks}", "${allloss}"));
}

void calculate_profit(double price, double stoploss) {
  var amountofstocks = 100 / price;
  var lossamount = price - stoploss;
  var allloss = lossamount * amountofstocks;
  var profit = allloss * 1.5;
  var profitamount = profit / amountofstocks;
  var takeprofit = price + profitamount;
  print(takeprofit);
  AllData!.add(
      DataModel("Profit", amountofstocks.toString(), profitamount.toString()));
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Price 💰'),
            subtitle: TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                hintText: "💰",
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            title: Text('Stop Loss 💰'),
            subtitle: TextFormField(
              controller: stoploss,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                hintText: "💰",
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      calculate_profit(double.parse(price.text),
                          double.parse(stoploss.text));
                    },
                    child: Text(
                      'Profit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      calculate_loss(double.parse(price.text),
                          double.parse(stoploss.text));
                    },
                    child: Text(
                      'Loss',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Text("Win Rate %  -"),
              Text("  Total Trades  -"),
              Text("  Winning Trades  -"),
              Text("  Losing Trades")
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: AllData!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    margin: EdgeInsets.all(5),
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: const Row(
                        children: [
                          Text("Win Rate %  -"),
                          Text("  Total Trades  -"),
                          Text("  Winning Trades  -"),
                          Text("  Losing Trades")
                        ],
                      ),
                    ));
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        tooltip: 'Increment',
        child: const Icon(Icons.done),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
