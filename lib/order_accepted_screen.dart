import 'package:flutter/material.dart';
import 'helpers.dart';
import 'home_screen.dart';

// ===== 4. ORDER ACCEPTED SCREEN =====
class OrderAcceptedScreen extends StatelessWidget {
  const OrderAcceptedScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const Padding(padding: EdgeInsets.only(top: 8), child: FakeStatusBar()),
              const Spacer(flex: 2),
              Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(color: Color(0xFFE0F2E9), shape: BoxShape.circle),
                  child: Center(
                      child: Container(
                          width: 130,
                          height: 130,
                          decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                          child: const Icon(Icons.check, color: Colors.white, size: 70)))),
              sp(40),
              Text("Your Order has been\naccepted", textAlign: TextAlign.center, style: ts(26, w: bold, h: 1.3)),
              sp(14),
              Text("Your items has been placed and is on\nit's way to being processed", textAlign: TextAlign.center, style: ts(13, c: Colors.grey, h: 1.5)),
              const Spacer(flex: 3),
              gBtn("Track Order", () {}, h: 54, r: 15),
              sp(8),
              TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (r) => false),
                  child: Text("Back to home", style: ts(16, w: semi, c: Colors.black))),
              sp(14),
            ]),
          ),
        ),
      );
}