import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Ramen',
    'Maki',
    'Drinks',
    'Add-ons',
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Original Tonkotsu\nRamen',
      'category': 'Ramen',
      'price': 245.00,
      'icon': Icons.ramen_dining,
    },
    {
      'name': 'Midori Ramen',
      'category': 'Ramen',
      'price': 245.00,
      'icon': Icons.ramen_dining,
    },
    {
      'name': 'Aka Ramen',
      'category': 'Ramen',
      'price': 245.00,
      'icon': Icons.ramen_dining,
    },
    {
      'name': 'Tamago Maki',
      'category': 'Maki',
      'price': 195.00,
      'icon': Icons.set_meal,
    },
    {
      'name': 'California Maki',
      'category': 'Maki',
      'price': 195.00,
      'icon': Icons.set_meal,
    },
    {
      'name': 'Iced Tea',
      'category': 'Drinks',
      'price': 65.00,
      'icon': Icons.local_drink,
    },
    {
      'name': 'Extra Egg',
      'category': 'Add-ons',
      'price': 35.00,
      'icon': Icons.egg_alt,
    },
  ];

  final Map<String, int> cart = {};

  List<Map<String, dynamic>> get filteredItems {
    final search = _searchController.text.trim().toLowerCase();

    return menuItems.where((item) {
      final categoryMatches = selectedCategory == 'All' ||
          item['category'] == selectedCategory;

      final searchMatches =
          item['name'].toString().toLowerCase().contains(search);

      return categoryMatches && searchMatches;
    }).toList();
  }

  int get totalCartItems {
    return cart.values.fold(0, (total, quantity) => total + quantity);
  }

  double get cartTotal {
    double total = 0;

    for (final item in menuItems) {
      final String name = item['name'];
      final int quantity = cart[name] ?? 0;

      total += item['price'] * quantity;
    }

    return total;
  }

  void addToCart(String name) {
    setState(() {
      cart[name] = (cart[name] ?? 0) + 1;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8EF),

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategories(),

            const SizedBox(height: 8),

            Expanded(
              child: _buildMenuList(),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomSection(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 20, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
            child: Text(
              'TableTap',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFED5A00),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 20,
                color: Color(0xFF290E07),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: _searchController,
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search menu...',
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            suffixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFFED5A00),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFE8B99F),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFAE3C00),
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 34,
          vertical: 12,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFED5A00)
                    : Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFFED5A00),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuList() {
    if (filteredItems.isEmpty) {
      return const Center(
        child: Text(
          'No menu items found.',
          style: TextStyle(
            color: Color(0xFF666666),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        24,
        4,
        24,
        110,
      ),
      itemCount: filteredItems.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = filteredItems[index];

        return _buildMenuCard(item);
      },
    );
  }

  Widget _buildMenuCard(Map<String, dynamic> item) {
    final String name = item['name'];

    return Container(
      height: 92,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE4E0DB),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFFFFEEE2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item['icon'],
              size: 39,
              color: const Color(0xFFAE3C00),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.1,
                  ),
                ),

                const SizedBox(height: 13),

                Text(
                  '₱${item['price'].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFED5A00),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              addToCart(name);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0xFFED5A00),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      color: const Color(0xFFFDF8EF),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (totalCartItems > 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  8,
                ),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFED5A00),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(11),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Cart screen will be connected next.',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 21,
                          ),

                          const SizedBox(width: 7),

                          Text(
                            'View Cart ($totalCartItems '
                            '${totalCartItems == 1 ? 'item' : 'items'})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const Spacer(),

                          Text(
                            '₱${cartTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFFDF8EF),
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFE8DDD3),
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: _BottomNavigationItem(
                      icon: Icons.home_rounded,
                      label: 'Menu',
                      selected: true,
                    ),
                  ),
                  Expanded(
                    child: _BottomNavigationItem(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Cart',
                    ),
                  ),
                  Expanded(
                    child: _BottomNavigationItem(
                      icon: Icons.access_time_rounded,
                      label: 'Status',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _BottomNavigationItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? const Color(0xFFED5A00)
        : const Color(0xFF726C6C);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight:
                selected ? FontWeight.w600 : FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}