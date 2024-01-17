import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  ShoppingCartState createState() {
    return ShoppingCartState();
  }
}

var addedProductName = '';

class ShoppingCartState extends State<ShoppingCart> {
  List<CartItem> cartItems = [
    CartItem(
        name: 'Pullover',
        color: 'Black',
        price: 51,
        quantity: 0,
        size: 'L',
        image: 'assets/images/pullover_red.jpg'),
    CartItem(
        name: 'T-Shirt',
        color: 'Gray',
        price: 30,
        quantity: 0,
        size: 'L',
        image: 'assets/images/tshirt.jpg'),
    CartItem(
        name: 'Sport Dress',
        color: 'Blue',
        price: 43,
        quantity: 0,
        size: 'M',
        image: 'assets/images/sportdress.jpg'),
  ];

  int calculateTotalPrice() {
    int total = 0;
    for (CartItem item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  int calculateTotalQuantity() {
    int totalQuantity = 0;
    for (CartItem item in cartItems) {
      totalQuantity += item.quantity;
    }
    return totalQuantity;
  }

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Congratulations!')),
          content: Text('You have added \n 5 \n $addedProductName on your bag',
              style: const TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.red,
                ),
                child: const Center(
                    child: Text(
                  'OKAY',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bag',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: Column(children: [
        Expanded(
          flex: 6,
          child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 8)
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 18, left: 6),
                        child: Image.asset(
                          cartItems[index].image,
                          height: 135,
                          width: 110,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                cartItems[index].name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                "Colors:${cartItems[index].color} Size:${cartItems[index].size}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 6),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    child: const Icon(CupertinoIcons.minus),
                                    onTap: () {
                                      setState(() {
                                        if (cartItems[index].quantity > 0) {
                                          cartItems[index].quantity--;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                      cartItems[index].quantity.toString(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 6),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    child: const Icon(CupertinoIcons.plus),
                                    onTap: () {
                                      setState(() {
                                        cartItems[index].quantity++;
                                        if (cartItems[index].quantity == 5) {
                                          addedProductName =
                                              cartItems[index].name;
                                          show();

                                          //show();
                                        }
                                      });
                                    },
                                  ),
                                )
                              ],
                            )
                          ]),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: 30,
                            ),
                            const SizedBox(height: 50),
                            Text("${cartItems[index].price}\$",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: SizedBox(
            width: 370,
            child: Row(
              children: [
                const Text(
                  'Total amount : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${calculateTotalPrice().toString()}\$',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
      ]),
      floatingActionButton: SizedBox(
        width: 380,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Congratulations!')),
                  content: Text(
                      'Total Added Item ${calculateTotalQuantity().toString()} \n Total amount ${calculateTotalPrice().toString()}\$',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.red,
                        ),
                        child: const Center(
                            child: Text(
                          'OKAY',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.red,
          child: const Text('CHECK OUT',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}

class CartItem {
  String name;
  int price;
  int quantity;
  String color;
  String image;
  String size;

  CartItem(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.color,
      required this.image,
      required this.size});
}
