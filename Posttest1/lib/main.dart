import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'profilePage.dart';
import 'keuangan_provider.dart'; // Import file provider yang baru dibuat

void main() {
  runApp(
    // Daftarkan Provider di akar aplikasi agar state bisa diakses global
    ChangeNotifierProvider(
      create: (context) => KeuanganProvider(),
      child: const AplikasiKeuangan(),
    ),
  );
}

class AplikasiKeuangan extends StatelessWidget {
  const AplikasiKeuangan({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: Pengaturan tema dasar dan halaman awal aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Keuangan',
      // ThemeData: Mengatur warna utama dan jenis font
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Inter',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Kerangka utama penyusun kanvas halaman
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // SafeArea: Memastikan konten tidak tertutup notch atau status bar HP
      body: SafeArea(
        // SingleChildScrollView: Membuat layar bisa digulir (scroll)
        child: SingleChildScrollView(
          // Padding: Memberikan jarak aman di semua sisi layar
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            // Column: Menyusun elemen UI secara vertikal (atas ke bawah)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row: Menyusun elemen UI secara horizontal (kiri ke kanan)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text: Menampilkan tulisan sapaan
                    const Text('halo man', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    // Icon: Menampilkan ikon profil akun
                    Icon(Icons.account_circle, size: 40, color: Colors.blue.shade700)
                  ],
                ),
                // SizedBox: Memberikan spasi/jarak kosong antar elemen
                const SizedBox(height: 24),
                
                // TextField: Kolom input untuk fitur pencarian
                TextField(
                  // InputDecoration: Mengatur desain dari textfield (border, icon, hint)
                  decoration: InputDecoration(
                    hintText: 'hayo cari apa awkawkakw',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Container: Kotak pembungkus untuk membuat kartu biru saldo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  // BoxDecoration: Memberi warna, lengkungan, dan bayangan pada container
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total saldo', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      // Consumer: Mendengarkan perubahan variabel saldo dari KeuanganProvider
                      Consumer<KeuanganProvider>(
                        builder: (context, keuangan, child) {
                          String formatSaldo = keuangan.totalSaldo.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]}.');
                          // Menampilkan nominal saldo yang diperbarui secara dinamis
                          return Text(
                            'Rp $formatSaldo',
                            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    // Expanded: Membagi sisa ruang layar secara merata untuk tombol
                    Expanded(
                      // ElevatedButton: Tombol aksi utama dengan efek timbul
                      child: ElevatedButton(
                        onPressed: () {
                          // showModalBottomSheet: Menampilkan form pop-up dari bawah layar
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, 
                            backgroundColor: Colors.transparent, 
                            builder: (context) => const FormPemasukan(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, 
                          foregroundColor: Colors.white, 
                          padding: const EdgeInsets.symmetric(vertical: 16), 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: [
                            Icon(Icons.add, size: 20), 
                            SizedBox(width: 8), 
                            Text('Pemasukan', style: TextStyle(fontWeight: FontWeight.bold)), 
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, 
                            backgroundColor: Colors.transparent, 
                            builder: (context) => const FormPengeluaran(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, 
                          foregroundColor: Colors.white, 
                          padding: const EdgeInsets.symmetric(vertical: 16), 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: [
                            Icon(Icons.remove, size: 20), 
                            SizedBox(width: 8), 
                            Text('Pengeluaran', style: TextStyle(fontWeight: FontWeight.bold)), 
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                const Text(
                  'Transaksi Terakhir dilakukan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                // Consumer: Memantau dan menarik data list transaksi dari provider
                Consumer<KeuanganProvider>(
                  builder: (context, keuangan, child) {
                    if (keuangan.riwayatTransaksi.isEmpty) {
                      // Center: Memosisikan teks tepat di tengah layar jika data kosong
                      return const Center(
                        child: Text("Belum ada transaksi.", style: TextStyle(color: Colors.grey)),
                      );
                    }
                    
                    // ListView.builder: Mencetak widget daftar transaksi sebanyak isi data secara otomatis
                    return ListView.builder(
                      shrinkWrap: true, // Membatasi tinggi ListView agar tidak bentrok dengan SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(), // Mematikan scroll internal listview
                      itemCount: keuangan.riwayatTransaksi.length,
                      itemBuilder: (context, index) {
                        final tx = keuangan.riwayatTransaksi[index];
                        final isPemasukan = tx['jenis'] == 'pemasukan';
                        
                        String nominalStr = tx['nominal'].toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]}.');

                        // Container: Membungkus setiap satu baris riwayat transaksi
                        return Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isPemasukan ? Colors.green.shade100 : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  isPemasukan ? Icons.arrow_downward : Icons.arrow_upward, 
                                  color: isPemasukan ? Colors.green : Colors.red
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tx['nama'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text(tx['kategori'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Text(
                                '${isPemasukan ? '+' : '-'}Rp $nominalStr',
                                style: TextStyle(
                                  color: isPemasukan ? Colors.green : Colors.redAccent, 
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // NavigationBar: Menampilkan deretan menu tab di ujung bawah layar
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: 0, 
        onDestinationSelected: (index) {
          if (index == 2) { 
            // Navigator: Fungsi untuk berpindah (push) ke halaman lain
            Navigator.push(
              context,
              // MaterialPageRoute: Animasi transisi pergerakan halaman standar material
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        destinations: const [
          // NavigationDestination: Item/tombol ikon menu individual
          NavigationDestination(icon: Icon(Icons.home), label: "Beranda"),
          NavigationDestination(icon: Icon(Icons.analytics), label: "Statistik"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// KELAS FORM PEMASUKAN DAN PENGELUARAN 
// -------------------------------------------------------------

// Mesin otomatis pembuat titik ribuan dari ekstensi TextInputFormatter
class PemisahRibuanFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');
    String angkaHanya = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String hasil = '';
    for (int i = 0; i < angkaHanya.length; i++) {
      if (i > 0 && (angkaHanya.length - i) % 3 == 0) hasil += '.';
      hasil += angkaHanya[i];
    }
    return TextEditingValue(
      text: hasil,
      selection: TextSelection.collapsed(offset: hasil.length),
    );
  }
}

class FormPemasukan extends StatefulWidget {
  const FormPemasukan({super.key});
  @override
  State<FormPemasukan> createState() => _FormPemasukanState();
}

class _FormPemasukanState extends State<FormPemasukan> {
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  String? kategoriTerpilih;
  
  final List<String> daftarKategori = ['Beasiswa', 'Gaji', 'Bisnis/Jualan', 'Pemberian', 'Lainnya'];

  @override
  void dispose() {
    nominalController.dispose();
    namaController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 24, left: 24, right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tambah Pemasukan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number, 
              inputFormatters: [PemisahRibuanFormatter()], // Menerapkan format titik
              decoration: InputDecoration(
                labelText: 'Nominal',
                prefixText: 'Rp ', 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Pemasukan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            // DropdownButtonFormField: Membuat menu dropdown list agar user bisa memilih kategori
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              initialValue: kategoriTerpilih,
              // DropdownMenuItem: Memetakan setiap item pada daftar kategori menjadi komponen yang bisa di-klik
              items: daftarKategori.map((String kategori) {
                return DropdownMenuItem(value: kategori, child: Text(kategori));
              }).toList(),
              onChanged: (String? nilaiBaru) {
                setState(() { kategoriTerpilih = nilaiBaru; });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: catatanController,
              decoration: InputDecoration(
                labelText: 'Catatan (Opsional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  // TextButton: Tombol polos tanpa background untuk opsi batal
                  child: TextButton(
                    onPressed: () => Navigator.pop(context), // Menutup Form
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red, 
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Batal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final dataBaru = {
                        'jenis': 'pemasukan',
                        'nominal': int.tryParse(nominalController.text.replaceAll('.', '')) ?? 0, 
                        'nama': namaController.text,
                        'kategori': kategoriTerpilih ?? 'Lainnya',
                        'catatan': catatanController.text,
                      };
                      
                      // context.read: Mengeksekusi fungsi di dalam provider
                      context.read<KeuanganProvider>().tambahTransaksi(dataBaru);
                      Navigator.pop(context); // Menutup form setelah data disave
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700, 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormPengeluaran extends StatefulWidget {
  const FormPengeluaran({super.key});
  @override
  State<FormPengeluaran> createState() => _FormPengeluaranState();
}

class _FormPengeluaranState extends State<FormPengeluaran> {
  String? kategoriTerpilih;
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  
  final List<String> daftarKategori = ['Makan & Minum', 'Hobi', 'Pakaian', 'Sparepart Motor', 'Lainnya'];

  @override
  void dispose() {
    nominalController.dispose();
    namaController.dispose();
    catatanController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 24, left: 24, right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Catat Pengeluaran', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number, 
              inputFormatters: [PemisahRibuanFormatter()],
              decoration: InputDecoration(
                labelText: 'Nominal',
                prefixText: 'Rp ', 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Pengeluaran',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              initialValue: kategoriTerpilih,
              items: daftarKategori.map((String kategori) {
                return DropdownMenuItem(value: kategori, child: Text(kategori));
              }).toList(),
              onChanged: (String? nilaiBaru) {
                setState(() { kategoriTerpilih = nilaiBaru; });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: catatanController,
              decoration: InputDecoration(
                labelText: 'Catatan (Opsional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red, 
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Batal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final dataBaru = {
                        'jenis': 'pengeluaran',
                        'nominal': int.tryParse(nominalController.text.replaceAll('.', '')) ?? 0, 
                        'nama': namaController.text,
                        'kategori': kategoriTerpilih ?? 'Lainnya',
                        'catatan': catatanController.text,
                      };
                      
                      // context.read: Mengeksekusi fungsi di dalam provider
                      context.read<KeuanganProvider>().tambahTransaksi(dataBaru);
                      Navigator.pop(context); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700, 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}