import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text('Account',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins'
        ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 2,
            color:const Color(0xffD9D9D9),
          ),
          _accountItems(text: 'Profile', icon: Icons.person_outline),
          _accountItems(text: 'Order', icon: Icons.shopping_cart_checkout_outlined),
          _accountItems(text: 'Address', icon: Icons.location_on_outlined),
          _accountItems(text: 'Payment', icon: Icons.payment_outlined),
        ],
      )
    );
  }

  Padding _accountItems({required String text,required IconData icon}) {
    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 16,
            children: [
              Icon(icon, color: Color(0xff40BFFF),),
              Text(text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  color: Colors.black
                ),
              )
            ],
          ),
        );
  }
}
