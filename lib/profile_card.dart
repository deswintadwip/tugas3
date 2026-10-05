import 'package:flutter/material.dart';

/// Kartu identitas praktikan.
/// Semua ukuran styling DIHITUNG dari digit NIM (bukan angka hardcoded).
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  });

  // ---------- Ambil digit dari NIM ----------

  /// Digit paling belakang. Contoh NIM 20240801222 → 2
  int get digitTerakhir => int.parse(nim[nim.length - 1]);

  /// Digit ke-2 dari belakang. Contoh NIM 20240801222 → 2
  int get digitKeduaDariBelakang => int.parse(nim[nim.length - 2]);

  // ---------- Rumus styling (sesuai ketentuan) ----------

  /// Lebar kartu = 320 + (digit ke-2 dari belakang × 5)
  double get lebarKartu => 320.0 + (digitKeduaDariBelakang * 5);

  /// Sudut lengkung = 12 + (digit terakhir × 1.5)
  double get sudutLengkung => 12.0 + (digitTerakhir * 1.5);

  /// Ukuran logo = 60 + (digit terakhir × 2)
  double get ukuranLogo => 60.0 + (digitTerakhir * 2);

  /// Jarak pemisah = 15 + digit terakhir
  double get jarakPemisah => 15.0 + digitTerakhir;

  /// Skor aktivitas = (2 digit terakhir NIM) + 50
  static int hitungSkor(String nim) =>
      int.parse(nim.substring(nim.length - 2)) + 50;

  @override
  Widget build(BuildContext context) {
    // Root kartu: Container + BoxDecoration
    return Container(
      width: lebarKartu,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sudutLengkung),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15), // hitam transparan
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Header kartu (horizontal) =====
          Row(
            children: [
              // Kiri: FlutterLogo dalam bingkai lengkung
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sudutLengkung),
                  border: Border.all(color: Colors.blue.shade100, width: 2),
                ),
                child: FlutterLogo(size: ukuranLogo),
              ),
              // Jarak pemisah horizontal
              SizedBox(width: jarakPemisah),
              // Kanan: judul + nama
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kartu Praktikan',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nama,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ===== Pemisah =====
          const SizedBox(height: 12),
          const Divider(thickness: 1.5),
          const SizedBox(height: 12),

          // ===== Detail identitas (vertikal) =====
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _baris('NIM', nim),
              _baris('Hobi', hobi),
              _baris('Skor Aktivitas', '$skorAktivitas'),
            ],
          ),
        ],
      ),
    );
  }

  /// Satu baris detail: label di kiri, nilai di kanan
  Widget _baris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Text(': $nilai',
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}