
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:untitled3/resources/component/apicall.dart';
import 'package:untitled3/userinterface/ADD_BILLS.dart';

import '../Database/Databasehelper.dart';
import '../resources/component/input_textfield.dart';
import '../resources/component/round_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'addproducts/ADD_PRODUCTS.dart';


class homeScreen extends StatefulWidget {


  const homeScreen({super.key,});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  TextEditingController textController = TextEditingController();
  final address = 'https://images.pexels.com/photos/30538754/pexels-photo-30538754/free-photo-of-elegant-white-dress-in-snowy-winter-setting.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  String serach = "";
  final insta = dioapi();
  List<Map<String, dynamic>> list = [];
  final insatnce = Databasehelper();
  Future<void> getdata() async {
    final data = await insatnce.billdata();
    setState(() {
      list = data!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
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
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isWideScreen = width > 600;
    return Scaffold(

        appBar:        AppBar(
          automaticallyImplyLeading: false,
          leading:         IconButton(
            icon: Icon(Icons.arrow_back_ios), // You can use any icon
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Add_products()),
              );
            },
          ),
          actions: [


          ],
        ),
        body: list.isEmpty
            ? Stack(
              children: [
                Center(child: Text('No Data')),
                Positioned(
                  bottom: 80,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => addbills()));
                    },
                    // ElevatedButton action
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(fontSize: 20, color: Colors.red),
                    ),

