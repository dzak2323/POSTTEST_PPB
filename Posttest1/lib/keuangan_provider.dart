import 'package:flutter/material.dart';

class KeuanganProvider extends ChangeNotifier {
  int _totalSaldo = 0;
  final List<Map<String, dynamic>> _riwayatTransaksi = [];

  int get totalSaldo => _totalSaldo;
  List<Map<String, dynamic>> get riwayatTransaksi => _riwayatTransaksi;

  void tambahTransaksi(Map<String, dynamic> data) {
    _riwayatTransaksi.insert(0, data);
    int nominal = data['nominal'] as int;
    
    if (data['jenis'] == 'pemasukan') {
      _totalSaldo += nominal;
    } else {
      _totalSaldo -= nominal;
    }
    
    notifyListeners();
  }
}