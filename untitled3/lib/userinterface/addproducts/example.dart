import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../Database/Databasehelper.dart';
import '../../resources/component/input_textfield.dart';
import '../ADD_BILLS.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BillsScreen extends StatefulWidget {
  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  TextEditingController textController = TextEditingController();
  String serach = "";
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
 // Sample data list

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(screenWidth),
        ],
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  /// ✅ Background Image
  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/imag2.jpg"), // Background image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// ✅ Main Content
  Widget _buildContent(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildSearchBar(),
          _buildTableHeader(),
          _buildListView(screenWidth),
        ],
      ),
    );
  }

  /// ✅ Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_rounded),
          hintText: 'Search by Customer Name OR Date',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (String value) {
          setState(() {});
        },
      ),
    );
  }

  /// ✅ Table Header
  Widget _buildTableHeader() {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        columnWidths: _tableColumnWidths(),
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[400]),
            children: _headerCells(),
          ),
        ],
      ),
    );
  }

  /// ✅ Table Rows (ListView)
  Widget _buildListView(double screenWidth) {
    return Expanded(
      child: list.isEmpty
          ? Center(child: Text('No Data Available'))
          : ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildTableRow(index, screenWidth);
        },
      ),
    );
  }

  /// ✅ Floating Action Button (Bottom Right)
  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => addbills()));
      },
      backgroundColor: Colors.black,
      child: Icon(Icons.add, color: Colors.white),
    );
  }

  /// ✅ Table Column Widths (For Responsiveness)
  Map<int, TableColumnWidth> _tableColumnWidths() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if(width < 1200){
      return const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),

      };
    }
    return const {
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
    };
  }

  /// ✅ Table Header Cells
  List<Widget> _headerCells() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if(width < 1200){
      return [
        _tableHeaderCell('Data'),
        _tableHeaderCell('Values'),

      ];
    }
    return [
      _tableHeaderCell('Solar Name'),
      _tableHeaderCell('Solar Quantity'),
      _tableHeaderCell('Solar Price'),
      _tableHeaderCell('Inverter Name'),
      _tableHeaderCell('Inverter Quantity'),
      _tableHeaderCell('Inverter Price'),
      _tableHeaderCell('Battery Name'),
      _tableHeaderCell('Battery Quantity'),
      _tableHeaderCell('Battery Price'),
      _tableHeaderCell('Other Name'),
      _tableHeaderCell('Other Quantity'),
      _tableHeaderCell('Other Price'),
      _tableHeaderCell('Buyer Name'),
      _tableHeaderCell('Salesman'),
      _tableHeaderCell('Total Price'),
      _tableHeaderCell('Date'),
      _tableHeaderCell('Actions'),
    ];
  }

  /// ✅ Table Row
  Widget _buildTableRow(int index, double screenWidth) {
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var item = list[index];
    if(textController.text.isEmpty){
      if(width < 1200){
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: _tableColumnWidths(),
            children: [
              TableRow(
                children: [
                  tableHeaderCell('Solar Name'),
                  _tableDataCell(item['solar_name']),

                ],
              ),
              TableRow(
                //  decoration: BoxDecoration(color: Colors.grey[400]),
                children: [
                  tableHeaderCell('Solar Quantity'),
                  _tableDataCell(item['solar_quantity'].toString()),


                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Solar Price'),
                  _tableDataCell(item['solar_price'].toString()),

                ],
              ),
              TableRow(
                // decoration: BoxDecoration(color: Colors.grey[400]),
                children: [

                  //
                  tableHeaderCell('Inverter Name'),
                  _tableDataCell(item['inverter_type']),
                  //
                  //

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Inverter Quantity'),
                  _tableDataCell(item['invertquantity'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Inverter Price'),
                  _tableDataCell(item['inverter_price'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Battery Name'),
                  _tableDataCell(item['batory_name']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Battery Quantity'),
                  _tableDataCell(item['batory_quantity'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Battery Price'),
                  _tableDataCell(item['bactory_price'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Other Name'),
                  _tableDataCell(item['othername']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Other Quantity'),
                  _tableDataCell(item['otherquantity'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Other Price'),
                  _tableDataCell(item['otherprice'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Buyer Name'),
                  _tableDataCell(item['buyer_name']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Salesman'),
                  _tableDataCell(item['salesman_name']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Total Price'),
                  _tableDataCell(item['total_price'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Date'),
                  _tableDataCell(item['date'].toString()),


                ],
              ),

            ],
          ),
        );
      }


      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          columnWidths: _tableColumnWidths(),
          children: [

            TableRow(
              children: [
                _tableDataCell(item['solar_name']),
                _tableDataCell(item['solar_quantity'].toString()),
                _tableDataCell(item['solar_price'].toString()),
                _tableDataCell(item['inverter_type']),
                _tableDataCell(item['invertquantity'].toString()),
                _tableDataCell(item['inverter_price'].toString()),
                _tableDataCell(item['batory_name']),
                _tableDataCell(item['batory_quantity'].toString()),
                _tableDataCell(item['bactory_price'].toString()),
                _tableDataCell(item['othername']),
                _tableDataCell(item['otherquantity'].toString()),
                _tableDataCell(item['otherprice'].toString()),
                _tableDataCell(item['buyer_name']),
                _tableDataCell(item['salesman_name']),
                _tableDataCell(item['total_price'].toString()),
                _tableDataCell(item['date'].toString()),
                _tableActionCell(item),
              ],
            ),
          ],
        ),
      );
    }
    else if((buyerName.toLowerCase().contains(
        textController.text.toLowerCase().toString()))||(date.toLowerCase().contains(
        textController.text.toLowerCase().toString()))){
      if(width < 1200){
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: _tableColumnWidths(),
            children: [
              TableRow(
                children: [
                  tableHeaderCell('Solar Name'),
                  _tableDataCell(item['solar_name']),

                ],
              ),
              TableRow(
                //  decoration: BoxDecoration(color: Colors.grey[400]),
                children: [
                  tableHeaderCell('Solar Quantity'),
                  _tableDataCell(item['solar_quantity'].toString()),


                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Solar Price'),
                  _tableDataCell(item['solar_price'].toString()),

                ],
              ),
              TableRow(
                // decoration: BoxDecoration(color: Colors.grey[400]),
                children: [

                  //
                  tableHeaderCell('Inverter Name'),
                  _tableDataCell(item['inverter_type']),
                  //
                  //

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Inverter Quantity'),
                  _tableDataCell(item['invertquantity'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Inverter Price'),
                  _tableDataCell(item['inverter_price'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Battery Name'),
                  _tableDataCell(item['batory_name']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Battery Quantity'),
                  _tableDataCell(item['batory_quantity'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Battery Price'),
                  _tableDataCell(item['bactory_price'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Other Name'),
                  _tableDataCell(item['othername']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Other Quantity'),
                  _tableDataCell(item['otherquantity'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Other Price'),
                  _tableDataCell(item['otherprice'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Buyer Name'),
                  _tableDataCell(item['buyer_name']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Salesman'),
                  _tableDataCell(item['salesman_name']),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Total Price'),
                  _tableDataCell(item['total_price'].toString()),

                ],
              ),
              TableRow(
                children: [
                  tableHeaderCell('Date'),
                  _tableDataCell(item['date'].toString()),


                ],
              ),

            ],
          ),
        );
      }


      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          columnWidths: _tableColumnWidths(),
          children: [

            TableRow(
              children: [
                _tableDataCell(item['solar_name']),
                _tableDataCell(item['solar_quantity'].toString()),
                _tableDataCell(item['solar_price'].toString()),
                _tableDataCell(item['inverter_type']),
                _tableDataCell(item['invertquantity'].toString()),
                _tableDataCell(item['inverter_price'].toString()),
                _tableDataCell(item['batory_name']),
                _tableDataCell(item['batory_quantity'].toString()),
                _tableDataCell(item['bactory_price'].toString()),
                _tableDataCell(item['othername']),
                _tableDataCell(item['otherquantity'].toString()),
                _tableDataCell(item['otherprice'].toString()),
                _tableDataCell(item['buyer_name']),
                _tableDataCell(item['salesman_name']),
                _tableDataCell(item['total_price'].toString()),
                _tableDataCell(item['date'].toString()),
                _tableActionCell(item),
              ],
            ),
          ],
        ),
      );
    }
    else{
      return Container();
    }

  }

  /// ✅ Table Header Cell Widget
  Widget _tableHeaderCell(String title) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// ✅ Table Data Cell Widget
  Widget _tableDataCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  /// ✅ Table Action Cell (Edit/Delete/Print)
  Widget _tableActionCell(Map<String, dynamic> item) {
    return TableCell(
      child: Center(
        child: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'edit') {
              updatedata(
                item['id'],
                item['solar_name'],
                item['solar_price'],
                item['solar_quantity'],
                item['inverter_type'],
                item['inverter_price'],
                item['batory_name'],
                item['bactory_price'],
                item['batory_quantity'],
                item['buyer_name'],
                item['salesman_name'],
                item['othername'],
                item['invertquantity'],
                item['otherquantity'],
                item['otherprice'],
              );
            } else if (value == 'delete') {
              deletedata(
                item['id'],
                item['solar_name'],
                item['solar_price'],
                item['solar_quantity'],
                item['inverter_type'],
                item['inverter_price'],
                item['batory_name'],
                item['bactory_price'],
                item['batory_quantity'],
                item['buyer_name'],
                item['salesman_name'],
                item['othername'],
                item['invertquantity'],
                item['otherquantity'],
                item['otherprice'],
                item['total_price'],
                item['date'],
                context,
              );
            } else if (value == 'print') {
              printable(
                item['id'],
                item['solar_name'],
                item['solar_price'],
                item['solar_quantity'],
                item['inverter_type'],
                item['inverter_price'],
                item['batory_name'],
                item['bactory_price'],
                item['batory_quantity'],
                item['buyer_name'],
                item['salesman_name'],
                item['othername'],
                item['invertquantity'],
                item['otherquantity'],
                item['otherprice'],
                item['total_price'],
                item['date'],
                context,
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'edit', child: Text("Update")),
            PopupMenuItem(value: 'delete', child: Text("Delete")),
            PopupMenuItem(value: 'print', child: Text("Print")),
          ],
        ),
      ),
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
  //delete
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
}