                    child: Text("Add_bill", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            )
            :
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(constraints.maxWidth<250){
            return
              Center(child: Container(child: Text('Width is too small to display the content'),));
            }
           else if(constraints.maxWidth<1200){
              return   Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                        AssetImage("images/imag2.jpg"), // Your image asset
                        fit: BoxFit.cover, // Adjust how the image is displayed
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius:   BorderRadius.circular(15)
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: 50,
                            width: 400,
                            child: TextFormField(
                              onChanged: (String value) {
                                setState(() {});
                                serach = value;
                              },
                              controller: textController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search_rounded),
                                hintText: 'Serach by Customer Name OR by Date',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                //border: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                        // Table Headers


                        Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final id = list[index]['id'];
                              String solarName = list[index]['solar_name'] ?? '';
                              int solarPrice =
                              (list[index]['solar_price'] ?? 0).toInt();
                              int solarQuantity =
                              (list[index]['solar_quantity'] ?? 0).toInt();
                              String inverterType =
                                  list[index]['inverter_type'] ?? '';
                              int  inverterPrice =
                              (list[index]['inverter_price'] ?? 0).toInt();
                              String batteryName =
                                  list[index]['batory_name'] ?? '';
                              int batteryPrice =
                              (list[index]['bactory_price'] ?? 0).toInt();
                              int  batoryquantityy =
                              (list[index]['batory_quantity'] ?? 0)
                                  .toInt();
                              int  totalprice =
                              (list[index]['total_price'] ?? 0)
                                  .toInt();
                              String  date =
                              (list[index]['date'] ?? '');
                              int otherprice =
                              (list[index]['otherprice'] ?? 0).toInt();
                              int  otherquantity =
                              (list[index]['otherquantity'] ?? 0)
                                  .toInt();
                              String  othername =
                              (list[index]['othername'] ?? '');
                              int  invertquantity =
                              (list[index]['invertquantity'] ?? 0).toInt();

                              String buyerName = list[index]['buyer_name'] ?? '';
                              String salesmanName =
                                  list[index]['salesman_name'] ?? '';
                              if(textController.text.isEmpty){
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.grey[300],
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Table(
                                        border: TableBorder.all(color: Colors.black),
                                        columnWidths: const {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(1),

                                        },
                                        children: [
                                          TableRow(
                                            decoration:
                                            BoxDecoration(color: Colors.grey[400]),
                                            children: [
                                              tableHeaderCell('Data'),
                                              tableHeaderCell('Values'),
                                              tableHeaderCell('Actions'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child:  Table(
                                        border: TableBorder.all(color: Colors.black),

                                        children: [

                                          TableRow(
                                            children: [
                                              tableHeaderCell('Solar Name'),
                                              tableDataCell(list[index]['solar_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            //  decoration: BoxDecoration(color: Colors.grey[400]),
                                            children: [
                                              tableHeaderCell('Solar Quantity'),
                                              tableDataCell(list[index]['solar_quantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  } else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Solar Price'),
                                              tableDataCell(list[index]['solar_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            // decoration: BoxDecoration(color: Colors.grey[400]),
                                            children: [

                                              //
                                              tableHeaderCell('Inverter Name'),
                                              tableDataCell(list[index]['inverter_type']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Inverter Quantity'),
                                              tableDataCell(list[index]['invertquantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Inverter Price'),
                                              tableDataCell(list[index]['inverter_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Battery Name'),
                                              tableDataCell(list[index]['batory_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Battery Quantity'),
                                              tableDataCell(list[index]['batory_quantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Battery Price'),
                                              tableDataCell(list[index]['bactory_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Other Name'),
                                              tableDataCell(list[index]['othername']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Other Quantity'),
                                              tableDataCell(list[index]['otherquantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {

                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Other Price'),
                                              tableDataCell(list[index]['otherprice'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Buyer Name'),
                                              tableDataCell(list[index]['buyer_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Salesman'),
                                              tableDataCell(list[index]['salesman_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Total Price'),
                                              tableDataCell(list[index]['total_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Date'),
                                              tableDataCell(list[index]['date'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                   if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),


                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              else if((buyerName.toLowerCase().contains(
                                  textController.text.toLowerCase().toString()))||(date.toLowerCase().contains(
                                  textController.text.toLowerCase().toString()))){
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.grey[300],
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Table(
                                        border: TableBorder.all(color: Colors.black),
                                        columnWidths: const {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          2: FlexColumnWidth(1),

                                        },
                                        children: [
                                          TableRow(
                                            decoration:
                                            BoxDecoration(color: Colors.grey[400]),
                                            children: [
                                              tableHeaderCell('Data'),
                                              tableHeaderCell('Values'),
                                              tableHeaderCell('Actions'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child:  Table(
                                        border: TableBorder.all(color: Colors.black),

                                        children: [

                                          TableRow(
                                            children: [
                                              tableHeaderCell('Solar Name'),
                                              tableDataCell(list[index]['solar_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            //  decoration: BoxDecoration(color: Colors.grey[400]),
                                            children: [
                                              tableHeaderCell('Solar Quantity'),
                                              tableDataCell(list[index]['solar_quantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  } else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Solar Price'),
                                              tableDataCell(list[index]['solar_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            // decoration: BoxDecoration(color: Colors.grey[400]),
                                            children: [

                                              //
                                              tableHeaderCell('Inverter Name'),
                                              tableDataCell(list[index]['inverter_type']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Inverter Quantity'),
                                              tableDataCell(list[index]['invertquantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Inverter Price'),
                                              tableDataCell(list[index]['inverter_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Battery Name'),
                                              tableDataCell(list[index]['batory_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Battery Quantity'),
                                              tableDataCell(list[index]['batory_quantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Battery Price'),
                                              tableDataCell(list[index]['bactory_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Other Name'),
                                              tableDataCell(list[index]['othername']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Other Quantity'),
                                              tableDataCell(list[index]['otherquantity'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {

                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Other Price'),
                                              tableDataCell(list[index]['otherprice'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Buyer Name'),
                                              tableDataCell(list[index]['buyer_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Salesman'),
                                              tableDataCell(list[index]['salesman_name']),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Total Price'),
                                              tableDataCell(list[index]['total_price'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              tableHeaderCell('Date'),
                                              tableDataCell(list[index]['date'].toString()),
                                              PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    updatedata(
                                                        id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice);

                                                  }
                                                  else
                                                  if(value =='delete'){
                                                    deletedata(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);
                                                  }
                                                  else if(value=='print'){
                                                    printable(id,
                                                        solarName,
                                                        solarPrice,
                                                        solarQuantity,
                                                        inverterType,
                                                        inverterPrice,
                                                        batteryName,
                                                        batteryPrice,
                                                        batoryquantityy,
                                                        buyerName,
                                                        salesmanName,
                                                        othername,
                                                        invertquantity,
                                                        otherquantity,
                                                        otherprice
                                                        ,totalprice, date, context);

                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text("Update"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text("Delete"),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'print',
                                                    child: Text("Print"),
                                                  ),
                                                ],
                                              ),


                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              else{
                                return Container();
                              }


                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => addbills()));
                      },
                      // ElevatedButton action
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(fontSize: 20, color: Colors.red),
                      ),

                      child: Text("Add_bill", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              );

            }

            else{
              return   Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                        AssetImage("images/imag2.jpg"), // Your image asset
                        fit: BoxFit.cover, // Adjust how the image is displayed
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius:   BorderRadius.circular(15)
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: 50,
                            width: 400,
                            child: TextFormField(
                              onChanged: (String value) {
                                setState(() {});
                                serach = value;
                              },
                              controller: textController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search_rounded),
                                hintText: 'Serach by Customer Name OR by Date',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                //border: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                        // Table Headers
                        Container(
                          color: Colors.grey[300],
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(1),
                              5: FlexColumnWidth(1),
                              6: FlexColumnWidth(1),
                              7: FlexColumnWidth(1),
                              8: FlexColumnWidth(1),
                              9: FlexColumnWidth(1),
                              10: FlexColumnWidth(1),
                              11: FlexColumnWidth(1),
                              12: FlexColumnWidth(1),
                              13: FlexColumnWidth(1),
                              14: FlexColumnWidth(1),
                              15: FlexColumnWidth(1),
                              16: FlexColumnWidth(1),
                              17: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                decoration:
                                BoxDecoration(color: Colors.grey[400]),
                                children: [
                                  tableHeaderCell('Solar Name'),
                                  tableHeaderCell('Solar Quantity'),
                                  tableHeaderCell('Solar Price'),
                                  tableHeaderCell('Inverter Name'),
                                  tableHeaderCell('Inverter Quantity'),
                                  tableHeaderCell('Inverter Price'),
                                  tableHeaderCell('Battery Name'),
                                  tableHeaderCell('Battery Quantity'),
                                  tableHeaderCell('Battery Price'),
                                  tableHeaderCell('Other Name'),
                                  tableHeaderCell('Other Quantity'),
                                  tableHeaderCell('Other Price'),
                                  tableHeaderCell('Buyer Name'),
                                  tableHeaderCell('Salesman'),
                                  tableHeaderCell('Total Price'),
                                  tableHeaderCell('Date'),
                                  tableHeaderCell('Actions'),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final id = list[index]['id'];
                              String solarName = list[index]['solar_name'] ?? '';
                              int solarPrice =
                              (list[index]['solar_price'] ?? 0).toInt();
                              int solarQuantity =
                              (list[index]['solar_quantity'] ?? 0).toInt();
                              String inverterType =
                                  list[index]['inverter_type'] ?? '';
                              int  inverterPrice =
                              (list[index]['inverter_price'] ?? 0).toInt();
                              String batteryName =
                                  list[index]['batory_name'] ?? '';
                              int batteryPrice =
                              (list[index]['bactory_price'] ?? 0).toInt();
                              int  batoryquantityy =
                              (list[index]['batory_quantity'] ?? 0)
                                  .toInt();
                              int  totalprice =
                              (list[index]['total_price'] ?? 0)
                                  .toInt();
                              String  date =
                              (list[index]['date'] ?? '');
                              int otherprice =
                              (list[index]['otherprice'] ?? 0).toInt();
                              int  otherquantity =
                              (list[index]['otherquantity'] ?? 0)
                                  .toInt();
                              String  othername =
                              (list[index]['othername'] ?? '');
                              int  invertquantity =
                              (list[index]['invertquantity'] ?? 0).toInt();

                              String buyerName = list[index]['buyer_name'] ?? '';
                              String salesmanName =
                                  list[index]['salesman_name'] ?? '';
                              if(textController.text.isEmpty){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Table(
                                      border: TableBorder.all(color: Colors.black),
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(1),
                                        3: FlexColumnWidth(1),
                                        4: FlexColumnWidth(1),
                                        5: FlexColumnWidth(1),
                                        6: FlexColumnWidth(1),
                                        7: FlexColumnWidth(1),
                                        8: FlexColumnWidth(1),
                                        9: FlexColumnWidth(1),
                                        10: FlexColumnWidth(1),
                                        11: FlexColumnWidth(1),
                                        12: FlexColumnWidth(1),
                                        13: FlexColumnWidth(1),
                                        14: FlexColumnWidth(1),
                                        15: FlexColumnWidth(1),
                                        16: FlexColumnWidth(1),
                                        17: FlexColumnWidth(1),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            tableDataCell(list[index]['solar_name']),
                                            tableDataCell(list[index]
                                            ['solar_quantity']
                                                .toString()),
                                            tableDataCell(list[index]['solar_price']
                                                .toString()),
                                            tableDataCell(
                                                list[index]['inverter_type']),
                                            tableDataCell(list[index]
                                            ['invertquantity']
                                                .toString()),
                                            tableDataCell(list[index]
                                            ['inverter_price']
                                                .toString()),
                                            tableDataCell(list[index]['batory_name']),
                                            tableDataCell(list[index]['batory_quantity']
                                                .toString()),
                                            tableDataCell(list[index]['bactory_price']
                                                .toString()),
                                            tableDataCell(list[index]['othername']),
                                            tableDataCell(list[index]['otherquantity']
                                                .toString()),
                                            tableDataCell(list[index]['otherprice']
                                                .toString()),
                                            tableDataCell(list[index]['buyer_name']),
                                            tableDataCell(
                                                list[index]['salesman_name']),
                                            tableDataCell(list[index]['total_price']
                                                .toString()),
                                            tableDataCell(
                                                list[index]['date'].toString()),
                                            TableCell(
                                              child: Center(
                                                child: PopupMenuButton(
                                                  icon: Icon(Icons.more_vert),
                                                  onSelected: (value) {
                                                    if (value == 'edit') {
                                                      updatedata(
                                                          id,
                                                          solarName,
                                                          solarPrice,
                                                          solarQuantity,
                                                          inverterType,
                                                          inverterPrice,
                                                          batteryName,
                                                          batteryPrice,
                                                          batoryquantityy,
                                                          buyerName,
                                                          salesmanName,
                                                          othername,
                                                          invertquantity,
                                                          otherquantity,
                                                          otherprice);

                                                    }
                                                    if(value =='delete'){
                                                      deletedata(id,
                                                          solarName,
                                                          solarPrice,
                                                          solarQuantity,
                                                          inverterType,
                                                          inverterPrice,
                                                          batteryName,
                                                          batteryPrice,
                                                          batoryquantityy,
                                                          buyerName,
                                                          salesmanName,
                                                          othername,
                                                          invertquantity,
                                                          otherquantity,
                                                          otherprice
                                                          ,totalprice, date, context);
                                                    }
                                                    else if(value=='print'){
                                                      printable(id,
                                                          solarName,
                                                          solarPrice,
                                                          solarQuantity,
                                                          inverterType,
                                                          inverterPrice,
                                                          batteryName,
                                                          batteryPrice,
                                                          batoryquantityy,
                                                          buyerName,
                                                          salesmanName,
                                                          othername,
                                                          invertquantity,
                                                          otherquantity,
                                                          otherprice
                                                          ,totalprice, date, context);

                                                    }
                                                  },
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 'edit',
                                                      child: Text("Update"),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 'delete',
                                                      child: Text("Delete"),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 'print',
                                                      child: Text("Print"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                );
                              }
                              else if((buyerName.toLowerCase().contains(
                                  textController.text.toLowerCase().toString()))||(date.toLowerCase().contains(
                                  textController.text.toLowerCase().toString()))){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Table(
                                      border: TableBorder.all(color: Colors.black),
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(1),
                                        3: FlexColumnWidth(1),
                                        4: FlexColumnWidth(1),
                                        5: FlexColumnWidth(1),
                                        6: FlexColumnWidth(1),
                                        7: FlexColumnWidth(1),
                                        8: FlexColumnWidth(1),
                                        9: FlexColumnWidth(1),
                                        10: FlexColumnWidth(1),
                                        11: FlexColumnWidth(1),
                                        12: FlexColumnWidth(1),
                                        13: FlexColumnWidth(1),
                                        14: FlexColumnWidth(1),
                                        15: FlexColumnWidth(1),
                                        16: FlexColumnWidth(1),
                                        17: FlexColumnWidth(1),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            tableDataCell(list[index]['solar_name']),
                                            tableDataCell(list[index]
                                            ['solar_quantity']
                                                .toString()),
                                            tableDataCell(list[index]['solar_price']
                                                .toString()),
                                            tableDataCell(
                                                list[index]['inverter_type']),
                                            tableDataCell(list[index]
                                            ['invertquantity']
                                                .toString()),
                                            tableDataCell(list[index]
                                            ['inverter_price']
                                                .toString()),
                                            tableDataCell(list[index]['batory_name']),
                                            tableDataCell(list[index]['batory_quantity']
                                                .toString()),
                                            tableDataCell(list[index]['bactory_price']
                                                .toString()),
                                            tableDataCell(list[index]['othername']),
                                            tableDataCell(list[index]['otherquantity']
                                                .toString()),
                                            tableDataCell(list[index]['otherprice']
                                                .toString()),
                                            tableDataCell(list[index]['buyer_name']),
                                            tableDataCell(
                                                list[index]['salesman_name']),
                                            tableDataCell(list[index]['total_price']
                                                .toString()),
                                            tableDataCell(
                                                list[index]['date'].toString()),
                                            TableCell(
                                              child: Center(
                                                child: PopupMenuButton(
                                                  icon: Icon(Icons.more_vert),
                                                  onSelected: (value) {
                                                    // if (value == 'edit') {
                                                    //   updatedata(
                                                    //       id,
                                                    //       solarName,
                                                    //       solarPrice,
                                                    //       solarQuantity,
                                                    //       inverterType,
                                                    //       inverterPrice,
                                                    //       batteryName,
                                                    //       batteryPrice,
                                                    //       batoryquantityy,
                                                    //       buyerName,
                                                    //       salesmanName,
                                                    //       othername,
                                                    //       invertquantity,
                                                    //       otherquantity,
                                                    //       otherprice);
                                                    //
                                                    // }
                                                     if(value =='delete'){
                                                      deletedata(id,
                                                          solarName,
                                                          solarPrice,
                                                          solarQuantity,
                                                          inverterType,
                                                          inverterPrice,
                                                          batteryName,
                                                          batteryPrice,
                                                          batoryquantityy,
                                                          buyerName,
                                                          salesmanName,
                                                          othername,
                                                          invertquantity,
                                                          otherquantity,
                                                          otherprice
                                                          ,totalprice, date, context);
                                                    }
                                                    else if(value=='print'){
                                                      printable(id,
                                                          solarName,
                                                          solarPrice,
                                                          solarQuantity,
                                                          inverterType,
                                                          inverterPrice,
                                                          batteryName,
                                                          batteryPrice,
                                                          batoryquantityy,
                                                          buyerName,
                                                          salesmanName,
                                                          othername,
                                                          invertquantity,
                                                          otherquantity,
                                                          otherprice
                                                          ,totalprice, date, context);

                                                    }
                                                  },
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 'edit',
                                                      child: Text("Update"),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 'delete',
                                                      child: Text("Delete"),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 'print',
                                                      child: Text("Print"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                );
                              }
                              else{
                                return Container();
                              }


                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => addbills()));
                      },
                      // ElevatedButton action
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(fontSize: 20, color: Colors.red),
                      ),

                      child: Text("Add_bill", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              );
            }
          },

        )


    );
  }

  // edit the data
  final  solarnamecontroller = TextEditingController();
  final solarquantitycontroller =TextEditingController();
  final invertypecontroller = TextEditingController();
  final batorynamecontoller = TextEditingController();
  final batoryquantity = TextEditingController();
  final buyernamecontrolelr = TextEditingController();
  final sellernamecontroller = TextEditingController();
  final solarprice = TextEditingController();
  final invertorprice = TextEditingController();
  final batoryprice =TextEditingController();
  final invertqunaity = TextEditingController();
  final othername = TextEditingController();
  final otherqunatity = TextEditingController();
  final otherprice =TextEditingController();
  final form = GlobalKey<FormState>();
  final instance = Databasehelper();

  Future<void> updatedata(
    int id,
    String solarName,
    int solarPrice,
    int solarQuantity,
    String inverterType,
    int inverterPrice,
    String batteryName,
    int batteryPrice,
    int batoryquantityy,
    String buyerName,
    String salesmanName,
      String othernaame,
      int invertquantity,
      int otherqunaity,
     int otherpprice,

  ) {
    solarnamecontroller.text = solarName;
    solarquantitycontroller.text = solarQuantity.toString();
    invertypecontroller.text = inverterType;
    invertorprice.text = inverterPrice.toString();
    solarprice.text = solarPrice.toString();
    batorynamecontoller.text = batteryName;
    batoryquantity.text = batoryquantityy.toString();
    batoryprice.text = batteryPrice.toString();
    buyernamecontrolelr.text = batteryName;
    sellernamecontroller.text = salesmanName;
    othername.text =othernaame;
    otherqunatity.text =otherqunaity.toString();
    otherprice.text =otherpprice.toString();
    invertqunaity.text =invertquantity.toString();

    final height = MediaQuery.of(context).size.height * 1;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("images/solar.jpeg"), // Your image asset
                      fit: BoxFit.cover, // Adjust how the image is displayed
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15)),
                    width: 1000,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: form,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [


                                    textfield(


                                      mycontroller: solarnamecontroller,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.text,
                                      obscureText: false,
                                      hint: "Solar Type",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter type': null;
                                      }, label: 'Solar Type',

                                    ),
                                    SizedBox(height: height*.010,),



                                    textfield(


                                      mycontroller: solarquantitycontroller,
                                      // focusNode:passwordf,
                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Solar Quantity",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter quantity': null;
                                      }, label: 'Solar Quantity',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: solarprice,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Solar Price",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter price': null;
                                      }, label: 'Solar Price',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: batorynamecontoller,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.text,
                                      obscureText: false,
                                      hint: "Batory Name",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter type': null;
                                      }, label: 'Batory Name',

                                    ),
                                    SizedBox(height: height*.010,),

                                    textfield(


                                      mycontroller: batoryquantity,
                                      // focusNode:passwordf,
                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Batory Quantity",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter quantity': null;
                                      }, label: 'Batory Quantity',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: batoryprice,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Batory Price",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter price': null;
                                      }, label: 'Batory Price',

                                    ),

                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: invertypecontroller,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.text,
                                      obscureText: false,
                                      hint: "Invertor  Type",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter type': null;
                                      }, label: 'Invertor  Type',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: invertqunaity,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Invertor  Quantity",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter quantity': null;
                                      }, label: 'Invertor  Quantity',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: invertorprice,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Invertor  Price",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter price': null;
                                      }, label: 'Invertor  Price',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: othername,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.text,
                                      obscureText: false,
                                      hint: "Other   Name",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter other': null;
                                      }, label: 'Other  Name',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: otherqunatity,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Other  Quantity",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter quantity': null;
                                      }, label: 'Other Quantity',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: otherprice,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.number,
                                      obscureText: false,
                                      hint: "Other  Price",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter other': null;
                                      }, label: 'Other  price',

                                    ),

                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: buyernamecontrolelr,
                                      // focusNode:passwordf,
                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.text,
                                      obscureText: false,
                                      hint: "Buyer Name",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter buyer name': null;
                                      }, label: 'Buyer Name',

                                    ),
                                    SizedBox(height: height*.010,),
                                    textfield(


                                      mycontroller: sellernamecontroller,

                                      fieldSetter: (value){

                                      },
                                      keyBoradtype: TextInputType.text,
                                      obscureText: false,
                                      hint: "Saleman Name",
                                      fieldValidator: (value){
                                        return value.isEmpty ? 'enter saleman name': null;
                                      }, label: 'Saleman Name',

                                    ),
                                    SizedBox(height: height*.010,),





                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(

                                      onPressed: () {

                                        if(form.currentState!.validate()){
                                          String currentDate =
                                          DateFormat('yyyy-MM-dd HH:mm:ss')
                                              .format(DateTime.now());

                                          // Ensure correct type conversions
                                          int solarQuantity = int.parse(solarquantitycontroller.text);
                                          int solarPrice = int.parse(solarprice.text);
                                          int batoryQuantity = int.parse(batoryquantity.text);
                                          int batoryPrice = int.parse(batoryprice.text);
                                          int inverterPrice = int.parse(invertorprice.text);
                                          int totalsolarprice = solarPrice*solarQuantity;
                                          int invertquantity = int.parse(invertqunaity.text);
                                          int otherqunattity = int.parse(otherqunatity.text);
                                          int othrprice = int.parse(otherprice.text);

                                          // Insert the data
                                          instance
                                              .updatadta(
                                              id,
                                              solarnamecontroller.text,
                                              solarQuantity,
                                              solarPrice,
                                              batorynamecontoller.text,
                                              batoryQuantity,
                                              batoryPrice,
                                              invertypecontroller.text,
                                              inverterPrice,
                                              buyernamecontrolelr.text,
                                              sellernamecontroller.text,
                                              currentDate.toString(),
                                              invertquantity,
                                              othername.text,
                                              otherqunattity,
                                              othrprice
                                          )
                                              .then((onValue) {
                                            setState(() {
                                              instance.updatedbatteryQuantity(
                                                  batoryQuantity, batoryQuantity, batoryPrice);
                                              instance.updatedinvertrQuantity(
                                                  invertquantity, invertquantity, inverterPrice);
                                              instance.updatedSolarQuantity(
                                                  solarQuantity, solarQuantity, totalsolarprice);
                                              instance.updatedotherQuantity(
                                                  otherqunattity, otherqunattity, othrprice);

                                            });

                                            Navigator.pop(context);
                                            getdata();

                                          });
                                        }

                                      },
                                      child: Text('Update',style: TextStyle(color: Colors.white)),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);

                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .010,
                                ),

                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        });
  }
  Future<void> deletedata(
      int id,
      String solarName,
      int solarPrice,
      int solarQuantity,
      String inverterType,
      int inverterPrice,
      String batteryName,
      int batteryPrice,
      int batoryquantityy,
      String buyerName,
      String salesmanName,
      String othernaame,
      int invertquantity,
      int otherqunaity,
      int otherpprice,
      int totalprice,
      String date,
      BuildContext context,
      ) {
    return showDialog(
      context: context,
      builder: (context) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
        int totalsolarprice = solarPrice*solarQuantity;
        int totalinvertprice = inverterPrice*invertquantity;
        int totalotherprice = otherqunaity*otherpprice;
        int totalbatteryprice = batteryPrice*batoryquantityy;
        bool isWideScreen = width > 600;

        // Check if the screen size is too small
        if (width < 450 || height < 400) {
          return AlertDialog(
            content: Container(

              padding: EdgeInsets.all(16),
              child: Text(
                'Screen size is too small to display the content!',
                style: TextStyle( fontSize: 16),
              ),
            ),
          );
        }


else if(width < 1200){
   return AlertDialog(
    title: Center(child: Text('Delete Data')),
    content: Container(
      width: isWideScreen ? width * 0.8 : width * 0.9,

      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(

                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: isWideScreen
                      ? const {
                    0: FlexColumnWidth(1),
                     1: FlexColumnWidth(1),
                    // 2: FlexColumnWidth(1),
                    // 3: FlexColumnWidth(1),
                    // 4: FlexColumnWidth(1),
                    // 5: FlexColumnWidth(1),
                    // 6: FlexColumnWidth(1),
                    // 7: FlexColumnWidth(1),
                    // 8: FlexColumnWidth(1),
                    // 9: FlexColumnWidth(1),
                    // 10: FlexColumnWidth(1),
                    // 11: FlexColumnWidth(1),
                    // 12: FlexColumnWidth(1),
                    // 13: FlexColumnWidth(1),
                    // 14: FlexColumnWidth(1),
                    // 15: FlexColumnWidth(1),
                    // 16: FlexColumnWidth(1),

                  }
                      : const {
                    0: FlexColumnWidth(1),
                     1: FlexColumnWidth(1),
                    // 2: FlexColumnWidth(1),
                    // 3: FlexColumnWidth(1),
                    // 4: FlexColumnWidth(1),
                    // 5: FlexColumnWidth(1),
                    // 6: FlexColumnWidth(1),
                    // 7: FlexColumnWidth(1),
                    // 8: FlexColumnWidth(1),
                    // 9: FlexColumnWidth(1),
                    // 10: FlexColumnWidth(1),
                    // 11: FlexColumnWidth(1),
                    // 12: FlexColumnWidth(1),
                    // 13: FlexColumnWidth(1),
                    // 14: FlexColumnWidth(1),
                    // 15: FlexColumnWidth(1),
                    // 16: FlexColumnWidth(1),

                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[400]),
                      children: [
                        tableHeaderCell('Attributes'),
                        tableHeaderCell('Values'),


                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Solar Name'),
                        tableHeaderCell(solarName),

                      ],
                    ),
                    TableRow(
                    //  decoration: BoxDecoration(color: Colors.grey[400]),
                      children: [
                         tableHeaderCell('Solar Quantity'),
                         tableHeaderCell(solarQuantity.toString()),


                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Solar Price'),
                        tableHeaderCell(solarPrice.toString()),

                      ],
                    ),                    TableRow(
                     // decoration: BoxDecoration(color: Colors.grey[400]),
                      children: [

                        //
                         tableHeaderCell('Inverter Name'),
                        tableHeaderCell(inverterType),
                        //
                        //

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Inverter Quantity'),
                        tableHeaderCell(invertquantity.toString()),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Inverter Price'),
                        tableHeaderCell(inverterPrice.toString()),

                      ],
                    ),
                    TableRow(
                      children: [
                         tableHeaderCell('Battery Name'),
                         tableHeaderCell(batteryName),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Battery Quantity'),
                        tableHeaderCell(batoryquantityy.toString()),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Battery Price'),
                        tableHeaderCell(batteryPrice.toString()),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Other Name'),
                         tableHeaderCell(othernaame),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Other Quantity'),
                         tableHeaderCell(otherqunaity.toString()),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Other Price'),
                         tableHeaderCell(otherpprice.toString()),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Buyer Name'),
                         tableHeaderCell(buyerName),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Salesman'),
                         tableHeaderCell(salesmanName),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Total Price'),
                         tableHeaderCell(totalprice.toString()),

                      ],
                    ),
                    TableRow(
                      children: [
                        tableHeaderCell('Date'),
                         tableHeaderCell(date),


                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    instance.removedata(id);
                    instance.deletebatteryQuantity(batoryquantityy, batoryquantityy, totalbatteryprice);
                    instance.deleteinvertrQuantity(invertquantity, invertquantity, totalinvertprice);
                    instance. deleteSolarQuantity(solarQuantity, solarQuantity,totalsolarprice);
                    instance.deleteotherQuantity(otherqunaity , otherqunaity, totalotherprice);
                    Navigator.pop(context);
                    getdata();
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
        }
        // Proceed with normal content if screen size is sufficient

        return AlertDialog(
          title: Center(child: Text('Delete Data')),
          content: Container(
            width: isWideScreen ? width * 0.8 : width * 0.9,

            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: SingleChildScrollView(

                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: isWideScreen
                            ? const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(1),
                          6: FlexColumnWidth(1),
                          7: FlexColumnWidth(1),
                          8: FlexColumnWidth(1),
                          9: FlexColumnWidth(1),
                          10: FlexColumnWidth(1),
                          11: FlexColumnWidth(1),
                          12: FlexColumnWidth(1),
                          13: FlexColumnWidth(1),
                          14: FlexColumnWidth(1),
                          15: FlexColumnWidth(1),
                          16: FlexColumnWidth(1),

                        }
                            : const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(1),
                          6: FlexColumnWidth(1),
                          7: FlexColumnWidth(1),
                          8: FlexColumnWidth(1),
                          9: FlexColumnWidth(1),
                          10: FlexColumnWidth(1),
                          11: FlexColumnWidth(1),
                          12: FlexColumnWidth(1),
                          13: FlexColumnWidth(1),
                          14: FlexColumnWidth(1),
                          15: FlexColumnWidth(1),
                          16: FlexColumnWidth(1),

                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[400]),
                            children: [
                              tableHeaderCell('Solar Name'),
                              tableHeaderCell('Solar Quantity'),
                              tableHeaderCell('Solar Price'),
                              tableHeaderCell('Inverter Name'),
                              tableHeaderCell('Inverter Quantity'),
                              tableHeaderCell('Inverter Price'),
                              tableHeaderCell('Battery Name'),
                              tableHeaderCell('Battery Quantity'),
                              tableHeaderCell('Battery Price'),
                              tableHeaderCell('Other Name'),
                              tableHeaderCell('Other Quantity'),
                              tableHeaderCell('Other Price'),
                              tableHeaderCell('Buyer Name'),
                              tableHeaderCell('Salesman'),
                              tableHeaderCell('Total Price'),
                              tableHeaderCell('Date'),

                            ],
                          ),
                          TableRow(
                            children: [
                              tableHeaderCell(solarName),
                              tableHeaderCell(solarQuantity.toString()),
                              tableHeaderCell(solarPrice.toString()),
                              tableHeaderCell(inverterType),
                              tableHeaderCell(invertquantity.toString()),
                              tableHeaderCell(inverterPrice.toString()),
                              tableHeaderCell(batteryName),
                              tableHeaderCell(batoryquantityy.toString()),
                              tableHeaderCell(batteryPrice.toString()),
                              tableHeaderCell(othernaame),
                              tableHeaderCell(otherqunaity.toString()),
                              tableHeaderCell(otherpprice.toString()),
                              tableHeaderCell(buyerName),
                              tableHeaderCell(salesmanName),
                              tableHeaderCell(totalprice.toString()),
                              tableHeaderCell(date),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          instance.removedata(id);

                          instance.deletebatteryQuantity(batoryquantityy, batoryquantityy, totalbatteryprice);
                          instance.deleteinvertrQuantity(invertquantity, invertquantity, totalinvertprice);
                          instance. deleteSolarQuantity(solarQuantity, solarQuantity,totalsolarprice);
                          instance.deleteotherQuantity(otherqunaity , otherqunaity, totalotherprice);
                          Navigator.pop(context);
                          getdata();
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Generate pdf function
  Future<void> printable(
      int id,
      String solarName,
      int solarPrice,
      int solarQuantity,
      String inverterType,
      int inverterPrice,
      String batteryName,
      int batteryPrice,
      int batoryquantityy,
      String buyerName,
      String salesmanName,
      String othernaame,
      int invertquantity,
      int otherqunaity,
      int otherpprice,
      int totalprice,
      String date,
      BuildContext context,
      ) {
    return showDialog(
      context: context,
      builder: (context) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
        bool isWideScreen = width > 600;

        // Check if the screen size is too small
        if (width < 450 || height < 400) {
          return AlertDialog(
            content: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Screen size is too small to display the content!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        // Proceed with normal content if screen size is sufficient

        else if(width < 1200){
          return AlertDialog(
            title: Center(child: Text('Delete Data')),
            content: Container(
              width: isWideScreen ? width * 0.8 : width * 0.9,

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: SingleChildScrollView(

                        child: Table(
                          border: TableBorder.all(color: Colors.black),
                          columnWidths: isWideScreen
                              ? const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            // 2: FlexColumnWidth(1),
                            // 3: FlexColumnWidth(1),
                            // 4: FlexColumnWidth(1),
                            // 5: FlexColumnWidth(1),
                            // 6: FlexColumnWidth(1),
                            // 7: FlexColumnWidth(1),
                            // 8: FlexColumnWidth(1),
                            // 9: FlexColumnWidth(1),
                            // 10: FlexColumnWidth(1),
                            // 11: FlexColumnWidth(1),
                            // 12: FlexColumnWidth(1),
                            // 13: FlexColumnWidth(1),
                            // 14: FlexColumnWidth(1),
                            // 15: FlexColumnWidth(1),
                            // 16: FlexColumnWidth(1),

                          }
                              : const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),


                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Colors.grey[400]),
                              children: [
                                tableHeaderCell('Attributes'),
                                tableHeaderCell('Values'),


                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Solar Name'),
                                tableHeaderCell(solarName),

                              ],
                            ),
                            TableRow(
                              //  decoration: BoxDecoration(color: Colors.grey[400]),
                              children: [
                                tableHeaderCell('Solar Quantity'),
                                tableHeaderCell(solarQuantity.toString()),


                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Solar Price'),
                                tableHeaderCell(solarPrice.toString()),

                              ],
                            ),                    TableRow(
                              // decoration: BoxDecoration(color: Colors.grey[400]),
                              children: [

                                //
                                tableHeaderCell('Inverter Name'),
                                tableHeaderCell(inverterType),
                                //
                                //

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Inverter Quantity'),
                                tableHeaderCell(invertquantity.toString()),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Inverter Price'),
                                tableHeaderCell(inverterPrice.toString()),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Battery Name'),
                                tableHeaderCell(batteryName),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Battery Quantity'),
                                tableHeaderCell(batoryquantityy.toString()),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Battery Price'),
                                tableHeaderCell(batteryPrice.toString()),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Other Name'),
                                tableHeaderCell(othernaame),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Other Quantity'),
                                tableHeaderCell(otherqunaity.toString()),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Other Price'),
                                tableHeaderCell(otherpprice.toString()),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Buyer Name'),
                                tableHeaderCell(buyerName),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Salesman'),
                                tableHeaderCell(salesmanName),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Total Price'),
                                tableHeaderCell(totalprice.toString()),

                              ],
                            ),
                            TableRow(
                              children: [
                                tableHeaderCell('Date'),
                                tableHeaderCell(date),


                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [





                        TextButton(
                          onPressed: () async {
                            Future<Uint8List> loadAssetImage(String path) async {
                              final ByteData data = await rootBundle.load(path);
                              return data.buffer.asUint8List();
                            }

                            Future<void> savePdfToFile(pw.Document pdf) async {
                              final pdfBytes = await pdf.save();
                              Printing.layoutPdf(
                                onLayout: (PdfPageFormat format) async => pdfBytes,
                              );
                            }

                            Future<void> generatePdf(PdfPageFormat pageFormat) async {
                              final pdf = pw.Document();

                              // Load image from assets
                              Uint8List imageData = await loadAssetImage('images/print.PNG');

                              pdf.addPage(
                                pw.Page(
                                  build: (pw.Context context) {
                                    return pw.Center(
                                      child: pw.Stack(
                                        children: [
                                          pw.Image(
                                            pw.MemoryImage(imageData),
                                            fit: pw.BoxFit.cover, // Scale image to fill the entire page
                                            // width: PdfPageFormat.a4.width,  // Set width to A4
                                            // height: PdfPageFormat.a4.height,
                                          ),

                                          pw.Table.fromTextArray(
                                              headers: ['Data', 'Values'],
                                              data: [
                                                ['Solar Name', solarName],
                                                ['Solar Qty', solarQuantity.toString()],
                                                ['Solar Price', solarPrice.toString()],
                                                ['Inverter Name', inverterType],
                                                ['Inverter Quantity', invertquantity.toString()],
                                                ['Inverter Price', inverterPrice.toString()],
                                                ['Battery Name', batteryName],
                                                ['Battery Quantity', batoryquantityy.toString()],
                                                ['Battery Price', batteryPrice.toString()],
                                                ['Other Equipment Name', othernaame],
                                                ['Other Equipment Quantity', otherqunaity.toString()],
                                                ['Other Equipment Price', otherpprice.toString()],
                                                ['Buyer Name', buyerName],
                                                ['Salesman', salesmanName],
                                                ['Total Price', totalprice.toString()],
                                                ['Date', date],
                                              ],

                                              headerStyle: pw.TextStyle( fontSize: 20,
                                                  fontWeight:pw.FontWeight.bold), // Set header text color

                                              headerDecoration: pw.BoxDecoration(
                                                color: PdfColors.green50, // Change header background color to blue
                                                border: pw.Border.all(
                                                  color: PdfColors.black,
                                                  width: 1,
                                                ),
                                              )

                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );

                              await savePdfToFile(pdf);
                            }

                            await generatePdf(PdfPageFormat.a4);
                          },
                          child: Text(
                            'Print',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return AlertDialog(
          title: Center(child: Text('Print Data')),
          content: Container(
            width: isWideScreen ? width * 0.6 : width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: isWideScreen
                            ? const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(1),
                          6: FlexColumnWidth(1),
                          7: FlexColumnWidth(1),
                          8: FlexColumnWidth(1),
                          9: FlexColumnWidth(1),
                          10: FlexColumnWidth(1),
                          11: FlexColumnWidth(1),
                          12: FlexColumnWidth(1),
                          13: FlexColumnWidth(1),
                          14: FlexColumnWidth(1),
                          15: FlexColumnWidth(1),
                          16: FlexColumnWidth(1),

                        }
                            : const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(1),
                          6: FlexColumnWidth(1),
                          7: FlexColumnWidth(1),
                          8: FlexColumnWidth(1),
                          9: FlexColumnWidth(1),
                          10: FlexColumnWidth(1),
                          11: FlexColumnWidth(1),
                          12: FlexColumnWidth(1),
                          13: FlexColumnWidth(1),
                          14: FlexColumnWidth(1),
                          15: FlexColumnWidth(1),
                          16: FlexColumnWidth(1),

                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[400]),
                            children: [
                              tableHeaderCell('Solar Name'),
                              tableHeaderCell('Solar Quantity'),
                              tableHeaderCell('Solar Price'),
                              tableHeaderCell('Inverter Name'),
                              tableHeaderCell('Inverter Quantity'),
                              tableHeaderCell('Inverter Price'),
                              tableHeaderCell('Battery Name'),
                              tableHeaderCell('Battery Quantity'),
                              tableHeaderCell('Battery Price'),
                              tableHeaderCell('Other Name'),
                              tableHeaderCell('Other Quantity'),
                              tableHeaderCell('Other Price'),
                              tableHeaderCell('Buyer Name'),
                              tableHeaderCell('Salesman'),
                              tableHeaderCell('Total Price'),
                              tableHeaderCell('Date'),

                            ],
                          ),
                          TableRow(
                            children: [
                              tableHeaderCell(solarName),
                              tableHeaderCell(solarQuantity.toString()),
                              tableHeaderCell(solarPrice.toString()),
                              tableHeaderCell(inverterType),
                              tableHeaderCell(invertquantity.toString()),
                              tableHeaderCell(inverterPrice.toString()),
                              tableHeaderCell(batteryName),
                              tableHeaderCell(batoryquantityy.toString()),
                              tableHeaderCell(batteryPrice.toString()),
                              tableHeaderCell(othernaame),
                              tableHeaderCell(otherqunaity.toString()),
                              tableHeaderCell(otherpprice.toString()),
                              tableHeaderCell(buyerName),
                              tableHeaderCell(salesmanName),
                              tableHeaderCell(totalprice.toString()),
                              tableHeaderCell(date),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [





                      TextButton(
                        onPressed: () async {
                          Future<Uint8List> loadAssetImage(String path) async {
                            final ByteData data = await rootBundle.load(path);
                            return data.buffer.asUint8List();
                          }

                          Future<void> savePdfToFile(pw.Document pdf) async {
                            final pdfBytes = await pdf.save();
                            Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async => pdfBytes,
                            );
                          }

                          Future<void> generatePdf(PdfPageFormat pageFormat) async {
                            final pdf = pw.Document();

                            // Load image from assets
                            Uint8List imageData = await loadAssetImage('images/print.PNG');

                            pdf.addPage(
                              pw.Page(
                                pageFormat: PdfPageFormat.a4, // Set page format
                                build: (pw.Context context) {
                                  return pw.Stack(
                                    children: [
                                      // 📌 Background Image (Covering Entire Page)
                                      pw.Positioned.fill(
                                        child: pw.Image(
                                          pw.MemoryImage(imageData),
                                          fit: pw.BoxFit.cover, // Ensures the image covers the full page
                                        ),
                                      ),


                                      pw.Center(
                                        child: pw.Container(
                                          padding: pw.EdgeInsets.all(20),  // Adjust padding as needed
                                          // Semi-transparent background for readability
                                          child: pw.Table.fromTextArray(
                                            headers: ['Data', 'Values'],
                                            data: [
                                              ['Solar Name', solarName],
                                              ['Solar Qty', solarQuantity.toString()],
                                              ['Solar Price', solarPrice.toString()],
                                              ['Inverter Name', inverterType],
                                              ['Inverter Quantity', invertquantity.toString()],
                                              ['Inverter Price', inverterPrice.toString()],
                                              ['Battery Name', batteryName],
                                              ['Battery Quantity', batoryquantityy.toString()],
                                              ['Battery Price', batteryPrice.toString()],
                                              ['Other Equipment Name', othernaame],
                                              ['Other Equipment Quantity', otherqunaity.toString()],
                                              ['Other Equipment Price', otherpprice.toString()],
                                              ['Buyer Name', buyerName],
                                              ['Salesman', salesmanName],
                                              ['Total Price', totalprice.toString()],
                                              ['Date', date],
                                            ],
                                            headerStyle: pw.TextStyle(
                                              fontSize: 20,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                            headerDecoration: pw.BoxDecoration(
                                              color: PdfColors.green50, // Header background color
                                              border: pw.Border.all(color: PdfColors.black, width: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );


                            await savePdfToFile(pdf);
                          }

                          await generatePdf(PdfPageFormat.a4);
                        },
                        child: Text(
                          'Print',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
// Helper function to create table header cells


// Helper function to create table header cells

}
