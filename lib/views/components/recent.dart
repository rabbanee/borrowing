part of '../views.dart';

class Recent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Recent Request",
                        style: TextStyle(
                            color: Colors.purple[700],
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[200]))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('1',
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text("Send Request To James",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Column(children: [
                                Text("3 days ago",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                Text("Status",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13))
                              ])
                            ])),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text('2',
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Text("Send Received From Cherly",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Column(
                            children: [
                              Text("Yesterday",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                              Text("Status",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
