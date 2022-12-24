import 'package:flutter/material.dart';

class billsplitter extends StatefulWidget {
  const billsplitter({Key? key}) : super(key: key);

  @override
  State<billsplitter> createState() => _billsplitterState();
}

class _billsplitterState extends State<billsplitter> {
  int _tipPercentage=0;
  int _personCount=1;
  double _billAmount=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
        child: ListView(
          padding: EdgeInsets.all(20.5),
          children:<Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Total Per Person",style: TextStyle(color: Colors.white),),
                    ),
                    Text("\$${calculateTotalPerson(_tipPercentage,_billAmount,_personCount)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)
                  ],
                ),
              ),
            ),
           Container(
             margin: EdgeInsets.only(top: 20.0),
             padding: EdgeInsets.all(12.0),
             decoration: BoxDecoration(
               color: Colors.transparent,
               border:Border.all(color: Colors.blueGrey.shade100,style: BorderStyle.solid),
               borderRadius: BorderRadius.circular(12.0)
             ),
             child: Column(
               children: <Widget>[
                 TextField(
                   keyboardType: TextInputType.numberWithOptions(decimal: true),
                   style: TextStyle(color: Colors.grey),
                   decoration: InputDecoration(
                     fillColor: Colors.deepPurple,
                    prefixText:"Bill Amount :",
                      prefixIcon: Icon(Icons.attach_money)
                   ),
                   onChanged: (String value) {
                     try
                     {
                       _billAmount=double.parse(value);
                     }
                     catch(exception)
                     {
                       _billAmount=0.0;
                     }
                   },
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                    Text("Split",style: TextStyle(color: Colors.grey.shade700),),
                     Row(
                       children: <Widget>[
                         InkWell(
                           onTap: (){
                             setState(() {
                               if(_personCount>1)
                                 {
                                    _personCount--;
                                 }
                               else
                                 {
                                 //  do nothing
                                 }

                             });
                           },
                           child: Container(
                             width:MediaQuery.of(context).size.width*0.08,
                             height: MediaQuery.of(context).size.height*0.05,
                             margin: EdgeInsets.all(10.0),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(7.0),
                               color: Colors.deepPurpleAccent.shade100
                             ),
                             child: Center(
                               child: Text(
                                 "-",style: TextStyle(
                                 fontSize: 17.0,
                                 fontWeight: FontWeight.bold,
                               ),),),
                           ),
                         ),
                         Text("$_personCount"),
                         InkWell(
                           onTap: (){
                             setState(() {
                              _personCount++;
                             });
                           },
                           child: Container(
                             width:MediaQuery.of(context).size.width*0.08,
                             height: MediaQuery.of(context).size.height*0.05,
                             margin: EdgeInsets.all(10.0),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7.0),
                                 color: Colors.deepPurpleAccent.shade100
                             ),
                             child: Center(
                               child: Text(
                                 "+",style: TextStyle(
                                 fontSize: 17.0,
                                 fontWeight: FontWeight.bold,
                               ),),),
                           ),
                         ),
                       ],
                     ),
               ],
             ),

                 Padding(
                   padding: const EdgeInsets.only(left:0,top: 10.0,right: 10.0,bottom: 10.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("Tip",style: TextStyle(fontSize: 16,color: Colors.grey.shade700),),
                       Text("\$${calculateTotalTip(_billAmount,_personCount,_tipPercentage)}",style: TextStyle(fontSize: 16,color: Colors.deepPurple,fontWeight: FontWeight.bold),)
                     ],
                   ),
                 ),
                 Column(
                   children: <Widget>[
                     Text("$_tipPercentage%",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),)
                   ],
                 ),
                 Slider(
                   min: 0,
                   max: 100,
                   activeColor: Colors.deepPurple,
                     value: _tipPercentage.toDouble(), onChanged:(double value){
                   setState(() {
                     _tipPercentage=value.round();
                   });
                 })
               ],
             )
           )
          ],
        ),
      ),
    );

  }
  calculateTotalPerson(int tipPercentage,double billAmount,int splitby)
  {
    var totalPerPerson=(calculateTotalTip(billAmount, splitby, tipPercentage)+billAmount)/splitby;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount,int splitby,int tipPercentage)
  {
    double totalTip=0.0;
    if(billAmount<0||billAmount.toString().isEmpty||billAmount==null)
    {

    }
    else
    {
      totalTip=(billAmount*tipPercentage)/100;
    }
    return totalTip;
  }
}
