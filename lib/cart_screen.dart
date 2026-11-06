import 'package:flutter/material.dart';
import 'helpers.dart';
import 'product.dart';
import 'order_accepted_screen.dart';

// ===== 3. CART SCREEN (My Cart + Checkout sheet) =====
class CartScreen extends StatefulWidget {
  final Product p;
  final int qty;
  const CartScreen({super.key, required this.p, required this.qty});
  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  late int _qty = widget.qty;
  bool _removed = false;
  double get _total => widget.p.unit * _qty;

  @override
  void initState() {
    super.initState();
    // Cart open aana udane Checkout sheet mela varum
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkout();
    });
  }

  void _checkout() {
    if (_removed) return;
    const dark = TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (sc) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Checkout", style: ts(22, w: bold)),
              InkWell(onTap: () => Navigator.pop(sc), child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.close, size: 26))),
            ]),
            sp(8), div(16),
            _crow("Delivery", Text("Select Method", style: ts(14, w: semi))),
            _crow("Payment", const Icon(Icons.credit_card, color: Colors.blue, size: 22)),
            _crow("Promo Code", Text("Pick discount", style: ts(14, w: semi))),
            _crow("Total Cost", Text("\$${_total.toStringAsFixed(2)}", style: ts(14, w: semi)), false),
            sp(12),
            Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(style: ts(12, c: Colors.grey, h: 1.5), children: const [
                  TextSpan(text: "By placing an order you agree to our\n"),
                  TextSpan(text: "Terms", style: dark),
                  TextSpan(text: " And "),
                  TextSpan(text: "Conditions", style: dark),
                ]))),
            sp(20),
            gBtn("Place Order", () {
              Navigator.pop(sc);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const OrderAcceptedScreen()), (r) => false);
            }, h: 54, r: 15),
          ]),
        ),
      ),
    );
  }

  Widget _crow(String l, Widget t, [bool line = true]) => Column(children: [
        InkWell(
            onTap: () {},
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(children: [Text(l, style: ts(15, c: Colors.grey)), const Spacer(), t, sp(6), arrow()]))),
        if (line) div(),
      ]);

  Widget _qb(IconData i, Color c, VoidCallback f) => InkWell(
      onTap: f,
      borderRadius: BorderRadius.circular(12),
      child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
          child: Icon(i, color: c, size: 20)));

  @override
  Widget build(BuildContext context) {
    final p = widget.p;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(20, 8, 20, 0), child: FakeStatusBar()),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20), onPressed: () => Navigator.pop(context)),
                Expanded(child: Center(child: Text("My Cart", style: ts(20, w: bold)))),
                const SizedBox(width: 48),
              ])),
          div(),
          Expanded(
            child: _removed
                ? Center(child: Text("Your cart is empty", style: ts(16, c: Colors.grey)))
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        pic(p.path, w: 70, h: 70),
                        sp(16),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(p.title, style: ts(16, w: bold)),
                                sp(4),
                                Text(p.sub, style: ts(13, c: Colors.grey)),
                              ])),
                              InkWell(
                                  onTap: () => setState(() => _removed = true),
                                  child: const Padding(padding: EdgeInsets.all(2), child: Icon(Icons.close, color: Colors.grey, size: 22))),
                            ]),
                            sp(14),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Row(children: [
                                _qb(Icons.remove, Colors.grey, () {
                                  if (_qty > 1) setState(() => _qty--);
                                }),
                                Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Text("$_qty", style: ts(16, w: semi))),
                                _qb(Icons.add, Colors.green, () => setState(() => _qty++)),
                              ]),
                              Text("\$${_total.toStringAsFixed(2)}", style: ts(16, w: bold)),
                            ]),
                          ]),
                        ),
                      ]),
                    ),
                  ),
          ),
          if (!_removed) Padding(padding: const EdgeInsets.fromLTRB(20, 6, 20, 14), child: gBtn("Go to Checkout", _checkout)),
        ]),
      ),
    );
  }
}