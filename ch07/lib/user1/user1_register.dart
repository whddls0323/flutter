import 'package:ch07/user1/user1.dart';
import 'package:ch07/user1/user1_service.dart';
import 'package:flutter/material.dart';

class User1Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _User1RegisterState();
}

class _User1RegisterState extends State<User1Register> {
  final _forKey = GlobalKey<FormState>();

  final _useridController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _ageController = TextEditingController();

  final service = User1Service();

  String message = '';

  Future<void> _submitForm() async {
    if(!_forKey.currentState!.validate()) return;

    User1 inputUser = User1(
      userid: _useridController.text,
      name: _nameController.text,
      birth: _birthController.text,
      age: int.tryParse(_ageController.text) ?? 0
    );

    try {
      User1 savedUser = await service.postUser(inputUser);
      print('savedUser: ${savedUser}등록');

    } catch(err) {
      setState(() {
        message = '등록실패, 에러발생 했습니다. $err';
      });
    }
  }

  void showDialog(String title, String message) {
  }

  Future<void> selectBirth() async {
    DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1900),
        lastDate: now
    );

    if(selectedDate != null) {
      setState(() {
        _birthController.text = selectedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('User1 등록'),),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _forKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _useridController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '아이디 입력'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '이름 입력'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _birthController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '생년월일 입력'
                    ),
                    readOnly: true,
                    onTap: selectBirth,
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '나이 입력'
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text('취소')),
                      const SizedBox(width: 10,),
                      ElevatedButton(onPressed: _submitForm, child: const Text('등록')),
                    ],
                  ),
                  Text(message)
                ],
              )
          ),
        )
    );
  }
}