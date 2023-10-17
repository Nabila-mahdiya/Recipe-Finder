import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RecipeFinderHome.dart';

// void main() => runApp(MyApp());

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
        
          children: <Widget>[
            Image.asset(
              'images/ibu_bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Recipe Finder',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Discover Endless Culinary Possibilities',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 370),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi yang akan dilakukan saat tombol ditekan
                      Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RecipeFinderHome()),
                                  );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD76249),
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// void main() {
//   runApp(DailyBoostApp());
// }

// class DailyBoostApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//   }
// }

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'DailyBoost',
//           style: GoogleFonts.playfairDisplay(
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           // style:TextStyle(
//           //       fontSize: 30.0,
//           //       fontWeight: FontWeight.bold,
//           //       color: Colors.white,
//           // )
//           ),
//         backgroundColor: Color.fromARGB(255, 236, 103, 183),
        
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Judul Halaman
//             Text(
//               'Selamat Datang di DailyBoost',
//               style: GoogleFonts.playfairDisplay(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//             color: const Color(0xFFEC67B7), 
//           ),
//               // style: TextStyle(
//               //   fontFamily: 'Saturday6',
//               //   fontSize: 24.0,
//               //   fontWeight: FontWeight.bold,
//               //  color: const Color(0xFFEC67B7), 
//               // ),
//             ),
//             SizedBox(height: 20.0),

//             // Kotak Teks "Nama Pengguna"
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Nama Pengguna',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),

//             // Kotak Teks "Kata Sandi"
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Kata Sandi',
//                 border: OutlineInputBorder(),
//               ),
//               obscureText: true, // Untuk menyembunyikan kata sandi
//             ),
//             SizedBox(height: 24.0),

//             // Tombol "Login"
//             ElevatedButton(
//               onPressed: () {
//                 // Tambahkan logika autentikasi di sini
//                 // Misalnya, validasi nama pengguna dan kata sandi
//               },
//               child: Text('Login'),
              
//               style: ElevatedButton.styleFrom(
//                 primary: Color.fromARGB(255, 236, 103, 183), // Warna tombol
//                 onPrimary: Colors.white, // Warna teks
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
