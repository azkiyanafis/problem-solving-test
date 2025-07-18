import 'package:flutter/material.dart';

class Highestpalindrome extends StatefulWidget {
  const Highestpalindrome({super.key});

  @override
  State<Highestpalindrome> createState() => _HighestpalindromeState();
}

class _HighestpalindromeState extends State<Highestpalindrome> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  String result = '';
  List<bool> changed = [];

  bool Perbandingan(List<String> chars, int left, int right, int k){
    if(left >= right) return true;

    if(chars[left] == chars[right]){
      return Perbandingan(chars, left + 1, right - 1, k);
    }

    if(k<=0) return false;

    if(chars[left].compareTo(chars[right])>0){
      chars[right] = chars[left];
    } else {
      chars[left] = chars[right];
    }

    changed[left] = true;
    changed[right] = true;

    return Perbandingan(chars, left + 1, right - 1, k-1);
  }

  void maximize(List<String> chars, int left, int right, int k){
    if(left > right || k <= 0) return;

    if(chars[left] != 9){
      int cost = (changed[left] || changed[right]) ? 1:2;
      if(k >= cost){
        chars[left] = '9';
        chars[right] = '9';
        k -= cost;
      }
    }
    maximize(chars, left+1, right-1, k);
  }

  void perbandinganyangTertinggi(){
    String s = _controller1.text;
    int? k = int.tryParse(_controller2.text);
    if (!RegExp(r'^\d+$').hasMatch(s) || k == null || k < 0) {
      setState(() {
        result = "Input tidak valid";
      });
      return;
    }

    List<String> chars = s.split('');
    changed = List.filled(chars.length, false);

    bool success = Perbandingan(chars, 0, chars.length-1, k);
    if(!success){
      setState(() {
        result = '-1';
      });
      return;
    }

    int remainingK = k - changed.where((e) => e).length ~/ 2;
    maximize(chars, 0, chars.length-1, remainingK);

    setState(() {
      result = chars.join('');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Highest Palindrome"),
        centerTitle: true,
        backgroundColor: Colors.purple[100],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Column(
          children: [
            Custom_Textfield(controller: _controller1, label: 'Masukkan angka'),
            SizedBox(height: 20),
            Custom_Textfield(controller: _controller2, label: 'Masukkan k',),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: perbandinganyangTertinggi,
              style: ElevatedButton.styleFrom(elevation: 10),
              child: Text('Submit'),
            ),
            SizedBox(height: 30),
            Card(elevation: 10,
                  color: Colors.indigo[200],
                  child: Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 50, left: 60, right: 60),
                      child: Column(
                        children: [
                          Text("Hasil Perhitungan : $result", style: TextStyle(fontSize: 16),),
                        ],
                      )))
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
          labelText: label, border: OutlineInputBorder()),
    );
  }
}
