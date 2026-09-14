import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const BlinkitStyleApp());
}

class BlinkitStyleApp extends StatelessWidget {
  const BlinkitStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickMart Blinkit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0C831F),
          primary: const Color(0xFF0C831F),
          secondary: const Color(0xFFFFD600),
        ),
      ),
      home: const BlinkitSplashScreen(),
    );
  }
}

// 1. ANIMATED PULSE SPLASH SCREEN
class BlinkitSplashScreen extends StatefulWidget {
  const BlinkitSplashScreen({super.key});

  @override
  State<BlinkitSplashScreen> createState() => _BlinkitSplashScreenState();
}

class _BlinkitSplashScreenState extends State<BlinkitSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BlinkitHomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8CB46),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.bolt, color: Color(0xFFF8CB46), size: 58),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'quickmart',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF0C831F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'INDIA\'S 10-MINUTE GROCERY',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. PRODUCT MODEL & CATALOG
class Product {
  final String id;
  final String name;
  final String qtyUnit;
  final double price;
  final double oldPrice;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.qtyUnit,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
    required this.category,
  });
}

final List<Product> catalog = [
  Product(
    id: 'p1',
    name: 'Amul Taaza Toned Milk',
    qtyUnit: '500 ml',
    price: 27,
    oldPrice: 28,
    category: 'Dairy & Milk',
    imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400&q=80',
  ),
  Product(
    id: 'p2',
    name: 'Farm Fresh Hybrid Tomato',
    qtyUnit: '1 kg',
    price: 36,
    oldPrice: 50,
    category: 'Vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400&q=80',
  ),
  Product(
    id: 'p3',
    name: 'Aashirvaad Shudh Chakki Atta',
    qtyUnit: '5 kg',
    price: 245,
    oldPrice: 280,
    category: 'Atta & Dal',
    imageUrl: 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=400&q=80',
  ),
  Product(
    id: 'p4',
    name: 'Fresh Red Onion (Pyaaz)',
    qtyUnit: '1 kg',
    price: 42,
    oldPrice: 55,
    category: 'Vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=400&q=80',
  ),
  Product(
    id: 'p5',
    name: 'Amul Butter Salted',
    qtyUnit: '100 g',
    price: 58,
    oldPrice: 60,
    category: 'Dairy & Milk',
    imageUrl: 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=400&q=80',
  ),
  Product(
    id: 'p6',
    name: 'Lay\'s Magic Masala',
    qtyUnit: '48 g',
    price: 20,
    oldPrice: 20,
    category: 'Munchies',
    imageUrl: 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=400&q=80',
  ),
  Product(
    id: 'p7',
    name: 'Coca-Cola Can',
    qtyUnit: '300 ml',
    price: 40,
    oldPrice: 45,
    category: 'Drinks',
    imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80',
  ),
  Product(
    id: 'p8',
    name: 'Tata Sampann Toor Dal',
    qtyUnit: '1 kg',
    price: 168,
    oldPrice: 195,
    category: 'Atta & Dal',
    imageUrl: 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=400&q=80',
  ),
];

// 3. HOME SCREEN
class BlinkitHomeScreen extends StatefulWidget {
  const BlinkitHomeScreen({super.key});

  @override
  State<BlinkitHomeScreen> createState() => _BlinkitHomeScreenState();
}

class _BlinkitHomeScreenState extends State<BlinkitHomeScreen> {
  String activeCategory = 'All';
  String searchQuery = '';
  final Map<String, int> cart = {};

  final List<Map<String, dynamic>> quickCategories = [
    {'title': 'All', 'icon': Icons.apps},
    {'title': 'Vegetables', 'icon': Icons.eco},
    {'title': 'Dairy & Milk', 'icon': Icons.egg_alt},
    {'title': 'Atta & Dal', 'icon': Icons.grain},
    {'title': 'Munchies', 'icon': Icons.fastfood},
    {'title': 'Drinks', 'icon': Icons.local_bar},
  ];

