import 'package:flutter/material.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/modules/admin/admin_screen.dart';

import '../../shared/components/components.dart';

class AddDailyMission extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var missionName = TextEditingController();
  var missionCount = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text("Add Daily Mission",
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
                      label: "First Mission Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: missionCount,
                      type: TextInputType.number,
                      validate: (value) {
                        return validate(value!);
                      },
                      label: "First Mission Count",
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultButton(
                    function: (){
                      if(formKey.currentState!.validate()) {
                        addDailyMissions(
                          missionName: missionName.text,
                          missionCount: int.parse(missionCount.text),
                          context: context,
                        );
                      }
                    },
                    text: "Add Mission",
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
  }
}
