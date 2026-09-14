import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const QuickMartApp());
}

class QuickMartApp extends StatelessWidget {
  const QuickMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickMart Grocery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0C8340),
          primary: const Color(0xFF0C8340),
          secondary: const Color(0xFFF43F5E),
          surface: const Color(0xFFF8FAFC),
        ),
        fontFamily: 'Roboto',
      ),
      home: const GroceryHomeScreen(),
    );
  }
}

// ==================== PRODUCT MODEL & DUMMY DATA ====================
class GroceryItem {
  final String id;
  final String name;
  final String weight;
  final double price;
  final double originalPrice;
  final String category;
  final String imageUrl;

  GroceryItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.imageUrl,
  });
}

final List<GroceryItem> groceryCatalog = [
  // Vegetables & Fruits
  GroceryItem(
    id: 'vg_1',
    name: 'Fresh Hybrid Tomato',
    weight: '1 kg',
    price: 38,
    originalPrice: 50,
    category: 'Veggies & Fruits',
    imageUrl: 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=300&q=80',
  ),
  GroceryItem(
    id: 'vg_2',
    name: 'Farm Fresh Potato (Aloo)',
    weight: '1 kg',
    price: 28,
    originalPrice: 35,
    category: 'Veggies & Fruits',
    imageUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=300&q=80',
  ),
  GroceryItem(
    id: 'vg_3',
    name: 'Fresh Red Onion (Pyaaz)',
    weight: '1 kg',
    price: 45,
    originalPrice: 60,
    category: 'Veggies & Fruits',
    imageUrl: 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=300&q=80',
  ),

  // Dairy & Breakfast
  GroceryItem(
    id: 'dr_1',
    name: 'Amul Taaza Toned Milk',
    weight: '1 Litre',
    price: 54,
    originalPrice: 56,
    category: 'Dairy & Bread',
    imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=300&q=80',
  ),
  GroceryItem(
    id: 'dr_2',
    name: 'Amul Salted Butter',
    weight: '100 g',
    price: 58,
    originalPrice: 60,
    category: 'Dairy & Bread',
    imageUrl: 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=300&q=80',
  ),
  GroceryItem(
    id: 'dr_3',
    name: 'Fresh Brown Bread',
    weight: '400 g',
    price: 45,
    originalPrice: 50,
    category: 'Dairy & Bread',
    imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=300&q=80',
  ),

  // Atta, Rice & Dals
  GroceryItem(
    id: 'gr_1',
    name: 'Aashirvaad Shudh Chakki Atta',
    weight: '5 kg',
    price: 235,
    originalPrice: 270,
    category: 'Atta, Rice & Dal',
    imageUrl: 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=300&q=80',
  ),
  GroceryItem(
    id: 'gr_2',
    name: 'India Gate Basmati Rice Feast',
    weight: '1 kg',
    price: 110,
    originalPrice: 140,
    category: 'Atta, Rice & Dal',
    imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=300&q=80',
  ),
  GroceryItem(
    id: 'gr_3',
    name: 'Tata Sampann Toor Dal',
    weight: '1 kg',
    price: 165,
    originalPrice: 195,
    category: 'Atta, Rice & Dal',
    imageUrl: 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=300&q=80',
  ),

  // Snacks & Drinks
  GroceryItem(
    id: 'sn_1',
    name: 'Lay\'s India\'s Magic Masala',
    weight: '50 g',
    price: 20,
    originalPrice: 20,
    category: 'Snacks & Drinks',
    imageUrl: 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=300&q=80',
  ),
  GroceryItem(
    id: 'sn_2',
    name: 'Coca-Cola Soft Drink',
    weight: '750 ml',
    price: 40,
    originalPrice: 45,
    category: 'Snacks & Drinks',
    imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=300&q=80',
  ),
];

// ==================== HOME SCREEN ====================
class GroceryHomeScreen extends StatefulWidget {
  const GroceryHomeScreen({super.key});

  @override
  State<GroceryHomeScreen> createState() => _GroceryHomeScreenState();
}

class _GroceryHomeScreenState extends State<GroceryHomeScreen> {
  String selectedCategory = 'All';
  final Map<String, int> cart = {};

  final List<String> categories = [
    'All',
    'Veggies & Fruits',
    'Dairy & Bread',
    'Atta, Rice & Dal',
    'Snacks & Drinks',
  ];

  int get totalItemsInCart => cart.values.fold(0, (sum, count) => sum + count);

  double get subtotal {
    double sum = 0;
    cart.forEach((id, qty) {
      final item = groceryCatalog.firstWhere((element) => element.id == id);
      sum += item.price * qty;
    });
    return sum;
  }

  void addToCart(String id) {
    setState(() {
      cart[id] = (cart[id] ?? 0) + 1;
    });
  }

