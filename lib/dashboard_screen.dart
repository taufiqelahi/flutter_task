import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Task'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: (){}, child: Text('Get Operation')),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: Text('Post Operation')),
            SizedBox(height: 10,),

            ElevatedButton(onPressed: (){}, child: Text('Put Operation')),


          ],

        ),
      ),
    );
  }
}