  int get cartCount => cart.values.fold(0, (sum, count) => sum + count);

  double get cartTotal {
    double total = 0;
    cart.forEach((id, qty) {
      final item = catalog.firstWhere((p) => p.id == id);
      total += item.price * qty;
    });
    return total;
  }

  void add(String id) => setState(() => cart[id] = (cart[id] ?? 0) + 1);
  void remove(String id) {
    setState(() {
      if ((cart[id] ?? 0) > 1) {
        cart[id] = cart[id]! - 1;
      } else {
        cart.remove(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = catalog.where((p) {
      final matchesCat = activeCategory == 'All' || p.category == activeCategory;
      final matchesSearch = p.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCat && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(136),
        child: Container(
          color: const Color(0xFFF8CB46),
          padding: const EdgeInsets.only(top: 40, left: 14, right: 14, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Blinkit in 10 minutes',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0C831F)),
                      ),
                      Row(
                        children: [
                          Text(
                            'Delivery to Home',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.black, size: 20),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 17,
                    child: Icon(Icons.person, color: Colors.black87, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onChanged: (v) => setState(() => searchQuery = v),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black54, size: 20),
                    hintText: 'Search "milk", "atta", "chips"...',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 90),
            children: [
              // Promo Banner
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF0C831F), Color(0xFF15803D)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.bolt, color: Color(0xFFFFD600), size: 28),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('INSTANT ZERO COMMISSION', style: TextStyle(color: Color(0xFFFFD600), fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Direct UPI payment with live exact bill QR', style: TextStyle(color: Colors.white, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Horizontal Category circles
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: quickCategories.length,
                  itemBuilder: (context, i) {
                    final cat = quickCategories[i];
                    final isSel = cat['title'] == activeCategory;
                    return GestureDetector(
                      onTap: () => setState(() => activeCategory = cat['title']),
                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: isSel ? const Color(0xFFE8F5E9) : const Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSel ? const Color(0xFF0C831F) : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Icon(cat['icon'], color: isSel ? const Color(0xFF0C831F) : Colors.black87, size: 22),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cat['title'],
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                                color: isSel ? const Color(0xFF0C831F) : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                child: Text('Everyday Essentials', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              ),

              // Products Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.66,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final p = filtered[index];
                  final qty = cart[p.id] ?? 0;
                  return BlinkitItemCard(
                    product: p,
                    qty: qty,
                    onAdd: () => add(p.id),
                    onRemove: () => remove(p.id),
                  );
                },
              ),
            ],
          ),

          // Floating Green Cart Pill Bar
          if (cartCount > 0)
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlinkitCheckoutScreen(
                        cart: cart,
                        catalog: catalog,
                        subtotal: cartTotal,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C831F),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A6C19),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$cartCount ITEMS',
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '₹${cartTotal.toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Text(
                        'View Cart',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.arrow_right, color: Colors.white, size: 22),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
// 4. ITEM CARD COMPONENT
class BlinkitItemCard extends StatelessWidget {
  final Product product;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const BlinkitItemCard({
    super.key,
    required this.product,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final double discount = product.oldPrice - product.price;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: const Color(0xFFF8FAFC),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.shopping_bag_outlined, size: 36, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                if (discount > 0)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '₹${discount.toStringAsFixed(0)} OFF',
                        style: const TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 2),
                Text(
                  product.qtyUnit,
                  style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                        ),
                        if (discount > 0)
                          Text(
                            '₹${product.oldPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 9.5,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    qty == 0
                        ? OutlinedButton(
                            onPressed: onAdd,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFF0FDF4),
                              foregroundColor: const Color(0xFF0C831F),
                              side: const BorderSide(color: Color(0xFF0C831F)),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('ADD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          )
                        : Container(
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0C831F),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: onRemove,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6),
                                    child: Icon(Icons.remove, size: 13, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  '$qty',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                                ),
                                InkWell(
                                  onTap: onAdd,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6),
                                    child: Icon(Icons.add, size: 13, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 5. CHECKOUT SCREEN WITH LIVE DYNAMIC UPI QR
class BlinkitCheckoutScreen extends StatefulWidget {
  final Map<String, int> cart;
  final List<Product> catalog;
  final double subtotal;

  const BlinkitCheckoutScreen({
    super.key,
    required this.cart,
    required this.catalog,
    required this.subtotal,
  });

  @override
  State<BlinkitCheckoutScreen> createState() => _BlinkitCheckoutScreenState();
}

class _BlinkitCheckoutScreenState extends State<BlinkitCheckoutScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  final String upiId = "paytmqr2810050501011@paytm";
  final String storeName = "QuickMart Store";
  final String whatsAppNumber = "919876543210";

  final double deliveryFee = 15.0;
  double get grandTotal => widget.subtotal + deliveryFee;

  String get upiPaymentUrl {
    final amt = grandTotal.toStringAsFixed(2);
    return "upi://pay?pa=$upiId&pn=${Uri.encodeComponent(storeName)}&am=$amt&cu=INR&tn=QuickMartOrder";
  }

  Future<void> _payWithApp() async {
    final uri = Uri.parse(upiPaymentUrl);
    try {
      final done = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!done && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('UPI App not found. Please scan the QR code above!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _sendWhatsApp() async {
    if (nameCtrl.text.trim().isEmpty || phoneCtrl.text.trim().isEmpty || addressCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill Name, Phone and Delivery Address!')),
      );
      return;
    }

    final bill = StringBuffer();
    bill.writeln("🟢 *QUICKMART INSTANT ORDER* 🟢");
    bill.writeln("━━━━━━━━━━━━━━━━━━━");
    bill.writeln("Customer: ${nameCtrl.text.trim()}");
    bill.writeln("Phone: ${phoneCtrl.text.trim()}");
    bill.writeln("Address: ${addressCtrl.text.trim()}");
    bill.writeln("━━━━━━━━━━━━━━━━━━━");
    bill.writeln("*ITEMS ORDERED:*");

    widget.cart.forEach((id, qty) {
      final p = widget.catalog.firstWhere((item) => item.id == id);
      bill.writeln("• ${p.name} (${p.qtyUnit}) x $qty = ₹${(p.price * qty).toStringAsFixed(0)}");
    });

    bill.writeln("━━━━━━━━━━━━━━━━━━━");
    bill.writeln("Subtotal: ₹${widget.subtotal.toStringAsFixed(0)}");
    bill.writeln("Delivery: ₹${deliveryFee.toStringAsFixed(0)}");
    bill.writeln("Grand Total: ₹${grandTotal.toStringAsFixed(0)}");
    bill.writeln("Status: Paid via Exact Dynamic UPI QR ✅");

    final url = "https://wa.me/$whatsAppNumber?text=${Uri.encodeComponent(bill.toString())}";
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Order Summary & Payment', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // Bill Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bill Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const Divider(height: 16),
                  ...widget.cart.entries.map((e) {
                    final item = widget.catalog.firstWhere((x) => x.id == e.key);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('${item.name} x ${e.value}', style: const TextStyle(fontSize: 12.5))),
                          Text('₹${(item.price * e.value).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                        ],
                      ),
                    );
                  }),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery Partner Fee', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('₹${deliveryFee.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('₹${grandTotal.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0C831F))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Dynamic UPI QR Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDCFCE7), width: 1.5),
              ),
              child: Column(
                children: [
                  const Text('Dynamic UPI QR (Exact Amount)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text('Scan to pay exact ₹${grandTotal.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: QrImageView(
                      data: upiPaymentUrl,
                      version: QrVersions.auto,
                      size: 160.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _payWithApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C831F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.flash_on, size: 16),
                      label: const Text('Pay via PhonePe / GPay', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Customer Form
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Full Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: 'House No, Road / Landmark',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Confirm WhatsApp Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _sendWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Place Order on WhatsApp', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
