import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApps());

class MyApps extends StatefulWidget {
  MyApps({super.key});

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  List<CartItem> cartItems = [
    CartItem(
        name: 'Pullover',
        color: 'Black',
        price: 51,
        quantity: 0,
        size: 'L',
        image: 'assets/pullover.jpg'),
    CartItem(
        name: 'T-Shirt',
        color: 'Gray',
        price: 30,
        quantity: 0,
        size: 'L',
        image: 'assets/tshirt.jpg'),
    CartItem(
        name: 'Sport Dress',
        color: 'Blue',
        price: 43,
        quantity: 0,
        size: 'M',
        image: 'assets/sportdress.jpg'),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('My Bag'),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ))
            ],
          ),
          body:Column(children: [ Expanded(flex: 6,
            child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          padding: EdgeInsets.only(right: 18, left: 6),
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
                                margin: EdgeInsets.only(
                                  bottom: 2,
                                ),
                                child: Text(
                                  cartItems[index].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  "Colors:${cartItems[index].color} Size:${cartItems[index].size}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
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
                                      child: Icon(CupertinoIcons.minus),
                                      onTap: () {
                                        setState(() {
                                          if (cartItems[index].quantity > 0) {
                                            cartItems[index].quantity--;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(cartItems[index].quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
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
                                      child: Icon(CupertinoIcons.plus),
                                      onTap: () {
                                        setState(() {
                                          cartItems[index].quantity++;
                                          if (cartItems[index].quantity == 5) {
                                            showCongratulationsDialog();
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              )
                            ]),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(height: 50),
                              Container(
                                child: Text("${cartItems[index].price}\$",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );

                }),
          ),
            Padding(
              padding:EdgeInsets.only(bottom: 70),
              child: SizedBox(width: 370,
                child: Row(
                  children:[
                    Text(
                      'Total amount : ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text(
                      '${calculateTotalPrice().toString()}\$',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            )
          ]),
          //backgroundColor: Colors.green,
          floatingActionButton: SizedBox(
            width: 380,
            height: 50,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.red[600],
              child: Text('CHECK OUT',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        )

    );
  }
  int calculateTotalPrice() {
    int total = 0;
    for (CartItem item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
  void showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have added five items. Well done!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
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
