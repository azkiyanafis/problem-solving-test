import 'package:flutter/material.dart';

class Denseranking extends StatefulWidget {
  const Denseranking({super.key});

  @override
  State<Denseranking> createState() => _DenserankingState();
}

class _DenserankingState extends State<Denseranking> {
  final TextEditingController _jumlahyangmainController =
      TextEditingController();
  final TextEditingController _daftarskorController = TextEditingController();
  final TextEditingController _jumlahpermainangitsController =
      TextEditingController();
  final TextEditingController _skorGITSController = TextEditingController();

  List<int> hasilPerhitungan = [];

  List<int> denseRanking(List<int> skor, List<int> skorGits) {
    final rank = skor.toSet().toList()..sort((a, b) => b.compareTo(a));
    List<int> result = [];
    int i = rank.length - 1;

    for (int skor in skorGits) {
      while (i >= 0 && skor >= rank[i]) {
        i--;
      }
      result.add(i + 2);
    }
    return result;
  }

  void prosesPerhitungan() {
    try {
      final jumlahPemain = int.parse(_jumlahyangmainController.text.trim());
      final daftarskor =
          _daftarskorController.text.trim().split(' ').map(int.parse).toList();
      final jumlahPermainan =
          int.parse(_jumlahpermainangitsController.text.trim());
      final skorGits =
          _skorGITSController.text.trim().split(' ').map(int.parse).toList();

      if (daftarskor.length != jumlahPemain ||
          skorGits.length != jumlahPermainan) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Jumlah Data Tidak Sesuai')));
        return;
      }

      final result = denseRanking(daftarskor, skorGits);
      setState(() {
        hasilPerhitungan = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Input tidak valid')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dense Ranking"),
        centerTitle: true,
        backgroundColor: Colors.purple[100],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Column(
            children: [
              Custom_Textfield(
                controller: _jumlahyangmainController,
                label: 'Masukkan jumlah pemain',
              ),
              SizedBox(height: 20),
              Custom_Textfield(
                controller: _daftarskorController,
                label: 'Daftar skor seluruh pemain (dipisah spasi)',
              ),
              SizedBox(height: 20),
              Custom_Textfield(
                controller: _jumlahpermainangitsController,
                label: 'Jumlah permainan yang diikuti',
              ),
              SizedBox(height: 20),
              Custom_Textfield(
                controller: _skorGITSController,
                label: 'Skor yang di dapatkan (dipisah spasi)',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: prosesPerhitungan,
                style: ElevatedButton.styleFrom(elevation: 10),
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              Card(elevation: 10,
                  color: Colors.lightBlue[200],
                  child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Column(
                        children: [
                          Text("Hasil Perhitungan : $hasilPerhitungan"),
                        ],
                      )))
            ],
          ),
        )),
      ),
    );
  }
}

class Custom_Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const Custom_Textfield(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
    );
  }
}
