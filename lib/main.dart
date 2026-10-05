import 'package:flutter/material.dart';
import 'profile_card.dart';

/// Ganti dengan NIM dan data dirimu
const String nimSaya = '20240801222';
const String namaSaya = 'Deswinta Dwi Putri';
const String hobiSaya = 'Mendesain';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// Digit terakhir NIM genap → amber, ganjil → teal
  bool get nimGenap => int.parse(nimSaya[nimSaya.length - 1]) % 2 == 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Praktikan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Digit terakhir NIM ganjil → teal muda, genap → amber muda
        scaffoldBackgroundColor:
        nimGenap ? Colors.amber[100] : Colors.tealAccent[100],
      ),
      home: Scaffold(
        body: Center(
          child: ProfileCard(
            nama: namaSaya,
            nim: nimSaya,
            hobi: hobiSaya,
            skorAktivitas: ProfileCard.hitungSkor(nimSaya),
          ),
        ),
      ),
    );
  }
}