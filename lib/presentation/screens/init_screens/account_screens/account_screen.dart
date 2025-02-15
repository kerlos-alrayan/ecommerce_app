import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/screens/init_screens/account_screens/profile.dart';

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
          _accountItems(text: 'Profile', icon: Icons.person_outline, func: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
          }),
          _accountItems(text: 'Order', icon: Icons.shopping_cart_checkout_outlined, func: (){}),
          _accountItems(text: 'Address', icon: Icons.location_on_outlined, func: (){}),
          _accountItems(text: 'Payment', icon: Icons.payment_outlined, func: (){}),
        ],
      )
    );
  }

  Widget _accountItems({required Function func, required String text,required IconData icon}) {
    return InkWell(
      onTap: (){
        func();
      },
      child: Container(
        margin: EdgeInsets.only(left: 16),
        height: 60,
        width: double.infinity,
        child: Row(
          spacing: 16,
          children: [
            Icon(icon, color: Color(0xff40BFFF),size: 30,),
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
      ),
    );
  }
}
