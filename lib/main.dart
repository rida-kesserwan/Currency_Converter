import 'package:flutter/material.dart';

void main() => runApp(const CurrencyConverter());

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  String _fromCurrency = 'USD';
  String _toCurrency = 'LBP';
  String _result = '';
  String _inputValue = '';

  final Map<String, double> _exchangeRates = {
    'USD to LBP': 89000,
    'LBP to USD': 1 / 89000,
    'USD to Euros': 0.93,
    'Euros to USD': 1 / 0.93,
    'LBP to Euros': 1 / 89000 * 0.93,
    'Euros to LBP': 1 / 0.93 * 89000,
  };

  void _convert() {
    double input = double.tryParse(_inputValue) ?? 0.0;
    String key = '$_fromCurrency to $_toCurrency';
    double rate = _exchangeRates[key] ?? 1.0;
    double convertedValue = input * rate;

    setState(() {
      _result = convertedValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter')),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _inputValue = value; // Capture input directly
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter amount'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value!;
                    });
                  },
                  items: ['USD', 'LBP', 'Euros']
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value!;
                    });
                  },
                  items: ['USD', 'LBP', 'Euros']
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Result: $_result $_toCurrency',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
