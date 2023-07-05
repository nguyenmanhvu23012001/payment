import 'package:flutter/material.dart';
import 'package:intermediary_transaction/Providers/history_provider.dart';
import 'package:intermediary_transaction/Providers/transaction_provider.dart';
import 'package:intermediary_transaction/Providers/walletbalance_provider.dart';
import 'package:intermediary_transaction/screens/history_page.dart';
import 'package:intermediary_transaction/screens/home_bottombar.dart';
import 'package:intermediary_transaction/screens/home_page.dart';
import 'package:intermediary_transaction/screens/login_page.dart';
import 'package:intermediary_transaction/screens/transaction_page.dart';
import 'package:intermediary_transaction/screens/walletbalance_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_auth/auth_page.dart';

import 'firebase_options.dart';

// void main() {
//   runApp(MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home:LoginPage(),
    // );
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TransactionProvider>(create: (_) => TransactionProvider()),
          ChangeNotifierProvider<HistoryProvider>(create: (_) => HistoryProvider()),
          ChangeNotifierProvider<WalletBalanceProvider>(create: (_) => WalletBalanceProvider()),
        ],
    child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  Scaffold(
            body: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Home();
                  }else{
                    return AuthPage();
                  }
                }

            ),
          ),

    ));

  }
}
