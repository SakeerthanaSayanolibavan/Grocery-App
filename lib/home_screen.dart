import 'package:flutter/material.dart';
import 'helpers.dart';
import 'product.dart';
import 'product_detail_screen.dart';

// ===== 1. HOME SCREEN =====
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0, _page = 0;
  final _pc = PageController();

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> prods(List<Product> l) => [for (final p in l) _card(context, p)];
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          // FIXED HEADER
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const FakeStatusBar(), sp(20),
              Center(child: pic('assets/images/carrot.png', w: 32, h: 38, ic: Icons.eco, s: 32, c: Colors.orange)), sp(10),
              const Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 4),
                Text("Dhaka, Banasree", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600)),
              ])),
              sp(15),
              TextField(
                  decoration: InputDecoration(
                      hintText: "Search Store",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none))),
              sp(20),
              SizedBox(
                height: 125,
                child: Column(children: [
                  Expanded(
                      child: PageView(
                          controller: _pc,
                          onPageChanged: (i) => setState(() => _page = i),
                          children: [for (final b in banners) _banner(b[0], b[1], "assets/images/${b[2]}")])),
                  sp(8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (i) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _page == i ? 16 : 6,
                              height: 6,
                              decoration: BoxDecoration(color: _page == i ? Colors.green : Colors.grey[300], borderRadius: BorderRadius.circular(3))))),
                ]),
              ),
            ]),
          ),
          // SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ..._section("Exclusive Offer", prods(exclusive)), sp(20),
                ..._section("Best Selling", prods(bestSelling)), sp(20),
                ..._section("Groceries", [
                  _cat("Pulses", Colors.orange.shade100, "Pulses.png"),
                  _cat("Rice", Colors.amber.shade100, "rice.png"),
                  _cat("Lentils", Colors.brown.shade100, "lentils.png"),
                ], 105),
                sp(15),
                _hList(220, prods(groceries)),
              ]),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}

Widget _hList(double h, List<Widget> items) => SizedBox(
    height: h,
    child: ListView.separated(
        scrollDirection: Axis.horizontal, itemCount: items.length, separatorBuilder: (_, __) => const SizedBox(width: 15), itemBuilder: (_, i) => items[i]));

List<Widget> _section(String t, List<Widget> items, [double h = 220]) => [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(t, style: ts(18, w: bold)),
        TextButton(onPressed: () {}, child: const Text("See all", style: TextStyle(color: Colors.green))),
      ]),
      sp(10),
      _hList(h, items),
    ];

Widget _banner(String t, String s, String bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(bg), fit: BoxFit.cover, onError: (e, st) {})),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: ts(20, w: bold, c: Colors.green)),
      sp(4),
      Text(s, style: ts(14, w: FontWeight.w500, c: Colors.black54)),
    ]));

Widget _cat(String t, Color c, String f) => Container(
    width: 200,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(15)),
    child: Row(children: [pic("assets/images/$f", w: 55, h: 55), sp(12), Text(t, style: ts(16, w: bold, c: Colors.black87))]));

Widget _card(BuildContext c, Product p) => GestureDetector(
    onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => ProductDetailScreen(p: p))),
    child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Center(child: pic(p.path))),
          sp(8),
          Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(14, w: bold)),
          Text(p.sub, style: ts(12, c: Colors.grey)),
          sp(8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(p.price, style: ts(16, w: bold)),
            Container(
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                child: IconButton(icon: const Icon(Icons.add, color: Colors.white, size: 18), onPressed: () {})),
          ]),
        ])));