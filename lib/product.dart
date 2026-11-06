// ===== Product data (pudhu product = 1 line) =====
class Product {
  final String title, sub, price, file;
  const Product(this.title, this.sub, this.price, this.file);
  String get path => "assets/images/$file";
  double get unit => double.tryParse(price.replaceAll('\$', '')) ?? 0;
}

const exclusive = [
  Product("Organic Bananas", "7pcs, Priceg", "\$2.99", "banana.png"),
  Product("Naturel Red Apple", "1kg, Priceg", "\$4.99", "apple.png"),
  Product("Fresh Orange", "1kg, Priceg", "\$3.99", "orange.png"),
  Product("Fresh Strawberry", "250g, Priceg", "\$4.49", "strawberry.png"),
  Product("Fresh Mango", "1kg, Priceg", "\$5.99", "mango.png"),
];
const bestSelling = [
  Product("Bell Pepper Red", "1kg, Priceg", "\$3.49", "bellpepper.png"),
  Product("Fresh Ginger", "250g, Priceg", "\$1.99", "gingger.png"),
  Product("Fresh Chilli", "100g, Priceg", "\$1.49", "chilli.png"),
  Product("Cinnamon Sticks", "50g, Priceg", "\$2.49", "cinnamon.png"),
];
const groceries = [
  Product("Beef Bone", "1kg, Priceg", "\$4.99", "100beef.png"),
  Product("Broiler Chicken", "1kg, Priceg", "\$4.99", "chicken.png"),
  Product("Fresh Fish", "1kg, Priceg", "\$5.49", "fish.png"),
  Product("Fresh Prawns", "500g, Priceg", "\$7.99", "prawns.png"),
];
const banners = [
  ["Fresh Vegetables", "Get Up to 40% OFF", "banner1.jpg"],
  ["Fresh Fruits", "Special Discount Today", "banner2.jpg"],
  ["Organic Products", "100% Natural Quality", "banner3.jpg"],
];