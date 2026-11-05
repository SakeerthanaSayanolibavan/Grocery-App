import 'package:flutter/material.dart';

void main() {
  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Groceries',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

// 1. HOME SCREEN
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  int _currentBannerIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== FIXED HEADER (carrot, location, search, banner) =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phone Status Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "9:41",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.signal_cellular_alt,
                              size: 16, color: Colors.black),
                          SizedBox(width: 5),
                          Icon(Icons.wifi, size: 16, color: Colors.black),
                          SizedBox(width: 5),
                          Icon(Icons.battery_full,
                              size: 16, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Carrot Logo
                  Center(
                    child: Image.asset(
                      'assets/images/carrot.png',
                      width: 32,
                      height: 38,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.eco,
                              color: Colors.orange, size: 32),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Location Row
                  const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: Colors.red),
                        SizedBox(width: 4),
                        Text(
                          "Dhaka, Banasree",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search Store",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Banner (fixed)
                  SizedBox(
                    height: 125,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentBannerIndex = index;
                              });
                            },
                            children: [
                              _buildBannerCard(
                                  "Fresh Vegetables",
                                  "Get Up to 40% OFF",
                                  "assets/images/banner1.jpg"),
                              _buildBannerCard(
                                  "Fresh Fruits",
                                  "Special Discount Today",
                                  "assets/images/banner2.jpg"),
                              _buildBannerCard(
                                  "Organic Products",
                                  "100% Natural Quality",
                                  "assets/images/banner3.jpg"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              width: _currentBannerIndex == index ? 16 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _currentBannerIndex == index
                                    ? Colors.green
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ===== SCROLLABLE CONTENT =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exclusive Offer
                    _buildSectionHeader("Exclusive Offer"),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildProductCard(
                            context,
                            title: "Organic Bananas",
                            subtitle: "7pcs, Priceg",
                            price: "\$2.99",
                            imagePath: "assets/images/banana.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Naturel Red Apple",
                            subtitle: "1kg, Priceg",
                            price: "\$4.99",
                            imagePath: "assets/images/apple.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Fresh Orange",
                            subtitle: "1kg, Priceg",
                            price: "\$3.99",
                            imagePath: "assets/images/orange.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Fresh Strawberry",
                            subtitle: "250g, Priceg",
                            price: "\$4.49",
                            imagePath: "assets/images/strawberry.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Fresh Mango",
                            subtitle: "1kg, Priceg",
                            price: "\$5.99",
                            imagePath: "assets/images/mango.png",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Best Selling
                    _buildSectionHeader("Best Selling"),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildProductCard(
                            context,
                            title: "Bell Pepper Red",
                            subtitle: "1kg, Priceg",
                            price: "\$3.49",
                            imagePath: "assets/images/bellpepper.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Fresh Ginger",
                            subtitle: "250g, Priceg",
                            price: "\$1.99",
                            imagePath: "assets/images/gingger.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Fresh Chilli",
                            subtitle: "100g, Priceg",
                            price: "\$1.49",
                            imagePath: "assets/images/chilli.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Cinnamon Sticks",
                            subtitle: "50g, Priceg",
                            price: "\$2.49",
                            imagePath: "assets/images/cinnamon.png",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Groceries
                    _buildSectionHeader("Groceries"),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 105,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryCard(
                            title: "Pulses",
                            color: Colors.orange.shade100,
                            imagePath: "assets/images/Pulses.png",
                          ),
                          const SizedBox(width: 15),
                          _buildCategoryCard(
                            title: "Rice",
                            color: Colors.amber.shade100,
                            imagePath: "assets/images/rice.png",
                          ),
                          const SizedBox(width: 15),
                          _buildCategoryCard(
                            title: "Lentils",
                            color: Colors.brown.shade100,
                            imagePath: "assets/images/lentils.png",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildProductCard(
                            context,
                            title: "Beef Bone",
                            subtitle: "1kg, Priceg",
                            price: "\$4.99",
                            imagePath: "assets/images/100beef.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Broiler Chicken",
                            subtitle: "1kg, Priceg",
                            price: "\$4.99",
                            imagePath: "assets/images/chicken.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Fresh Fish",
                            subtitle: "1kg, Priceg",
                            price: "\$5.49",
                            imagePath: "assets/images/fish.png",
                          ),
                          const SizedBox(width: 15),
                          _buildProductCard(
                            context,
                            title: "Fresh Prawns",
                            subtitle: "500g, Priceg",
                            price: "\$7.99",
                            imagePath: "assets/images/prawns.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  // Section header (title + See all)
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("See all", style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

  // Banner Card Widget
  Widget _buildBannerCard(String title, String subtitle, String bgImagePath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(bgImagePath),
          fit: BoxFit.cover,
          onError: (error, stackTrace) {},
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Category Card
  Widget _buildCategoryCard(
      {required String title,
      required Color color,
      required String imagePath}) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 55,
            height: 55,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported, size: 40),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Product Card
  Widget _buildProductCard(BuildContext context,
      {required String title,
      required String subtitle,
      required String price,
      required String imagePath}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              title: title,
              subtitle: subtitle,
              price: price,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 2. PRODUCT DETAIL SCREEN
class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _isFavourite = false;
  bool _showDetail = true;

  double get _unitPrice =>
      double.tryParse(widget.price.replaceAll('\$', '')) ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ===== Top image area =====
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F3F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.black, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.ios_share,
                                color: Colors.black, size: 22),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Image.asset(
                          widget.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported,
                                  size: 60, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          ),

          // ===== Details =====
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + favourite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.subtitle,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isFavourite = !_isFavourite;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          _isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _isFavourite ? Colors.red : Colors.grey,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Quantity + price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_quantity > 1) {
                              setState(() {
                                _quantity--;
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.remove,
                                color: Colors.grey, size: 22),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 38,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "$_quantity",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.add,
                                color: Colors.green, size: 22),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${(_unitPrice * _quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.grey.shade300, height: 1),

                // Product Detail
                InkWell(
                  onTap: () {
                    setState(() {
                      _showDetail = !_showDetail;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Product Detail",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          _showDetail
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: Colors.black,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_showDetail)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "${widget.title} is fresh and nutritious. It may be good for your health. As part of a healthful and varied diet.",
                      style: const TextStyle(
                          color: Colors.grey, height: 1.5, fontSize: 12),
                    ),
                  ),
                Divider(color: Colors.grey.shade300, height: 1),

                // Nutritions
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Nutritions",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "100gr",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black, size: 22),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300, height: 1),

                // Review
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Review",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => const Icon(Icons.star,
                                color: Colors.deepOrange, size: 15),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black, size: 22),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== Add To Basket button =====
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  // ===== MAATHINADHU: Cart + Checkout page-ku pogum =====
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          title: widget.title,
                          subtitle: widget.subtitle,
                          unitPrice: _unitPrice,
                          imagePath: widget.imagePath,
                          quantity: _quantity,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Add To Basket",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. CART SCREEN (My Cart + Checkout bottom sheet)
class CartScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final double unitPrice;
  final String imagePath;
  final int quantity;

  const CartScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.unitPrice,
    required this.imagePath,
    required this.quantity,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int _quantity;
  bool _removed = false;

  double get _total => widget.unitPrice * _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
    // Cart open aana udane Checkout sheet mela varum (Figma maathiri)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _showCheckout();
    });
  }

  void _showCheckout() {
    if (_removed) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title + close
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Checkout",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(sheetContext),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.close, size: 26),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: Colors.grey.shade300),

                _buildCheckoutRow(
                  "Delivery",
                  const Text("Select Method",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                _buildCheckoutRow(
                  "Payment",
                  const Icon(Icons.credit_card,
                      color: Colors.blue, size: 22),
                ),
                _buildCheckoutRow(
                  "Promo Code",
                  const Text("Pick discount",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                _buildCheckoutRow(
                  "Total Cost",
                  Text("\$${_total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  showDivider: false,
                ),
                const SizedBox(height: 12),

                // Terms
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey, height: 1.5),
                      children: [
                        TextSpan(text: "By placing an order you agree to our\n"),
                        TextSpan(
                          text: "Terms",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: " And "),
                        TextSpan(
                          text: "Conditions",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Place Order
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderAcceptedScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutRow(String label, Widget trailing,
      {bool showDivider = true}) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const Spacer(),
                trailing,
                const SizedBox(width: 6),
                const Icon(Icons.keyboard_arrow_right,
                    color: Colors.black, size: 22),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(color: Colors.grey.shade300, height: 1),
      ],
    );
  }

  Widget _qtyButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "My Cart",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300, height: 1),

            // Cart item
            Expanded(
              child: _removed
                  ? const Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                widget.imagePath,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported,
                                        size: 40, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.title,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              widget.subtitle,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _removed = true;
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.close,
                                              color: Colors.grey, size: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          _qtyButton(Icons.remove, Colors.grey,
                                              () {
                                            if (_quantity > 1) {
                                              setState(() {
                                                _quantity--;
                                              });
                                            }
                                          }),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14),
                                            child: Text(
                                              "$_quantity",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          _qtyButton(Icons.add, Colors.green,
                                              () {
                                            setState(() {
                                              _quantity++;
                                            });
                                          }),
                                        ],
                                      ),
                                      Text(
                                        "\$${_total.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),

            // Go to Checkout button (sheet-a close panninaalum thirumba open pannalam)
            if (!_removed)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _showCheckout,
                    child: const Text(
                      "Go to Checkout",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// 4. ORDER ACCEPTED SCREEN
class OrderAcceptedScreen extends StatelessWidget {
  const OrderAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Green check circle
              Container(
                width: 170,
                height: 170,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F2E9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check,
                        color: Colors.white, size: 70),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                "Your Order has been\naccepted",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Your items has been placed and is on\nit's way to being processed",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
              ),

              const Spacer(flex: 3),

              // Track Order
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Track Order",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Back to home
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Back to home",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}