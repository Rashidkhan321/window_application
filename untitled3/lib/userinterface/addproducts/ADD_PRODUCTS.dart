import 'package:flutter/material.dart';
import 'package:untitled3/userinterface/Home.dart';
import 'package:untitled3/userinterface/addproducts/addinverts.dart';
import 'package:untitled3/userinterface/addproducts/addothers.dart';
import 'package:untitled3/userinterface/addproducts/addsolars.dart';

import '../../Database/Databasehelper.dart';
import 'addbattery.dart';

class Add_products extends StatefulWidget {
  const Add_products({super.key});

  @override
  State<Add_products> createState() => _Add_productsState();
}

class _Add_productsState extends State<Add_products> {
  final insatnace = Databasehelper();
  List<Map<String, dynamic>> invertlist = [];
  List<Map<String, dynamic>> baterlist = [];
  List<Map<String, dynamic>> solarlist = [];
  List<Map<String, dynamic>> otherlist = [];
  List<Map<String, dynamic>> inverterData = [];
  List<Map<String, dynamic>> batteryData = [];
  List<Map<String, dynamic>> otherData = [];
  List<Map<String, dynamic>> solarData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //insatnace.insertInverter( 'price');
    // insatnace.insertBatteryQuantity();
    // insatnace.insertInverterQuantity();
    // insatnace.insertOtherQuantity();
    // insatnace.insertsolarQuantity();
    insatnace.insertsolarDefaultIfNeeded();
    insatnace.insertinvertDefaultIfNeeded();
    insatnace.insertotherDefaultIfNeeded();
    insatnace.insertbattoryDefaultIfNeeded();
    insatnace.stactDefaultIfNeeded();
    // invertfn();
    batteryfn();
    solarfn();
    invertdata();
    otherfn();
  }

  Future<void> invertfn() async {
    final data = await insatnace.getInverterData();
    setState(() {
      invertlist = data!;
    });
  }

  //batery retrive data
  Future<void> batteryfn() async {
    final data = await insatnace.getBatteryQuantity();
    setState(() {
      batteryData = data!;
    });
  }

  //solar retrive data
  Future<void> solarfn() async {
    final data = await insatnace.getsolarqunantiy();
    setState(() {
      solarData = data!;
    });
  }

  // other equipment list
  Future<void> otherfn() async {
    final data = await insatnace.getOtherQuantity();
    setState(() {
      otherData = data!;
    });
  }

  // invert data
  Future<void> invertdata() async {
    final data = await insatnace.getInverterQuantity();
    setState(() {
      inverterData = data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Define a breakpoint for mobile screens (e.g., 600 pixels)
    const mobileBreakpoint = 700;

    // Check if the screen is mobile-sized
    final isMobile = screenWidth < mobileBreakpoint;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide default back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align items to the left
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 20, color: Colors.red),
                ),
                child: Text("Bills", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isMobile
                  ? Column(
                      children: _buildContainers(context, isMobile),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              _buildContainers(context, isMobile).sublist(0, 2),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              _buildContainers(context, isMobile).sublist(2, 4),
                        ),
                      ],
                    ),
            ),
            // Positioned(
            //   bottom: 5,
            //   right: 16,
            //   child:
            // ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContainers(BuildContext context, bool isMobile) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive dimensions
    final containerWidth = isMobile
        ? screenWidth * 0.9
        : screenWidth * 0.48; // 90% width for mobile, 45% for larger screens
    final containerHeight = isMobile
        ? screenHeight * 0.3
        : screenHeight * 0.45; // 30% height for mobile, 35% for larger screens

    return [
      _buildContainer(
        context,
        containerWidth,
        containerHeight,
        "images/imag2.jpg",
        solarData.isEmpty,
        "Add Solars",
        solarData,
        "Total Stock",
        "Total Investment",
        "Total Sold",
        "Total Revenue",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addsolar()),
          );
        },
      ),
      _buildContainer(
        context,
        containerWidth,
        containerHeight,
        "images/solar.jpeg",
        otherData.isEmpty,
        "Add Other Equipments",
        otherData,
        "Total Stock",
        "Total Investment",
        "Total Sold",
        "Total Revenue",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addother()),
          );
        },
      ),
      _buildContainer(
        context,
        containerWidth,
        containerHeight,
        "images/img.png",
        batteryData.isEmpty,
        "Add Battery",
        batteryData,
        "Total Stock",
        "Total Investment",
        "Total Sold",
        "Total Revenue",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addbattery()),
          );
        },
      ),
      _buildContainer(
        context,
        containerWidth,
        containerHeight,
        "images/img_2.png",
        inverterData.isEmpty,
        "Add Inverter",
        inverterData,
        "Total Stock",
        "Total Investment",
        "Total Sold",
        "Total Revenue",
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addinvertr()),
          );
        },
      ),
    ];
  }

  Widget _buildContainer(
    BuildContext context,
    double width,
    double height,
    String imagePath,
    bool isEmpty,
    String buttonText,
    List<Map<String, dynamic>> data,
    String header1,
    String header2,
      String header3,
      String header4,
    VoidCallback onPressed,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 16), // Add margin between containers
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Container(
            height: height,
            width: width,
            child: isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('no data'),
                        ElevatedButton(
                          onPressed: onPressed,
                          child: Text(buttonText),
                        ),
                      ],
                    ),
                  )
                :Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                                child: Column(
                  children: [
                    Container(
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            children: [
                              tableHeaderCell(header1),
                              tableHeaderCell(header2),
                              tableHeaderCell(header3),
                              tableHeaderCell(header4),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final id = data[index]['id'];
                        return Table(
                          border: TableBorder.all(color: Colors.black),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(2),
                            4: FlexColumnWidth(2),
                          },
                          children: [
                            TableRow(
                               children: [
                                tableDataCell(data[index]['number'].toString()),
                                tableDataCell(data[index]['total_price'].toString()),
                                tableDataCell(data[index]['stock'].toString()),
                                tableDataCell(data[index]['sold'].toString()),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            textStyle: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                          child: Text(buttonText,style: TextStyle(fontSize: 18, color: Colors.white,)),
                        ),
                      ),
                    ),
                  ],
                                ),
                              ),
                ),
          ),
        ],
      ),
    );
  }

  Widget tableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget tableDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
}
