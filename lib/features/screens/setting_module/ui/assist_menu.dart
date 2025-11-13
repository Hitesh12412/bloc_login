import 'package:flutter/material.dart';

class AssistMenuScreen extends StatelessWidget {
  const AssistMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AssistMenuView();
  }
}


class AssistMenuView extends StatefulWidget {
  const AssistMenuView({super.key});

  @override
  State<AssistMenuView> createState() => _AssistMenuViewState();
}

class _AssistMenuViewState extends State<AssistMenuView> {
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
            "Assist Menu",
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
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.assistant_outlined,color: Colors.blue,size: 28,),),
                      const SizedBox(width: 10,),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Assist Menu',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                          Text('Quick navigation tool',style: TextStyle(color: Colors.grey,fontSize: 14),)
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
                            Icon(Icons.error_outline,color: Colors.blue,),
                            SizedBox(width: 7,),
                            Text('How it works',style: TextStyle(color: Colors.blue),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('Select your desired favorite module in which you want to navigate easily without going back on main page'),
                        SizedBox(height: 10,),
                        Text('To enable assist menu. toggle the switch below.',style: TextStyle(color: Colors.grey),)
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
                                Icon(Icons.assistant_navigation,color: Colors.grey,),
                                SizedBox(width: 7,),
                                Text('Enable Assist Menu',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              ],
                            ),
                            Text("Tap to navigate quick navigation",style: TextStyle(color: Colors.grey),)
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


