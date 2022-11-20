
import 'package:flutter/material.dart';
import 'package:flutter/src/material/text_button.dart';
import 'package:org_off_ia/models/user.dart';
import 'package:org_off_ia/services/auth.dart';
import 'package:org_off_ia/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';



class AdminHome extends StatefulWidget {



  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final AuthService _auth = AuthService();
  String documentId = '';


// setting vales for key value pairs
   int amountLeft = 1;

   int borrowAmount = 0;

   int threshold = 1;

   String itemName = "";

   List<String>  typeOfUse = ['Permanent', 'Borrowed'];

   String typeOf = 'Permanent';

   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


     
   // add item

      addItem() {
       DocumentReference documentsReference = FirebaseFirestore.instance.collection('workItems').doc(itemName);


      Map<String, dynamic> myItems = {
        "amountLeft": amountLeft,
        "borrowAmount": borrowAmount,
        "threshold": threshold,
        "itemName": itemName,
        "typeOfUse": typeOf
      };
      documentsReference.set(myItems).whenComplete(() => print("data"));



    }
    getDoc() async {
      QuerySnapshot getItems = await FirebaseFirestore.instance.collection('workItems').get();
      return getItems;

    }

      // delete all items
   deleteAll() async {
      QuerySnapshot getItems = await FirebaseFirestore.instance.collection('workItems').get();
          
  
      for (var doc in getItems.docs) {
         doc.reference.delete();
      }

    }
    // edit items
    editItem() {
    print(itemName);
    print(documentId);
      DocumentReference documentsReference = FirebaseFirestore.instance.collection("workItems").doc(documentId);
;

      Map<String, dynamic> myItems = {
        "amountLeft": amountLeft,
        "borrowAmount": borrowAmount,
        "threshold": threshold,
        "itemName": itemName,
        "typeOfUse": typeOf
      };
      print(documentId);
      documentsReference.update(myItems).whenComplete(() => print("data"));


    }
    // settings UI
    
     settings() {
      return SingleChildScrollView(
        child: Form(
        key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update item',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text('What is the item name?'),

                   SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: itemName,
                    decoration: decor,
                    validator: (val) => val!.isEmpty ? 'Please enter an item name' : null,
                    onChanged: (val) => setState(() => itemName = val) 
        
              ),
              Text('How many of this item are left?'),
              TextFormField(
                // controller: textController,
                keyboardType: TextInputType.numberWithOptions(decimal: true) ,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      
                    decoration: decor,
                    validator: (val) => val!.isEmpty ? 'Please enter an item amount' : null,
                    onChanged: (val) => setState(() => amountLeft = val != null ? int.parse(val) : 0   ) 
        
              ),
              Text('What is the amount of the item needed before a new one must be ordered?'),

              TextFormField(

                // controller: textController,
                keyboardType: TextInputType.numberWithOptions(decimal: true) ,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      
                    decoration: decor,
                    validator: (val) => val!.isEmpty ? 'Please enter a threshold amount' : null,
                    onChanged: (val) => setState(() => threshold = int.parse(val)) 
        
              ),
              Text('Is this item for temporary use?'),

              DropdownButtonFormField(
                      decoration: decor,
                      value: typeOf,
                      items: typeOfUse.map((typeOfUse) {
                        return DropdownMenuItem(
                          value: typeOfUse,
                          child:Text(typeOfUse)
                        );
        
                      }).toList(),
                      onChanged: (val) => setState(() => typeOf = val as String)),
             
             
              ElevatedButton(
                
                child: Text("Update") ,
                onPressed: () {
                  addItem();
                  
                } ,
              )
              ],
              
              
              )
              ),
      );
  }
  // edit settings UI
 editSettings() {
 
     return SingleChildScrollView(
        child: Form(
        key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update item',
                    style: TextStyle(fontSize: 18.0),
                  ),
                 
              Text('How many of this item are left?'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true) ,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      
                    decoration: decor,
                    validator: (val) => val!.isEmpty ? 'Please enter an item amount' : null,
                    onChanged: (val) => setState(() => amountLeft = int.parse(val)) 
        
              ),
              Text('What is the amount of the item needed before a new one must be ordered?'),

              TextFormField(

                keyboardType: TextInputType.numberWithOptions(decimal: true) ,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      
                    decoration: decor,
                    validator: (val) => val!.isEmpty ? 'Please enter a threshold amount' : null,
                    onChanged: (val) => setState(() => threshold = int.parse(val)) 
        
              ),
              Text('Is this item for temporary use?'),

              DropdownButtonFormField(
                      decoration: decor,
                      value: typeOf,
                      items: typeOfUse.map((typeOfUse) {
                        return DropdownMenuItem(
                          value: typeOfUse,
                          child:Text(typeOfUse)
                        );
        
                      }).toList(),
                      onChanged: (val) => setState(() => typeOf = val as String)),
             
          
           ElevatedButton(
              
              child: Text("Update") ,
              onPressed: () {
                setState(() {
                  editItem();
                });
               
                


                
              } ,
            )
            ],
            
            
            ),
            ));
  }

// main UI
     return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
    
              },
            ),
            Visibility(
             visible: true, 
            child: TextButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Create New Item'),
              onPressed: () => showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
          child: settings(),
        );
      }),
            )),
            Visibility(
             visible: true,

              child: TextButton.icon(
              icon: Icon(Icons.delete),
              label: Text('Delete All'),
              onPressed: () => deleteAll()
        
              ),
            
            )],
          
        ),

      
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('workItems').orderBy('amountLeft').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

       return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          
          return Container(
            color: Colors.white,
            child:  Card (
            
              child:  ListTile(
              tileColor: data['amountLeft'] > data['threshold'] ? Colors.green[400]: Colors. red,
              
              title: Center(child: Text(data['itemName'])),
              subtitle: Center(child: Text(data['typeOfUse'])),
              trailing: ElevatedButton
              (child: Text("Edit"),
              
              onPressed: () { 
              setState(() {
               documentId = document.id; 
               print('oneoneoneone');
               print(documentId);
               print("adonadaf");


                itemName = data['itemName'];
                

              });
              showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
          child: editSettings(),
           

        );
      });}
              ),
              
              

            ),

            color: amountLeft > threshold ? Colors.blue: Colors.red,

            ));
          
      
            
          }).toList(),
           
        );
        
        
      },
    ) ,
        )
    
      );
      
  }
}