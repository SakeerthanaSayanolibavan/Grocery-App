import 'package:flutter/material.dart';

// ===== Chinna helpers (ellaa screen-layum use aagum) =====
const bold = FontWeight.bold, semi = FontWeight.w600;
TextStyle ts(double s, {FontWeight? w, Color? c, double? h}) => TextStyle(fontSize: s, fontWeight: w, color: c, height: h);
Widget sp(double n) => SizedBox(width: n, height: n);
Widget div([double h = 1]) => Divider(color: Colors.grey.shade300, height: h);
Widget arrow([IconData i = Icons.keyboard_arrow_right]) => Icon(i, color: Colors.black, size: 22);
Widget pic(String p, {double? w, double? h, IconData ic = Icons.image_not_supported, double s = 40, Color c = Colors.grey}) =>
    Image.asset(p, width: w, height: h, fit: BoxFit.contain, errorBuilder: (_, __, ___) => Icon(ic, size: s, color: c));
Widget gBtn(String t, VoidCallback f, {double h = 52, double r = 14}) => SizedBox(
    width: double.infinity,
    height: h,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r))),
        onPressed: f,
        child: Text(t, style: ts(16, w: semi, c: Colors.white))));

// Figma maathiri status bar (time, signal, wifi, battery)
class FakeStatusBar extends StatelessWidget {
  const FakeStatusBar({super.key});
  @override
  Widget build(BuildContext context) => const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("9:41", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
        IconTheme(
            data: IconThemeData(color: Colors.black, size: 16),
            child: Row(children: [Icon(Icons.signal_cellular_alt), SizedBox(width: 5), Icon(Icons.wifi), SizedBox(width: 5), Icon(Icons.battery_full)])),
      ]);
}