// import 'package:flutter/material.dart';
// import 'package:myapp/project/Browse_student.dart';
// import 'register.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();

//   void btnlogin() {
//     if (username.text == "admin" && password.text == "1111") {
       
//     } else {
      
//     }
//   }


//   final Color bgColord = const Color(0XFF8EACCD);
//   final Color primaryColor = const Color(0xFFFEF9D9);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColord,
//       body: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 60), // Adjusting top space

//               // Logo
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Image.asset(
//                   'assets/images/logo-bookingroom.png',
//                   width: 180, // Adjusted width for better alignment
//                   height: 100, // Adjusted height
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(height: 10),

//               // Login Container
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Card(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   elevation: 8,
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         // Username TextField
//                         TextField(
//                           controller: username,
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(Icons.person),
//                             labelText: 'Username',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Password TextField
//                         TextField(
//                           obscureText: true,
//                           controller: password,
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(Icons.lock),
//                             labelText: 'Password',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),

//                         // Register Text with Navigator to Register page
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: GestureDetector(
//                             onTap: () {
//                               // Navigate to Register page when tapped
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const RegisterPage()), // Assuming RegisterPage exists
//                               );
//                             },
//                             child: const Text(
//                               "Don't have an account? Register",
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Login Button
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: const Size(double.infinity, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           onPressed: () async {
//                             await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const BrowseStudent(),
//                                 ));
//                             setState(() {});
//                           },
//                           child: const Text(
//                             'Login',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Bottom Image
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Image.asset(
//                     'assets/images/management.png',
//                     width: double.infinity,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Placeholder for RegisterPage
// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Register')),
//       body: Center(child: const Text('Register Page')),
//     );
//   }
// }
