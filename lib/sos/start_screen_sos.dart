import 'package:flutter/material.dart';
import 'package:women_safety_app/sos/second_screen_sos.dart';

class StartScreenSOS extends StatelessWidget {
  const   StartScreenSOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(
            child:Image(image: AssetImage("assets/in_use_sos.png"),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height/2.6,
              width: MediaQuery.of(context).size.width,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: ContinuousRectangleBorder (
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.zero,
                          topRight:   Radius.zero,
                          topLeft: Radius.circular(150)
                      ),
                      side: BorderSide(
                        color: Colors.black12,
                        width: 2,
                      )
                  )
              ),
              child: Column(
                children: [
                  Center(
                    child: Text("_ _ _",style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w900
                    )
                      ,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40,right: 40,top:40,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            "Click",
                            style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold)
                        ),
                        Text(
                            "để thông báo cho mọi người!",
                            style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold,color: Colors.blue)
                        ),
                        SizedBox(height: 20,),
                        Text(
                            "Bạn có thể thêm người vào danh sách tin cậy\nvà thông báo tới họ trọng trường hợp khẩn cấp\nhoặc chỉ đơn giản là lắc điện thoại 3 lần để làm điều đó.",
                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300)
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 10,),
                    child: Row(
                      children: [
                        TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Bỏ qua')),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  SecondScreenSOS()),
                            );
                          },
                          child: Icon(Icons.play_arrow_sharp, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Color.fromRGBO(106, 0, 191,1),
                          ),
                        )
                      ],
                    ),)
                ],
              )
          )
        ],
      ),
    );
  }
}
