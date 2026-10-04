import 'package:flutter/material.dart';
import 'profilePage.dart';
import 'package:flutter/services.dart';

void main() {
  // 1. Ubah MyApp() menjadi AplikasiKeuangan() agar sesuai dengan class di bawahnya
  runApp(const AplikasiKeuangan());
}

// Material App
// 2. Biasakan menggunakan huruf kapital di awal nama Class (PascalCase)
class AplikasiKeuangan extends StatelessWidget {
  const AplikasiKeuangan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Keuangan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Inter',
      ),
      home: const HomePage(),
    );
  }
}

// Scaffold
// Scaffold (Sekarang menjadi StatefulWidget)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Variabel penyimpan total saldo (bisa berubah)
  int totalSaldo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('halo man', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Icon(Icons.account_circle, size: 40, color: Colors.blue.shade700)
                  ],
                ),
                const SizedBox(height: 24),
                
                // Search Section
                TextField(
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

                // Card Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total saldo', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      // 2. Teks statis diganti dengan variabel totalSaldo
                      Text(
                        'Rp $totalSaldo',
                        style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Baris penampung tombol
                Row(
                  children: [
                    // Tombol Pemasukan (Kiri)
                    Expanded(
                      child: ElevatedButton(
                        // 3. Tambahkan async untuk menunggu proses form selesai
                        onPressed: () async {
                          // Tunggu sampai pop-up ditutup dan bawa datanya
                          final dataKembalian = await showModalBottomSheet<Map<String, dynamic>>(
                            context: context,
                            isScrollControlled: true, 
                            backgroundColor: Colors.transparent, 
                            builder: (context) => const FormPemasukan(),
                          );

                          // 4. Jika data tidak kosong (tombol simpan ditekan, bukan batal)
                          if (dataKembalian != null) {
                            setState(() {
                              // Tambahkan nominal ke total saldo
                              totalSaldo += dataKembalian['nominal'] as int;
                            });
                          }
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
                    
                    // Tombol Pengeluaran (Kanan)
                    Expanded(
                      child: ElevatedButton(
                        // 3. Tambahkan async
                        onPressed: () async {
                          // Tunggu sampai pop-up ditutup
                          final dataKembalian = await showModalBottomSheet<Map<String, dynamic>>(
                            context: context,
                            isScrollControlled: true, 
                            backgroundColor: Colors.transparent, 
                            builder: (context) => const FormPengeluaran(),
                          );

                          // 4. Jika data berhasil dikembalikan
                          if (dataKembalian != null) {
                            setState(() {
                              // Kurangi total saldo dengan nominal
                              totalSaldo -= dataKembalian['nominal'] as int;
                            });
                          }
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
                
                // Transaksi akhir akhir ini
                const Text(
                  'Transaksi Terakhir dilakukan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Contoh 1 Item Transaksi (Masih Statis)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 16), // Tambah sedikit jarak
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.fastfood, color: Colors.orange),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Beli Crinear Daybreak', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Hari ini', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      const Text(
                        '-Rp 2.700.000',
                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: 0, 
        onDestinationSelected: (index) {
          if (index == 2) { 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Beranda"),
          NavigationDestination(icon: Icon(Icons.analytics), label: "Statistik"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
// Stateful Widget khusus untuk Pop-up Form Pemasukan
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
  
  final List<String> daftarKategori = [
    'Beasiswa', 'Gaji', 'Bisnis/Jualan', 'Pemberian', 'Lainnya'
  ];

// membuang controller demi effiesiensi memory
  @override
  void dispose() {
    nominalController.dispose();
    namaController.dispose();
    catatanController.dispose();
    super.dispose();
  }

// Decoration
  @override
  Widget build(BuildContext context) {
    // Container pembungkus utama form
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // Padding dinamis: viewInsets.bottom mendeteksi tinggi keyboard agar form ikut naik
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      // SingleChildScrollView agar form bisa di-scroll jika layar HP kecil
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Form menyesuaikan tinggi kontennya
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Pop-up
            const Text(
              'Tambah Pemasukan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Form 1: Input Nominal
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Blokir ketikan huruf
                PemisahRibuanFormatter(), // Aktifkan titik otomatis
              ],
              decoration: InputDecoration(
                labelText: 'Nominal',
                prefixText: 'Rp ', 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ), // Keyboard angka
            ),
            const SizedBox(height: 16),

            // Form 2: Input Nama Pemasukan
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Pemasukan',
                hintText: 'Contoh: Uang jajan bulanan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Form 3: Pilihan Kategori (Dropdown)
            DropdownButtonFormField<String>(
              
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              value: kategoriTerpilih,
              items: daftarKategori.map((String kategori) {
                return DropdownMenuItem(value: kategori, child: Text(kategori));
              }).toList(),
              onChanged: (String? nilaiBaru) {
                // setState memperbarui layar saat kategori dipilih
                setState(() {
                  kategoriTerpilih = nilaiBaru;
                });
              },
            ),
            const SizedBox(height: 16),

            // Form 4: Input Catatan Opsional
            TextField(
              controller: catatanController,
              decoration: InputDecoration(
                labelText: 'Catatan (Opsional)',
                hintText: 'Opsional: Sumber dana',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),

            // Baris Tombol Aksi (Batal & Simpan)
            Row(
              children: [
                // Tombol Batal
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Menutup bottom sheet
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red, // Teks merah
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Batal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Tombol Simpan
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                      
                      final dataBaru = {
                        'jenis': 'pemasukan', // (atau 'pengeluaran')
                        'nominal': int.tryParse(nominalController.text.replaceAll('.', '')) ?? 0, 
                        'nama': namaController.text,
                        'kategori': kategoriTerpilih ?? 'Lainnya',
                        'catatan': catatanController.text,
                      };
                      Navigator.pop(context, dataBaru); // Menutup bottom sheet setelah simpan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700, // Latar biru
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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

// Stateful Widget khusus untuk Pop-up Form Pengeluaran
class FormPengeluaran extends StatefulWidget {
  const FormPengeluaran({super.key});

  @override
  State<FormPengeluaran> createState() => _FormPengeluaranState();
}

class _FormPengeluaranState extends State<FormPengeluaran> {
  // State untuk menyimpan kategori pengeluaran
  String? kategoriTerpilih;

  final TextEditingController nominalController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  
  final List<String> daftarKategori = [
    'Makan & Minum',
    'Hobi',
    'Pakaian',
    'Sparepart Motor',
    'Lainnya'
  ];

// membuang controller demi effiesiensi memory
  @override
  void dispose() {
    nominalController.dispose();
    namaController.dispose();
    catatanController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    // Container pembungkus utama form
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // Padding dinamis agar tidak tertutup keyboard
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Tinggi menyesuaikan isi
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Pop-up Pengeluaran
            const Text(
              'Catat Pengeluaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Form Input Nominal
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number, 
                            inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Blokir ketikan huruf
                PemisahRibuanFormatter(), // Aktifkan titik otomatis
              ],
              decoration: InputDecoration(
                labelText: 'Nominal',
                prefixText: 'Rp ', 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Form Input Nama Pengeluaran
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Pengeluaran',
                hintText: 'Contoh: Beli eartips Final Type E', 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown Pilihan Kategori
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              value: kategoriTerpilih,
              items: daftarKategori.map((String kategori) {
                return DropdownMenuItem(value: kategori, child: Text(kategori));
              }).toList(),
              onChanged: (String? nilaiBaru) {
                setState(() {
                  kategoriTerpilih = nilaiBaru;
                });
              },
            ),
            const SizedBox(height: 16),

            // Form Input Catatan Opsional
            TextField(
              controller: catatanController,
              decoration: InputDecoration(
                labelText: 'Catatan (Opsional)',
                hintText: 'Jelaskan urgensi secara singkat', // Sesuai spesifikasimu untuk mengerem pemborosan
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),

            // Baris Tombol Aksi
            Row(
              children: [
                // Tombol Batal
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Menutup form
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red, // Warna peringatan
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Batal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Tombol Simpan
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 3. Kemas semua data yang diketik ke dalam satu wadah (Map)
                        final dataBaru = {
                        'jenis': 'pengeluaran', // (atau 'pengeluaran')
                        'nominal': int.tryParse(nominalController.text.replaceAll('.', '')) ?? 0, 
                        'nama': namaController.text,
                        'kategori': kategoriTerpilih ?? 'Lainnya',
                        'catatan': catatanController.text,
                      };
                      // TODO: Logika pengurangan saldo
                      Navigator.pop(context, dataBaru); // Menutup form setelah simpan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700, 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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

// Mesin otomatis pembuat titik ribuan
class PemisahRibuanFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    //Buang semua karakter yang bukan angka
    String angkaHanya = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Tambahkan titik setiap 3 digit dari belakang
    String hasil = '';
    for (int i = 0; i < angkaHanya.length; i++) {
      if (i > 0 && (angkaHanya.length - i) % 3 == 0) {
        hasil += '.';
      }
      hasil += angkaHanya[i];
    }

    //Tampilkan hasilnya ke layar
    return TextEditingValue(
      text: hasil,
      selection: TextSelection.collapsed(offset: hasil.length),
    );
  }
}