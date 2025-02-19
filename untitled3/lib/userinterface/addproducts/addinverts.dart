
import 'package:flutter/material.dart';

import '../../Database/Databasehelper.dart';
import '../../resources/component/input_textfield.dart';
import '../ADD_BILLS.dart';
import 'ADD_PRODUCTS.dart';

class addinvertr extends StatefulWidget {

  const addinvertr({super.key});

  @override
  State<addinvertr> createState() => _addinvertrState();
}

class _addinvertrState extends State<addinvertr> {
  final insatnace =  Databasehelper();
  TextEditingController textController = TextEditingController();
  String serach = "";
  List<Map<String, dynamic>> invertlist =[];
  void initState() {
    // TODO: implement initState
    invertfn();
    super.initState();
  }
  //inveter retrive data
  Future<void> invertfn()async{
    final data = await insatnace.getInverterData();
    setState(() {
      invertlist=data!;
    });
  }

  Widget tableHeaderCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
    return Scaffold(
       appBar:  AppBar(
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

        body: invertlist.isEmpty
            ? Stack(
          children: [
            Center(child: Text('No Data')),
            Positioned(
              bottom: 80,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  updatedata();
                  // ElevatedButton action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 20, color: Colors.red),
                ),

                child: Text("Addnew",style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        )
            : Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                  AssetImage("images/img_2.png"), // Your image asset
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
                          hintText: 'Serach by Name',
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
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),

                      },
                      children: [
                        TableRow(
                          decoration:
                          BoxDecoration(color: Colors.grey[400]),
                          children: [
                            tableHeaderCell('Inverter Name'),
                            tableHeaderCell('Inverter Quantity'),
                            tableHeaderCell('Inverter Price'),

                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: invertlist.length,
                      itemBuilder: (context, index) {
                        final id = invertlist[index]['id'];
                        String solarName = invertlist[index]['name'] ?? '';
                        int solarPrice =
                        (invertlist[index]['price'] ?? 0).toInt();
                        int solarQuantity =
                        (invertlist[index]['quantity'] ?? 0).toInt();

                        if(textController.text.isEmpty){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Table(
                                border: TableBorder.all(color: Colors.black),
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),

                                },
                                children: [
                                  TableRow(
                                    children: [
                                      tableDataCell(invertlist[index]['name']),
                                      tableDataCell(invertlist[index]
                                      ['quantity']
                                          .toString()),
                                      tableDataCell(invertlist[index]['price']
                                          .toString()),

                                      TableCell(
                                        child: Center(
                                          child: PopupMenuButton(
                                            icon: Icon(Icons.more_vert),
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                // updatedata(
                                                //     id,
                                                //     solarName,
                                                //     solarPrice,
                                                //     solarQuantity,
                                                // )

                                              }
                                              else if(value =='delete'){
                                                // deletedata(id, solarName,
                                                //     solarPrice,
                                                //     solarQuantity,
                                                //     context);
                                              }
                                              else if(value=='print'){
                                                // printable(id, solarName,
                                                //     solarPrice,
                                                //     solarQuantity,
                                                //      context);

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
                        else if(solarName.toLowerCase().contains(
                            textController.text.toLowerCase().toString())){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Table(
                                border: TableBorder.all(color: Colors.black),
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),

                                },
                                children: [
                                  TableRow(
                                    children: [
                                      tableDataCell(invertlist[index]['name']),
                                      tableDataCell(invertlist[index]
                                      ['quantity']
                                          .toString()),
                                      tableDataCell(invertlist[index]['price']
                                          .toString()),

                                      TableCell(
                                        child: Center(
                                          child: PopupMenuButton(
                                            icon: Icon(Icons.more_vert),
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                // updatedata(
                                                //     id,
                                                //     solarName,
                                                //     solarPrice,
                                                //     solarQuantity,
                                                // )

                                              }
                                              else if(value =='delete'){
                                                // deletedata(id, solarName,
                                                //     solarPrice,
                                                //     solarQuantity,
                                                //     context);
                                              }
                                              else if(value=='print'){
                                                // printable(id, solarName,
                                                //     solarPrice,
                                                //     solarQuantity,
                                                //      context);

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
                  updatedata();
                  // ElevatedButton action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 20, color: Colors.red),
                ),

                child: Text("Addnew",style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
  final solarnamecontroller = TextEditingController();
  final solarquantitycontroller = TextEditingController();
  final solarprice = TextEditingController();


  final form = GlobalKey<FormState>();
  final instance = Databasehelper();

  Future<void> updatedata(

      ) {


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
                      AssetImage("images/img_2.png"), // Your image asset
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
                                SizedBox(
                                  height: height * .010,
                                ),
                                textfield(
                                  mycontroller: solarnamecontroller,
                                  fieldSetter: (value) {},
                                  keyBoradtype: TextInputType.text,
                                  obscureText: false,
                                  hint: "Inverter Type",
                                  fieldValidator: (value) {
                                    return value.isEmpty ? 'enter type' : null;
                                  },
                                  label: 'Inverter Type',
                                ),
                                SizedBox(
                                  height: height * .010,
                                ),
                                textfield(
                                  mycontroller: solarquantitycontroller,
                                  // focusNode:passwordf,
                                  fieldSetter: (value) {},
                                  keyBoradtype: TextInputType.number,
                                  obscureText: false,
                                  hint: "Inverter Quantity",
                                  fieldValidator: (value) {
                                    return value.isEmpty
                                        ? 'enter quantity'
                                        : null;
                                  },
                                  label: 'Inverter Quantity',
                                ),
                                SizedBox(
                                  height: height * .010,
                                ),
                                textfield(
                                  mycontroller: solarprice,
                                  fieldSetter: (value) {},
                                  keyBoradtype: TextInputType.number,
                                  obscureText: false,
                                  hint: "Inverter Price",
                                  fieldValidator: (value) {
                                    return value.isEmpty ? 'enter price' : null;
                                  },
                                  label: 'Inverter Price',
                                ),

                                SizedBox(
                                  height: height * .010,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(

                                      onPressed: () {

                                        if(form.currentState!.validate()){


                                          // Ensure correct type conversions
                                          int solarQuantity =
                                          int.parse(solarquantitycontroller.text);
                                          int solarPrice = int.parse(solarprice.text);
                                          int total_price = solarPrice*solarQuantity;

                                          // Insert the data
                                          instance
                                              .insertInverter(
                                            solarnamecontroller.text,
                                            solarQuantity,
                                            total_price,
                                          )
                                              .then((onValue) {
                                            setState(() {
                                              insatnace.updateinvertrQuantity(solarQuantity, total_price);
                                              instance.incrementinverterstachupdate(solarQuantity);
                                             invertfn();

                                            });
                                            solarquantitycontroller.clear();
                                            solarnamecontroller.clear();
                                            solarprice.clear();
                                            Navigator.pop(context);


                                          });
                                        }

                                      },
                                      child: Text('Addnew',style: TextStyle(color: Colors.white)),
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
}
