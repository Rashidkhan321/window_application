
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/Database/Databasehelper.dart';
import 'package:untitled3/resources/component/round_button.dart';
import 'package:untitled3/userinterface/Home.dart';

import '../resources/component/input_textfield.dart';

class addbills extends StatefulWidget {
  const addbills({super.key});

  @override
  State<addbills> createState() => _addbillsState();
}

class _addbillsState extends State<addbills> {
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
   List<Map<String, dynamic>> list=[];
   Future getstac()async{
     final data = await instance.stac();
     setState(() {
       list = data!;
     });
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getstac();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(

    appBar:   AppBar(
        automaticallyImplyLeading: false,
        leading:         IconButton(
          icon: Icon(Icons.arrow_back_ios), // You can use any icon
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => homeScreen()),
            );
          },
        ),
        actions: [


        ],
      ),
      body: list.isEmpty? Text('NO Material in Stack'):


            Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/imag2.jpg"), // Your image asset
                    fit: BoxFit.cover, // Adjust how the image is displayed
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius:   BorderRadius.circular(15)
                  ),
                  width: 1000,
                  child:

    ListView.builder(
    itemCount: list.length,
    itemBuilder: (

    BuildContext context, int index) {
    final solar= list[index]['solar'];
    final invert = list[index]['inverter'];
    final other = list[index]['other'];
    final battery = list[index]['battery'];
    return
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Form( key:  form,

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




                                ],
                              ),

                            ),
                            Roundbutton(
                              title: 'Submit',
                              onpress: () {
                                String currentDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());


                                // Ensure correct type conversions

                                if(form.currentState!.validate()){
                                  int solarQuantity = int.parse(solarquantitycontroller.text);
                                  int solarPrice = int.parse(solarprice.text);
                                  int batoryQuantity = int.parse(batoryquantity.text);
                                  int batoryPrice = int.parse(batoryprice.text);
                                  int inverterPrice = int.parse(invertorprice.text);
                                  int totalsolarprice = solarPrice*solarQuantity;
                                  int invertquantity = int.parse(invertqunaity.text);
                                  int otherqunattity = int.parse(otherqunatity.text);
                                  int othrprice = int.parse(otherprice.text);
                                  int totalinvertprice = invertquantity*inverterPrice;
                                  int totalotherprice = otherqunattity*othrprice;
                                  int totalbatteryprice = batoryPrice*batoryQuantity;
                    if(other<otherqunattity){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('The number of Equipemnts in Stack is less '+other.toString() +' < '+ otherqunattity.toString()),
                          duration: Duration(seconds: 2),
                        ));
                    }
                                else  if(solar<solarQuantity){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('The number of Solar in Stack is less '+solar.toString() +' < '+ solarQuantity.toString()),
                                          duration: Duration(seconds: 2),
                                        ));
                                  }
                    else  if(invert<invertquantity){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('The number of Inverter in Stack is less  '+invert.toString()+' < '+ invertquantity.toString()),
                            duration: Duration(seconds: 2),
                          ));
                    }   else  if(battery<batoryQuantity){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('The number of Batteries in Stack is less ' +battery.toString() +' < '+ batoryQuantity.toString()),
                            duration: const Duration(seconds: 2),
                          ));
                    }
                    // else if(){
                    //
                    // }
                    // else if(){
                    //
                    // }
                    else {
                      instance.insertdata(
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



                      ).then((onValue){

                        instance.updatedbatteryQuantity(batoryQuantity, batoryQuantity, totalbatteryprice);
                        instance.updatedinvertrQuantity(invertquantity, invertquantity, totalinvertprice);
                        instance.updatedSolarQuantity(solarQuantity, solarQuantity,totalsolarprice );
                        instance.updatedotherQuantity(otherqunattity , otherqunattity,totalotherprice );
                        instance.decrementbatterystachupdate(batoryQuantity);
                        instance.decrementinverterstachupdate(invertquantity);
                        instance.decrementotherstachupdate(otherqunattity);
                        instance.decrementsolarstachupdate(solarQuantity);
                        buyernamecontrolelr.clear();
                        solarnamecontroller.clear();
                        solarquantitycontroller.clear();
                        solarprice.clear();
                        batorynamecontoller.clear();
                        batoryquantity.clear();
                        sellernamecontroller.clear();
                        invertypecontroller.clear();
                        invertorprice.clear();
                        batoryprice.clear();
                        otherqunatity.clear();
                        otherprice.clear();
                        othername.clear();
                        invertqunaity.clear();


                      });
                    }
                                }
                                // Insert the data


                              },
                            )
                          ],
                        ),
                      ),
                    );
    }
                  )
                ),
              ),
            ],
          )

    );
  }
}
