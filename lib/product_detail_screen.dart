import 'package:flutter/material.dart';
import 'helpers.dart';
import 'product.dart';
import 'cart_screen.dart';

// ===== 2. PRODUCT DETAIL SCREEN =====
class ProductDetailScreen extends StatefulWidget {
  final Product p;
  const ProductDetailScreen({super.key, required this.p});
  @override
  State<ProductDetailScreen> createState() => _DetailState();
}

class _DetailState extends State<ProductDetailScreen> {
  int _qty = 1;
  bool _fav = false, _show = true;
  Product get p => widget.p;

  Widget _q(IconData i, Color c, VoidCallback f) => InkWell(onTap: f, child: Padding(padding: const EdgeInsets.all(5), child: Icon(i, color: c, size: 22)));

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(children: [
        // Top image area
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFFF2F3F2), borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
            child: SafeArea(
              bottom: false,
              child: Column(children: [
                const Padding(padding: EdgeInsets.fromLTRB(20, 8, 20, 0), child: FakeStatusBar()),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20), onPressed: () => Navigator.pop(context)),
                      IconButton(icon: const Icon(Icons.ios_share, color: Colors.black, size: 22), onPressed: () {}),
                    ])),
                Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: pic(p.path, s: 60))),
                sp(8),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 16, height: 4, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2))),
                  for (var i = 0; i < 2; i++)
                    Container(width: 4, height: 4, margin: const EdgeInsets.only(left: 4), decoration: BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle)),
                ]),
                sp(14),
              ]),
            ),
          ),
        ),
        // Details
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.title, style: ts(20, w: bold)),
                sp(3),
                Text(p.sub, style: ts(13, c: Colors.grey)),
              ])),
              InkWell(
                  onTap: () => setState(() => _fav = !_fav),
                  child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(_fav ? Icons.favorite : Icons.favorite_border, color: _fav ? Colors.red : Colors.grey, size: 24))),
            ]),
            sp(14),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                _q(Icons.remove, Colors.grey, () {
                  if (_qty > 1) setState(() => _qty--);
                }),
                sp(8),
                Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                    child: Text("$_qty", style: ts(15, w: bold))),
                sp(8),
                _q(Icons.add, Colors.green, () => setState(() => _qty++)),
              ]),
              Text("\$${(p.unit * _qty).toStringAsFixed(2)}", style: ts(20, w: bold)),
            ]),
            sp(10), div(),
            _row("Product Detail", arrow(_show ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right), () => setState(() => _show = !_show)),
            if (_show)
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("${p.title} is fresh and nutritious. It may be good for your health. As part of a healthful and varied diet.", style: ts(12, c: Colors.grey, h: 1.5))),
            div(),
            _row("Nutritions", Row(children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                  child: Text("100gr", style: ts(10, c: Colors.grey))),
              sp(6),
              arrow(),
            ])),
            div(),
            _row("Review", Row(children: [...List.generate(5, (_) => const Icon(Icons.star, color: Colors.deepOrange, size: 15)), sp(6), arrow()])),
          ]),
        ),
        SafeArea(
            top: false,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
                child: gBtn("Add To Basket", () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen(p: p, qty: _qty)))))),
      ]));
}

Widget _row(String l, Widget t, [VoidCallback? f]) => InkWell(
    onTap: f,
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: ts(14, w: bold)), t])));