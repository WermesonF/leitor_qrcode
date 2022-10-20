import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:leitor_qrcode/models/cupom.dart';
import 'package:leitor_qrcode/services/custom_firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String codigo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner Cupom'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300,
                  height: 200,
                  child: Image.asset("assets/images/searching.png")),
              const SizedBox(
                height: 8,
              ),
              Text(
                "$codigo",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () {
                  readQRCode();
                },
                child: const Text('Validar QR code'),
              ),
            ]),
      ),
    );
  }

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        "#FFFFFF", "Cancelar", true, ScanMode.QR);

    if ((code != "-1")) {
      try {
        FirebaseValidade firebaseValidade = FirebaseValidade();
        Cupom cupom = await firebaseValidade.getValidade(code);

        if (cupom.validade == false) {
          firebaseValidade.updateValidade(code);
          codigo = "Cupom de ${cupom.desconto}% validado!";
        } else {
          codigo = "Este cupom já foi utilizado.";
        }
      } catch (e) {
        codigo = "QR code inválido.";
      }
    } else {
      codigo = "Tente novamente.";
    }

    setState(() {});
  }
}
