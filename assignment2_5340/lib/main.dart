// CPSC 5340 Assignment 2
// Interactive Ordering App: Courtney's Cafe
// Courtney Pross

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ListItem extends StatelessWidget {
  final IconData iconData;
  final String labelText;
  final String price;
  const ListItem({super.key, required this.iconData, required this.labelText, required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(labelText),
      subtitle: Text(price),
    );
  }
}

// onChanged is a callback so that the total can be updated as the user interacts with buttons in the tip and the counter widgets. 

class CounterButton extends StatefulWidget {
  final ValueChanged<int> onChanged;
  const CounterButton({super.key, required this.onChanged});

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int constant = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // subtraction
        IconButton(
          onPressed: constant > 0 ? () {
            setState(() {
              constant--;
            });
            widget.onChanged(constant);
          } : null,
          icon: const Icon(Icons.remove),
        ),

        Text("$constant"),

        // addition 
        IconButton(
          onPressed: () {
            setState(() {
              constant++;
            });
            widget.onChanged(constant);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class AddTip extends StatefulWidget {
  final ValueChanged<int> onTipChanged;
  const AddTip({super.key, required this.onTipChanged});

  @override
  State<AddTip> createState() => _AddTipState();
}

// coniditional UL element is used in the AddTip widget. 

class _AddTipState extends State<AddTip> {
  bool addTip = false;
  int tipAmount = 0;
  List<int> tipOptions = [0, 10, 20, 25];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Add Tip'),
          value: addTip,
          onChanged: (bool value) {
            setState(() {
              addTip = value;
            });
            
          },
        ),

        if (addTip)
          Wrap(
              spacing: 8,
              children: tipOptions.map((tip) {
                return ChoiceChip(
                  label: Text("$tip%"),
                  selected: tipAmount == tip,
                  onSelected: (bool selected) {
                    setState(() {
                      tipAmount = tip;
                    });
                    widget.onTipChanged(tipAmount);
                  },
                );
              }).toList(),
            ),
      ],
    );
  }
}

class TotalAmt extends StatefulWidget {
  const TotalAmt({super.key});

  @override
  State<TotalAmt> createState() => _TotalAmtState();
}

class _TotalAmtState extends State<TotalAmt> {
  int totalAmount = 0;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Total Amount:"),
        Text("\$$totalAmount"),
      ],
    );
  }
}

// the confirmation button is the Order widget. It shows an Alert once clicked. 

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Order Confirmed'),
              content: Text('Thank you for supporting Courtney.'),
            );
          }
        );
      },
      child: Text("Place Order")
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courtney\'s Cafe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const MyHomePage(title: 'Courtney\'s Cafe'),
    );
  }   
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int latteValue = 0;
  int latteCost = 5;

  int cappuccinoValue = 0;
  int cappuccinoCost = 3;

  int coldBrewValue = 0;
  int coldBrewCost = 4;

  int dripCoffeeValue = 0;
  int dripCoffeeCost = 2;

  int tipAmount = 0;

  bool altMilk = false;

  double get total {
    int preTip = (latteValue * latteCost + cappuccinoValue * cappuccinoCost + coldBrewValue * coldBrewCost + dripCoffeeValue * dripCoffeeCost);
    return preTip + preTip*tipAmount*0.01;
  }

  // widget to create menu item to avoid redudant code
  Widget _buildMenuItem(IconData icon, String name, int cost, int value, ValueChanged<int> onChanged) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Text("\$$cost"),
      trailing: CounterButton(onChanged: onChanged),
    );
  }


  // Widget to create divider between menu items to avoid redudant code
  // Dividers are a new element I explored to seperaute the menu items
  Widget _buildMenuDivider() {
    return Divider(
        color: Colors.brown,
        indent: 16.0,
        endIndent: 16.0,
      );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Courtney's Cafe"),
        titleTextStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(244, 39, 15, 11),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // the four order items are containted in this card with their icon, name and price. 
            Card(
              child: Column(
                children: [

                  _buildMenuItem(Icons.local_cafe, "Latte", latteCost, latteValue, (newValue) { setState(() { latteValue = newValue;}); }),
                  _buildMenuDivider(),

                  _buildMenuItem(Icons.local_cafe, "Cappuccino", cappuccinoCost, cappuccinoValue, (newValue) { setState(() { cappuccinoValue = newValue;}); }),
                  _buildMenuDivider(),

                  _buildMenuItem(Icons.local_cafe, "Cold Brew", coldBrewCost, coldBrewValue, (newValue) { setState(() { coldBrewValue = newValue;}); }),
                  _buildMenuDivider(),

                  _buildMenuItem(Icons.local_cafe, "Drip Coffee", dripCoffeeCost, dripCoffeeValue, (newValue) { setState(() { dripCoffeeValue = newValue;}); }),
                ], // Children of menu card
              ),
            ),
          
            SizedBox(height: 16.0),

            Card(
              child: AddTip(onTipChanged: (newTipAmount) { setState(() { tipAmount = newTipAmount; }); })
  
            ),

            SizedBox(height: 16.0),

            Card (
              // The TextField is a new widget I explored. It allows the user to input their own text
              // The checkbox list tile is a new widget that I used to let the user select if they want non-diary milk
              child: Column(
              children:[

                CheckboxListTile(
                    title: const Text('Non-Dairy Milk, Please!'),
                    subtitle: const Text('Give details in specific instructions.'),
                    value: altMilk,
                    onChanged: (bool? value) {
                      setState(() {
                        altMilk = value ?? false;
                      });
                    },
                ),

                TextField (
                  decoration: InputDecoration(
                  labelText: 'Special Instructions',
                  border: OutlineInputBorder(),
                ),
                  maxLines: 3,
                ),
              ] 
            ),
            ),

            SizedBox(height: 16.0),

            Card(
              child: 
              ListTile( 
                title: Text("Total: \$${total.toStringAsFixed(2)} "),
                trailing: Order()
            )
            ),

          ],
        ), 
      )
    );
  }
}