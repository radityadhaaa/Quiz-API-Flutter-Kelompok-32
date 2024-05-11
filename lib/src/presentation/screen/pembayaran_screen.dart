import 'package:flutter/material.dart';
import 'package:barayafood/src/presentation/screen/status_screen.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({super.key});

  @override
  _PembayaranScreenState createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  String? _paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metode Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih metode pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: const Text('Transfer Bank'),
                leading: Radio(
                  value: 'transfer',
                  groupValue: _paymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: const Text('Dana'),
                leading: Radio(
                  value: 'dana',
                  groupValue: _paymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _paymentMethod == null
                  ? null
                  : () {
                      // Handle button press, navigate to StatusScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StatusScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pesanan Anda sudah dibayar!')),
                      );
                    },
              child: const Text('Lanjutkan ke Status Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
