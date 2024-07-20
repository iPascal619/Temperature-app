import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  const TemperatureConversionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConversion(),
    );
  }
}

class TemperatureConversion extends StatefulWidget {
  const TemperatureConversion({Key? key}) : super(key: key);

  @override
  _TemperatureConversionState createState() => _TemperatureConversionState();
}

class _TemperatureConversionState extends State<TemperatureConversion> {
  final TextEditingController _controller = TextEditingController();
  String _selectedConversion = 'F to C';
  String _result = '';
  List<String> _history = [];
  bool _isHistoryVisible = true;

  void _convertTemperature() {
    double input = double.tryParse(_controller.text) ?? 0.0;
    double converted;
    String historyEntry;

    if (_selectedConversion == 'F to C') {
      converted = (input - 32) * 5 / 9;
      historyEntry = 'F to C: ${input.toStringAsFixed(1)} => ${converted.toStringAsFixed(2)}';
    } else {
      converted = input * 9 / 5 + 32;
      historyEntry = 'C to F: ${input.toStringAsFixed(1)} => ${converted.toStringAsFixed(2)}';
    }

    setState(() {
      _result = converted.toStringAsFixed(2);
      _history.add(historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF339FFF),
        title: const Text('Temperature Conversion', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isPortrait ? _buildPortraitLayout() : _buildLandscapeLayout(),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          'Temperature Conversion',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter a value and select the conversion type',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter Temperature',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                  activeColor: const Color(0xFF339FFF),
                ),
                const Text('Fahrenheit to Celsius'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                  activeColor: const Color(0xFF339FFF),
                ),
                const Text('Celsius to Fahrenheit'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _convertTemperature,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF339FFF),
            ),
            child: const Text('Convert'),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Result: $_result',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            setState(() {
              _isHistoryVisible = !_isHistoryVisible;
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF339FFF),
          ),
          child: Text(_isHistoryVisible ? 'Hide History' : 'Show History'),
        ),
        const SizedBox(height: 16),
        if (_isHistoryVisible)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'History:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Temperature Conversion',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter a value and select the conversion type',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Temperature',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'F to C',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                    activeColor: const Color(0xFF339FFF),
                  ),
                  const Text('Fahrenheit to Celsius'),
                  Radio<String>(
                    value: 'C to F',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                    activeColor: const Color(0xFF339FFF),
                  ),
                  const Text('Celsius to Fahrenheit'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _convertTemperature,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF339FFF),
                  ),
                  child: const Text('Convert'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Result: $_result',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isHistoryVisible = !_isHistoryVisible;
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF339FFF),
                ),
                child: Text(_isHistoryVisible ? 'Hide History' : 'Show History'),
              ),
              const SizedBox(height: 16),
              if (_isHistoryVisible)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'History:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_history[index]),
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
