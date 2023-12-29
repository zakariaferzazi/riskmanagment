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

List<DataModel> Data = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

double netprofit = 0;
int losingtrade = 0;
int winningtrade = 0;
int alltrade = 0;
double winningrate = 0;

class _MyHomePageState extends State<MyHomePage> {
  void calculate_loss(double price, double stoploss) {
    var amountofstocks = 100 / price;
    var lossamount = price - stoploss;
    var allloss = lossamount * amountofstocks;

    setState(() {
      Data.add(DataModel("Loss", amountofstocks, allloss));
      netprofit = netprofit - allloss;
      losingtrade = losingtrade + 1;
      alltrade = alltrade +1;
      winningrate =winningtrade/alltrade*100;
    });
  }

  void calculate_profit(double price, double stoploss) {
    var amountofstocks = 100 / price;
    var lossamount = price - stoploss;
    var allloss = lossamount * amountofstocks;
    var profit = allloss * 1.5;
    var profitamount = profit / amountofstocks;
    var takeprofit = price + profitamount;

    setState(() {
      Data.add(DataModel("Profit", amountofstocks, profit));
      netprofit = netprofit + profit;
      winningtrade = winningtrade + 1;
      alltrade = alltrade +1;
      winningrate =winningtrade/alltrade*100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: netprofit >= 0 ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text(
                        netprofit >= 0 ? "Winner" : "Loser",
                        style: TextStyle(color: Colors.white),
                      )))),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          // color: Data[index].status == "Profit" ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text(
                        "Winning Rate : ${winningrate.toStringAsFixed(0)}%",
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      )))),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          // color: Data[index].status == "Profit" ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Row(
                        children: [
                          Text(
                            "Final Profit : ",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            netprofit.toStringAsFixed(2),
                            style: TextStyle(
                              color: netprofit >= 0 ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ))))
            ],
          ),
        ),
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
          Card(
              margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
              elevation: 20,
              child: Container(
                padding: EdgeInsets.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                                child: Text(
                              "Status",
                              style: TextStyle(color: Colors.white),
                            )))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                // color: Data[index].status == "Profit" ? Colors.green : Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                                child: Text(
                             "Stocks Amount",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            )))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                // color: Data[index].status == "Profit" ? Colors.green : Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                                child: Text(
                                  "Net Profit",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),)))
                  ],
                ),
              )),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    margin:
                        EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: Data[index].status == "Profit"
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                      child: Text(
                                    Data[index].status,
                                    style: TextStyle(color: Colors.white),
                                  )))),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      // color: Data[index].status == "Profit" ? Colors.green : Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                      child: Text(
                                    Data[index].stocksamount.toStringAsFixed(2),
                                    style: TextStyle(color: Colors.purple),
                                  )))),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      // color: Data[index].status == "Profit" ? Colors.green : Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                      child: Text(
                                    Data[index].status == "Profit"
                                        ? "+${Data[index].profitloss.toStringAsFixed(2)}"
                                        : "-${Data[index].profitloss.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Data[index].status == "Profit"
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ))))
                        ],
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
