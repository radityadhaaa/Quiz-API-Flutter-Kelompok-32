import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum TransactionStatus {
  checkout,
  payment,
  accepted,
  rejected,
  delivering,
  completed
}

class StatusScreen extends HookWidget {
  final TransactionStatus status = TransactionStatus.checkout;

  @override
  Widget build(BuildContext context) {
    final transactionStatus = useState(status);

    return Scaffold(
      appBar: AppBar(
        title: Text('Status Transaksi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Status Transaksi Saat Ini:',
            ),
            Text(
              transactionStatus.value.toString().split('.').last,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Panggil API untuk memperbarui status transaksi
          // Untuk sementara, kita akan mengubah status secara manual
          if (transactionStatus.value.index <
              TransactionStatus.values.length - 1) {
            transactionStatus.value =
                TransactionStatus.values[transactionStatus.value.index + 1];
          } else {
            transactionStatus.value = TransactionStatus.checkout;
          }
        },
        tooltip: 'Perbarui Status',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
