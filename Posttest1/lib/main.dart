import 'package:flutter/material.dart';

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
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // Safe area dan singleChildScrollView
      body: SafeArea(
        child: SingleChildScrollView(
          // padding
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            // Column, row serta Text
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'halo man',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Icon
                    Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Colors.blue.shade700,
                    )
                  ],
                ),
                //Sized box
                const SizedBox(height: 24,),
                // Search Section
                // Textfield
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
                const SizedBox(height: 24,),

                // Card Section
                // Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total saldo',style: TextStyle(color: Colors.white70, fontSize: 14),),
                      SizedBox(height: 8,),
                      Text('Rp.12.500.000',
                      style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              const SizedBox(height: 24,),
              // Action button
              Row(children: [
                //Expanded
                Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward,color: Colors.white,fontWeight: FontWeight.bold,),
                    SizedBox(width: 8,),
                    Text('Pemasukan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
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
                // Contoh 1 Item Transaksi 
                Container(
                  padding: const EdgeInsets.all(16),
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
      
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Statistik",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}