  void removeFromCart(String id) {
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
    final filteredItems = selectedCategory == 'All'
        ? groceryCatalog
        : groceryCatalog.where((i) => i.category == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0C8340),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.bolt, color: Colors.amberAccent, size: 22),
                SizedBox(width: 4),
                Text(
                  'QuickMart 15-Mins',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Text(
              'Instant Delivery to your Doorstep',
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Category Selector
          Container(
            height: 52,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(cat),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF334155),
                    ),
                    selectedColor: const Color(0xFF0C8340),
                    backgroundColor: const Color(0xFFF8FAFC),
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF0C8340) : const Color(0xFFE2E8F0),
                    ),
                    onSelected: (_) => setState(() => selectedCategory = cat),
                  ),
                );
              },
            ),
          ),

          // Items Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final qty = cart[item.id] ?? 0;
                return ProductGridCard(
                  item: item,
                  qty: qty,
                  onAdd: () => addToCart(item.id),
                  onRemove: () => removeFromCart(item.id),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Cart Bottom Bar
      bottomNavigationBar: totalItemsInCart > 0
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalItemsInCart ITEMS IN CART',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          '₹${subtotal.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutCartScreen(
                              cart: cart,
                              catalog: groceryCatalog,
                              subtotal: subtotal,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C8340),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Row(
                        children: const [
                          Text('View Cart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
// ==================== PRODUCT GRID CARD ====================
class ProductGridCard extends StatelessWidget {
  final GroceryItem item;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductGridCard({
    super.key,
    required this.item,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    item.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade100,
                      child: const Center(
                        child: Icon(Icons.shopping_basket, color: Colors.grey, size: 36),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF43F5E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'SAVE ₹',
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
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
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 2),
                Text(
                  item.weight,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${item.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                        Text(
                          '₹${item.originalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 11,
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
                              foregroundColor: const Color(0xFF0C8340),
                              side: const BorderSide(color: Color(0xFF0C8340), width: 1.5),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('ADD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF0C8340),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: onRemove,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Icon(Icons.remove, size: 14, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  '$qty',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                InkWell(
                                  onTap: onAdd,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Icon(Icons.add, size: 14, color: Colors.white),
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

// ==================== CHECKOUT & DYNAMIC UPI QR SCREEN ====================
class CheckoutCartScreen extends StatefulWidget {
  final Map<String, int> cart;
  final List<GroceryItem> catalog;
  final double subtotal;

  const CheckoutCartScreen({
    super.key,
    required this.cart,
    required this.catalog,
    required this.subtotal,
  });

  @override
  State<CheckoutCartScreen> createState() => _CheckoutCartScreenState();
}

class _CheckoutCartScreenState extends State<CheckoutCartScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // DUKAANDAR KA SETUP (Change according to real store)
  final String storeUpiId = "paytmqr2810050501011@paytm"; 
  final String storeName = "QuickMart Store";
  final String storeWhatsAppNumber = "919876543210"; 

  final double deliveryCharge = 25.0;
  double get grandTotal => widget.subtotal + deliveryCharge;

  String get dynamicUpiUrl {
    final amountFormatted = grandTotal.toStringAsFixed(2);
    return "upi://pay?pa=$storeUpiId&pn=${Uri.encodeComponent(storeName)}&am=$amountFormatted&cu=INR&tn=QuickMartOrder";
  }

  Future<void> _payViaUpiApp() async {
    final uri = Uri.parse(dynamicUpiUrl);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not find UPI App. Please scan the QR code above!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('UPI Intent error: $e')),
        );
      }
    }
  }

  Future<void> _sendWhatsAppOrder() async {
    if (nameController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill Name, Phone, and Delivery Address!')),
      );
      return;
    }

    final StringBuffer billText = StringBuffer();
    billText.writeln("🟢 *NEW QUICKMART ORDER* 🟢");
    billText.writeln("━━━━━━━━━━━━━━━━━━━━");
    billText.writeln("*Customer:* ${nameController.text.trim()}");
    billText.writeln("*Phone:* ${phoneController.text.trim()}");
    billText.writeln("*Address:* ${addressController.text.trim()}");
    billText.writeln("━━━━━━━━━━━━━━━━━━━━");
    billText.writeln("*ITEMS ORDERED:*");

    widget.cart.forEach((id, qty) {
      final item = widget.catalog.firstWhere((element) => element.id == id);
      billText.writeln("• ${item.name} (${item.weight}) x $qty = ₹${(item.price * qty).toStringAsFixed(0)}");
    });

    billText.writeln("━━━━━━━━━━━━━━━━━━━━");
    billText.writeln("*Subtotal:* ₹${widget.subtotal.toStringAsFixed(0)}");
    billText.writeln("*Delivery:* ₹${deliveryCharge.toStringAsFixed(0)}");
    billText.writeln("*Grand Total:* ₹${grandTotal.toStringAsFixed(0)}");
    billText.writeln("*Payment Status:* UPI Scanned / Paid Online ✅");

    final whatsappUrl = "https://wa.me/$storeWhatsAppNumber?text=${Uri.encodeComponent(billText.toString())}";
    final uri = Uri.parse(whatsappUrl);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch WhatsApp: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Checkout & Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0C8340),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const Divider(height: 20),
                  ...widget.cart.entries.map((e) {
                    final item = widget.catalog.firstWhere((x) => x.id == e.key);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.name} x ${e.value}',
                              style: const TextStyle(fontSize: 13, color: Color(0xFF334155)),
                            ),
                          ),
                          Text(
                            '₹${(item.price * e.value).toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery Partner Fee', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Text('₹${deliveryCharge.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Amount to Pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        '₹${grandTotal.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0C8340)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Dynamic Custom QR Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.qr_code_2, color: Color(0xFF0C8340), size: 24),
                      SizedBox(width: 8),
                      Text('Dynamic UPI Payment QR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Exact Amount auto-locked: ₹${grandTotal.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 14),

                  // Real QR Code Generator Widget
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
                      ],
                    ),
                    child: QrImageView(
                      data: dynamicUpiUrl,
                      version: QrVersions.auto,
                      size: 180.0,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: _payViaUpiApp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C8340),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    icon: const Icon(Icons.account_balance_wallet, size: 18),
                    label: const Text('Open in PhonePe / GPay / Paytm', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Customer Details Input
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Delivery Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Full Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Contact Mobile Number',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: addressController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Flat / House No, Street, Landmark',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Place Order on WhatsApp
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _sendWhatsAppOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text(
                  'Confirm & Send Order on WhatsApp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
