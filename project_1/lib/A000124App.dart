import 'package:flutter/material.dart';

class A000124App extends StatefulWidget {
  const A000124App({super.key});

  @override
  State<A000124App> createState() => _A000124AppState();
}

class _A000124AppState extends State<A000124App> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  String output1 = '';
  String output2 = '';
  String output3 = '';

  String rumusyangDipake(int maxN){
    List<int> result = [];
    for(int n = 0; n <= maxN; n++){
      int value = (n * (n + 1)) ~/ 2 + 1;
      result.add(value);
    }
    return result.join('-');
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("A000124 of Sloane’s OEIS"),
        centerTitle: true,
        backgroundColor: Colors.purple[100],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Column(
          children: [
            Custom_Textfield(controller: _controller1, label: 'Input 1',),
            SizedBox(height: 20),
            Custom_Textfield(controller: _controller2, label: 'Input 2',),
            SizedBox(height: 20),
            Custom_Textfield(controller: _controller3, label: 'Input 3',),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int? maxN1 = int.tryParse(_controller1.text);
                int? maxN2 = int.tryParse(_controller2.text);
                int? maxN3 = int.tryParse(_controller3.text);

                setState(() {
                  output1 = (maxN1 != null) ? rumusyangDipake(maxN1) : 'null';
                  output2 = (maxN2 != null) ? rumusyangDipake(maxN2) : 'null';
                  output3 = (maxN3 != null) ? rumusyangDipake(maxN3) : 'null';
                });
              },
              style: ElevatedButton.styleFrom(elevation: 10),
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            Text("Hasil : $output1", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20),
            Text("Hasil : $output2", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20),
            Text("Hasil : $output3", style: TextStyle(fontSize: 20),),
          ],
        ),
      )),
    );
  }
}

class Custom_Textfield extends StatelessWidget {
   final TextEditingController controller;
   final String label;

  const Custom_Textfield({
    super.key,
    required this.label, required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Input', border: OutlineInputBorder()),
    );
  }
}
