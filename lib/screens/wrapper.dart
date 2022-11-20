import 'package:flutter/material.dart';
import 'package:org_off_ia/screens/authenticate/authenticate.dart';
import 'package:org_off_ia/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:org_off_ia/models/user.dart';
import 'package:org_off_ia/screens/admin_home/admin_home.dart';

import 'package:org_off_ia/services/auth.dart';

class Wrapper extends StatelessWidget {

   Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
// what screen to return 

    if (user == null) {
      return Authenticate();
      
    
    }
    else if (user.isAdmin == true) {
      return AdminHome();


    }
    else  {
      return  Home();
    }
    
  }
}