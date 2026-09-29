import 'package:flutter/material.dart';

// Halaman Profil untuk melengkapi NavigationBar
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Kerangka utama halaman yang menyediakan ruang untuk body dan bottom navigation
    return Scaffold(
      // backgroundColor: Mengatur warna latar belakang halaman menjadi putih
      backgroundColor: Colors.white,
      
      // SafeArea: Memastikan konten widget tidak tertutup oleh poni layar  atau status bar HP
      body: SafeArea(
        
        // SingleChildScrollView: Membuat halaman bisa digulir  jika konten melebihi tinggi layar
        child: SingleChildScrollView(
          
          // Padding: Memberikan jarak di sekeliling konten halaman
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            
            // Column: Menyusun widget anak-anaknya secara vertikal
            child: Column(
              children: [
                
                // Stack: Menumpuk beberapa widget pada area koordinat yang sama 
                Stack(
                  children: [
                    
                    // Container: Membungkus gambar agar ukurannya bisa dibatasi dengan pas
                    Container(
                      width: 120,
                      height: 120,
                      
                      // ClipRRect: Memotong ujung gambar agar menjadi bentuk lingkaran (opsional estetika)
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      
                      // Image.asset: Menampilkan gambar dari folder lokal komputer 
                      child: Image.asset(
                        'assets/product.png', 
                        fit: BoxFit.cover, // Memastikan gambar menutupi seluruh area tanpa distorsi
                      ),
                    ),
                    
                    // Positioned: Mengatur posisi mutlak suatu widget di dalam Stack 
                    Positioned(
                      bottom: 0, // Ditempelkan ke ujung bawah
                      right: 0,  // Ditempelkan ke ujung kanan
                      
                      // Container: Berfungsi sebagai latar belakang melingkar untuk ikon edit
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          
                          // BoxShadow: Memberikan efek bayangan agar ikon tampak timbul/3D (Syarat Modul 3)
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 6,
                              offset: const Offset(0, 2), // Menggeser bayangan sedikit ke bawah
                            ),
                          ],
                        ),
                        
                        // Icon: Menampilkan ikon pensil (edit) di antarmuka
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                
                // SizedBox: Memberikan jarak vertikal kosong antar elemen
                const SizedBox(height: 24),
                
                // Text: Menampilkan teks statis berupa nama akun pembeli
                const Text(
                  'Yang katanya mau hemat',
                  // TextStyle: Mengatur gaya tulisan seperti ukuran dan ketebalan
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                
                const SizedBox(height: 32),

                // Container: Berfungsi sebagai kartu putih tempat menaruh formulir
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    
                    // BoxShadow: Efek bayangan pada kartu agar tampak terpisah dari latar belakang utama
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  
                  // Column: Menyusun teks judul dan input form dari atas ke bawah
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // Text: Judul bagian formulir input
                      const Text(
                        'Target nabung bulan ini',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // TextField: Kolom input agar pengguna dapat mengetik angka 
                      TextField(
                        keyboardType: TextInputType.number, // Memunculkan keyboard khusus angka
                        
                        // InputDecoration: Mengatur dekorasi di dalam kolom input
                        decoration: InputDecoration(
                          hintText: 'Misal: Rp 100.000.000', // Teks bantuan transparan
                          
                          // OutlineInputBorder: Memberikan garis pinggir melingkar pada kolom
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),

                // ElevatedButton: Tombol aksi utama dengan efek timbul solid
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push: Berpindah ke halaman baru, menumpuk halaman saat ini 
                    Navigator.push(
                      context,
                      // MaterialPageRoute: Menangani transisi/animasi pergerakan rute halaman baru
                      MaterialPageRoute(builder: (context) => const BantuanPage()),
                    );
                  },
                  
                  // ButtonStyle: Mengatur gaya warna dan ukuran tombol
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50), // Memanjangkan tombol selebar layar
                  ),
                  
                  // Text: Teks label di dalam tombol
                  child: const Text('Pusat Bantuan'),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // NavigationBar: Menu navigasi bagian bawah layar yang menghubungkan halaman 
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: 2, // 2 artinya posisi aktif berada di ikon Profil 
        
        onDestinationSelected: (index) {
          // Logika sederhana: jika pengguna memencet tombol Beranda, kembali ke halaman sebelumnya
          if (index == 0) {
            // Navigator.pop: Membuang halaman profil dari memori dan mundur ke Beranda 
            Navigator.pop(context);
          }
        },
        
        // destinations: Daftar tombol ikon pada menu bawah
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// Halaman Dummy (Pusat Bantuan) untuk membuktikan fitur Navigator.pop berfungsi bolak-balik
class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Kerangka halaman bantuan
    return Scaffold(
      // AppBar: Bilah judul di bagian paling atas aplikasi
      appBar: AppBar(title: const Text('Bantuan Sisa Rasa')),
      
      // Center: Meletakkan widget anaknya tepat di tengah-tengah layar
      body: Center(
        
        // ElevatedButton: Tombol timbul
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pop: Menutup halaman Bantuan dan mengembalikan pengguna ke Profil 
            Navigator.pop(context);
          },
          // Text: Label di dalam tombol
          child: const Text('Kembali ke Profil'),
        ),
      ),
    );
  }
}