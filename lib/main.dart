import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Price Checker',
            theme: ThemeData(
                primarySwatch: Colors.green,
                colorScheme: const ColorScheme.dark(), //Dark Theme
            ),
            home: const MyHomePage(title: 'Price Checker'),
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

    String regex = "[0-9.]";
    String _output = "How much do you want to save today?";
    String _saving = "";
    final TextEditingController _conp1 = TextEditingController();
    final TextEditingController _conp2 = TextEditingController();
    final TextEditingController _cona1 = TextEditingController();
    final TextEditingController _cona2 = TextEditingController();
    double p1 = 0;
    double p2 = 0;
    double a1 = 0;
    double a2 = 0;

    void _reset() {
        setState(() {
            _conp1.text = "";
            _conp2.text = "";
            _cona1.text = "";
            _cona2.text = "";

            _output = "How much do you want to save today?"; 
            _saving = ""; 
        });
    }

    void _save(double save) {
        setState(() {
            String erg = save.toStringAsFixed(2); 
            _saving = "You save: $erg€";

            // if (product == 1){ _saving = "You gonna save" "das"; }
            // if (product == 2){ _saving = "Product 2 is cheaper"; }
            // if (product == 3){ _saving = ""; }
        });
    }

    void _calculate() {
        setState(() {
            
            double res1 = 0;
            double res2 = 0;
            double resdiff = 0;

            try {
                p1 = double.parse(_conp1.text); //p = price 1 and 2
                p2 = double.parse(_conp2.text);
                a1 = double.parse(_cona1.text); //p = amount 1 and 2
                a2 = double.parse(_cona2.text);

                res1 = p1 / a1;
                res2 = p2 / a2;

                if(res1 > res2) { resdiff = res1 - res2; }
                if(res1 < res2) { resdiff = res2 - res1; }
                _save(resdiff); //method for checking the difference

                debugPrint('debug res1: $res1');
                debugPrint('debug res2: $res2');
                debugPrint('resdiff: $resdiff');

                if (res1 < res2) { _output = "Product 1 is cheaper";}
                if (res1 > res2) { _output = "Product 2 is cheaper";}
                if (res1 == res2){ _output = "Both are equal";}

            } catch(e) {

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: 
                        Text( 'Wrong number format. Please check your input',
                            style: TextStyle(
                                color: Colors.white,
                            ),
                        ),
                        backgroundColor: Colors.deepPurple,
                    ),
                );
                debugPrint("Exception:");
            }
        });
    }

    // App and Button Layout hier
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),

            body: Center(
                child:
                Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

    Text("Product 1", style: Theme.of(context).textTheme.headlineMedium),

    TextField(
        controller: _cona1,
        decoration: const InputDecoration(labelText: "Enter amount"),
        keyboardType: TextInputType.number,
        onSubmitted: (value) { 
            _calculate(); 
        },
        inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(regex)),
        ],
    ),

    TextField(
        controller: _conp1,
        decoration: const InputDecoration(labelText: "Enter price"),
        keyboardType: TextInputType.number,
        onSubmitted: (value) { 
            _calculate(); 
        },
        inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(regex)),
        ],
    ),

    Text("Product 2", style: Theme.of(context).textTheme.headlineMedium),

    TextField(
        controller: _cona2,
        decoration: const InputDecoration(labelText: "Enter amount"),
        keyboardType: TextInputType.number,
        onSubmitted: (value) { 
            _calculate(); 
        },
        inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(regex)),
        ],
    ),

    TextField(
        controller: _conp2,
        decoration: const InputDecoration(labelText: "Enter price"),
        keyboardType: TextInputType.number,
        onSubmitted: (value) { 
            _calculate(); 
        },
        inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(regex)),
        ],
    ),

    //Here the information is going to be displayed
    Padding(
        padding: const EdgeInsets.all(12),
        child: Text(_output), 
    ),

    //Here telling if cheap or not
    Padding(
        padding: const EdgeInsets.all(12),
        child: Text(_saving,
            style: const TextStyle(color: Colors.green)),
    ),

    Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Padding(
            padding: const EdgeInsets.all(10),
            child: 
            ElevatedButton(
                onPressed: _calculate,
                child: const Text("Calculate"),
            ),
        ),

        Padding(
            padding: const EdgeInsets.all(10),
            child: 
            ElevatedButton(
                onPressed: _reset,
                child: const Text("Reset"),
            ),
        ),
        ]
        ),
    ],
    ),
    )
    ),

    floatingActionButton: FloatingActionButton(
        onPressed: _calculate,
        tooltip: 'Calculate',
        child: const Icon(
            Icons.calculate),
    ),

    );
    }
}

