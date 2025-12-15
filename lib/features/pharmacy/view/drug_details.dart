import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_screen.dart';
import '../../../providers/cart_provider.dart';

class DrugDetails extends ConsumerStatefulWidget {
  final String img;
  final String name;
  final String size;
  final double price;

  const DrugDetails({
    super.key,
    required this.img,
    required this.name,
    required this.size,
    required this.price,
  });

  @override
  ConsumerState<DrugDetails> createState() => _DrugDetailsState();
}

class _DrugDetailsState extends ConsumerState<DrugDetails> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Drugs Detail",
                    style: TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: primary,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (
                                _,
                              ) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    // PRODUCT IMAGE --------------------------------------------------
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.medication,
                            size: 100,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PRODUCT NAME & FAVORITE ------------------------------------
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(
                                    color: Color(
                                      0xFF1A2A2C,
                                    ),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(
                                  () => isFavorite = !isFavorite,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(
                                    8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isFavorite
                                        ? primary.withOpacity(
                                            0.1,
                                          )
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? primary
                                        : Colors.grey.shade400,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          // SIZE -------------------------------------------------------
                          Text(
                            widget.size,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          // RATING -----------------------------------------------------
                          Row(
                            children: [
                              ...List.generate(
                                4,
                                (
                                  index,
                                ) => const Icon(
                                  Icons.star,
                                  color: Color(
                                    0xFF20C6B7,
                                  ),
                                  size: 18,
                                ),
                              ),
                              const Icon(
                                Icons.star_half,
                                color: Color(
                                  0xFF20C6B7,
                                ),
                                size: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                "4.0",
                                style: TextStyle(
                                  color: Color(
                                    0xFF1A2A2C,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          // QUANTITY & PRICE -------------------------------------------
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (quantity >
                                            1)
                                          setState(
                                            () => quantity--,
                                          );
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        size: 20,
                                      ),
                                      color: Colors.grey.shade600,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Text(
                                        "$quantity",
                                        style: const TextStyle(
                                          color: Color(
                                            0xFF1A2A2C,
                                          ),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => setState(
                                        () => quantity++,
                                      ),
                                      icon: Container(
                                        padding: const EdgeInsets.all(
                                          4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: primary,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$${(widget.price * quantity).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Color(
                                    0xFF1A2A2C,
                                  ),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 28,
                          ),

                          // DESCRIPTION ------------------------------------------------
                          const Text(
                            "Description",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                height: 1.6,
                              ),
                              children: const [
                                TextSpan(
                                  text:
                                      "OBH COMBI  is a cough medicine containing, Paracetamol, "
                                      "Ephedrine HCl, and Chlorphenamine maleate which is used to "
                                      "relieve coughs accompanied by flu symptoms such as fever, "
                                      "headache, and sneezing... ",
                                ),
                                TextSpan(
                                  text: "Read more",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF20C6B7,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTTOM BAR WITH CART & BUY NOW ---------------------------------
            Container(
              padding: const EdgeInsets.all(
                20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.05,
                    ),
                    blurRadius: 10,
                    offset: const Offset(
                      0,
                      -5,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final cartNotifier = ref.read(cartProvider.notifier);
                        cartNotifier.addItem(CartItem(
                          productId: '${widget.name}_${widget.size}',
                          productName: widget.name,
                          price: widget.price,
                          quantity: quantity,
                          imageUrl: widget.size,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to cart'),
                            backgroundColor: Color(0xFF4CAF50),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CartScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
