
import 'package:ch07/user1/user1_register.dart';
import 'package:flutter/material.dart';

class User1List extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _User1ListState();
}

class _User1ListState extends State<User1List> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User1 목록'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // 등록 이동
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => User1Register()
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: null,
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError) {
              return Text('에러발생 : ${snapshot.error}');
            }else if(snapshot.hasData){
              return Text('결과 : ${snapshot.data}');
            }

            final userList = snapshot.data;

            return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('홍'),
                      ),
                      title: Text('홍길동(아이디)'),
                      subtitle: Text('26세(1990-09-01)'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit), color: Colors.blue,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete), color: Colors.red,),
                        ],
                      ),

                    ),
                  );
                }
            );

          }
      ),
    );
  }
}