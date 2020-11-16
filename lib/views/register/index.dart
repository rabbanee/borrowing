part of '../view.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Register",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 60),
                Container(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.grey))),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "E-mail",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.grey))),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.grey))),
                        style: TextStyle(fontSize: 15),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.purple),
                      child: Center(
                          child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("have any account ? ",
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.purple, fontSize: 13),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
