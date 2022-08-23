import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/models/user_model.dart';

import '../../providers/users_provider.dart';
import '../../shared/components/components.dart';

class DeleteDailyMission extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var missionName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot){
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? const Center(child:Text('No User')) : Scaffold(
            backgroundColor: Colors.white70,
            appBar: AppBar(
              backgroundColor: Colors.amberAccent,
              iconTheme: const IconThemeData(
                color: Colors.deepPurple,
              ),
              title: const Text("Delete Daily Mission",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            body: SingleChildScrollView(
              child:
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    const SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultFormField(
                            controller: missionName,
                            type: TextInputType.name,
                            validate: (value) {
                              return validate(value!);
                            },
                            label: "Mission Name",
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                          function: () async{
                            if(formKey.currentState!.validate()) {
                              final provider = Provider.of<UsersProvider>(context, listen: false);
                              await provider.getUsersData();
                              await provider.deleteDailyMission(
                                missionName: missionName.text.capitalize(),
                                context: context,
                              );
                            }
                          },
                          text: "Delete Mission",
                          isUpperCase: false,
                          textColor: Colors.deepPurple,
                          fontSize: 20.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
