import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Kalkulator(),
    );
  }
}

class Kalkulator extends StatefulWidget {
  @override
  _KalkulatorState createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  dynamic tampilan = 20;
  dynamic layar = '0';
  double angkaSatu = 0;
  double angkaDua = 0;
  dynamic hasil = '';
  dynamic hasilAkhir = '';
  dynamic operator = '';
  dynamic operatorSebelumnya = '';

  Widget tombolKalkulator(String teksTombol, Color warnaTombol, Color warnaTeks) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          hitung(teksTombol);
        },
        child: Text(
          '$teksTombol',
          style: TextStyle(
            fontSize: 35,
            color: warnaTeks,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          backgroundColor: warnaTombol,
        ),
      ),
    );
  }

  void hitung(String teksTombol) {
    if (teksTombol == 'AC') {
      layar = '0';
      angkaSatu = 0;
      angkaDua = 0;
      hasil = '';
      hasilAkhir = '0';
      operator = '';
      operatorSebelumnya = '';
    } else if (operator == '=' && teksTombol == '=') {
      if (operatorSebelumnya == '+') {
        hasilAkhir = tambah();
      } else if (operatorSebelumnya == '-') {
        hasilAkhir = kurang();
      } else if (operatorSebelumnya == 'x') {
        hasilAkhir = kali();
      } else if (operatorSebelumnya == '/') {
        hasilAkhir = bagi();
      }
    } else if (teksTombol == '+' || teksTombol == '-' || teksTombol == 'x' || teksTombol == '/' || teksTombol == '=') {
      if (angkaSatu == 0) {
        angkaSatu = double.parse(hasil);
      } else {
        angkaDua = double.parse(hasil);
      }

      if (operator == '+') {
        hasilAkhir = tambah();
      } else if (operator == '-') {
        hasilAkhir = kurang();
      } else if (operator == 'x') {
        hasilAkhir = kali();
      } else if (operator == '/') {
        hasilAkhir = bagi();
      }
      operatorSebelumnya = operator;
      operator = teksTombol;
      hasil = '';
    } else if (teksTombol == '%') {
      hasil = angkaSatu / 100;
      hasilAkhir = cekDesimal(hasil);
    } else if (teksTombol == '.') {
      if (!hasil.toString().contains('.')) {
        hasil = hasil.toString() + '.';
      }
      hasilAkhir = hasil;
    } else if (teksTombol == '+/-') {
      hasil.toString().startsWith('-') ? hasil = hasil.toString().substring(1) : hasil = '-' + hasil.toString();
      hasilAkhir = hasil;
    } else {
      hasil = hasil + teksTombol;
      hasilAkhir = hasil;
    }

    setState(() {
      layar = hasilAkhir;
    });
  }

  String tambah() {
    hasil = (angkaSatu + angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String kurang() {
    hasil = (angkaSatu - angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String kali() {
    hasil = (angkaSatu * angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String bagi() {
    hasil = (angkaSatu / angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String cekDesimal(dynamic hasil) {
    if (hasil.toString().contains('.')) {
      List<String> pecahanDesimal = hasil.toString().split('.');
      if (!(int.parse(pecahanDesimal[1]) > 0)) {
        return hasil = pecahanDesimal[0].toString();
      }
    }
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Kalkulator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$layar',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tombol-tombol kalkulator lainnya...
          ],
        ),
      ),
    );
  }
}
