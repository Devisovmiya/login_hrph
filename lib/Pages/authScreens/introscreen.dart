import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/riverpod_provider/provider/auth_provider/theme_auth_provider.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends ConsumerWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('assets/images/dailyhub.png',
                height: 100,
                width: 100,
                ),
                SizedBox(width: 10,),
                Text(
                  'Daily Hub',
                  style: TextStyle(
                    fontSize: 45,
                    color: const Color.fromARGB(255, 48, 61, 136),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            //animation
            Expanded(
              flex: 3,
              child: Center(
                child: Lottie.asset(
                  'assets/animation/intro.json',
                  width: 300,
                  height: 300,
                ),
              ),
            ),

            Spacer(),

           
            TextButton.icon(
              onPressed: () {
                ref.read(authProvider.notifier).goToLogin();
              },
              label: Text('Registered User', style: TextStyle(fontSize: 16)),
              icon: Icon(Icons.login_rounded),
            ),


             SizedBox(height: 10,),


              TextButton.icon(
              onPressed: () {
                ref.read(authProvider.notifier).goToSignup();
              },
              label: Text('Not a Member', style: TextStyle(fontSize: 16)),
              icon: Icon(Icons.app_registration_outlined),
            ),
           

          ],
        ),
      ),
    );
  }
}
