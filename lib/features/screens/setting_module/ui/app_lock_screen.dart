import 'package:flutter/material.dart';

class AppLockScreen extends StatelessWidget {
  const AppLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLockView();
  }
}


class AppLockView extends StatefulWidget {
  const AppLockView({super.key});

  @override
  State<AppLockView> createState() => _AppLockViewState();
}

class _AppLockViewState extends State<AppLockView> {
  bool _isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          leading: Container(
            padding: const EdgeInsets.only(left: 5),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),titleSpacing: 0,
          title: const Text(
            "App Lock",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.security,color: Colors.orange,size: 28,),),
                      const SizedBox(width: 10,),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('App Lock Security',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                          Text('Protect your app',style: TextStyle(color: Colors.orange),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade100)
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.shield_outlined,color: Colors.blue,),
                            SizedBox(width: 7,),
                            Text('Security Features',style: TextStyle(color: Colors.blue),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('ERP app lock type will be device lock type.(e.g:-Pin,Pattern<Fingerprint,Face recognition)'),
                        SizedBox(height: 10,),
                        Text('To enable app lock ,toggle the switch below.',style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.lock_open,color: Colors.grey,),
                                SizedBox(width: 7,),
                                Text('Enable App Lock',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              ],
                            ),
                            Text("Secure your app with device authentication",style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                        const Spacer(),
                        Switch(value: _isSwitched, onChanged: (newValue){
                          setState(() {
                            _isSwitched = newValue;
                          });
                        },activeColor: Colors.blue,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}


