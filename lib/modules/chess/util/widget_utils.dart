// @dart=2.9

import 'package:win_money_game/modules/chess/util/utils.dart';
import 'package:win_money_game/modules/chess/widgets/divider.dart';
import 'package:flutter/material.dart';

RoundedRectangleBorder roundButtonShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(45));

typedef void OnDialogCancelCallback(value);
typedef void OnDialogReturnSetStateCallback(BuildContext context, setState);

bool _showing = false;

void showAnimatedDialog({
  String title,
  String text,
  String onDoneText,
  String forceCancelText,
  List<Widget> children = const [],
  OnDialogCancelCallback onDone,
  OnDialogReturnSetStateCallback setStateCallback,
  IconData icon,
  var update,
  bool showAnyActionButton = true,
  bool withInputField = false,
  String inputFieldHint,
}) async {
  if (_showing) return;

  _showing = true;

  String inputText;

  //show dialog
  showGeneralDialog(
    context: ContextSingleton.context,
    barrierDismissible: true,
    barrierLabel: "showTextDialog",
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(
          opacity: a1.value,
          child: StatefulBuilder(builder: (context, setState) {
            //call the listener that returns the set state
            if (setStateCallback != null) setStateCallback(context, setState);
            //create the alert dialog object
            return AlertDialog(
              backgroundColor: Colors.amberAccent,
              title: Row(
                children: [
                  icon == null ? Container() : Icon(
                      icon,
                    color: Colors.deepPurple,
                  ),
                  Divider(),
                  Text(
                    title ?? "",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                    ),

                  ),
                ],
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  (text == null)
                      ? SizedBox()
                      : Container(
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Text(
                          text ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                          Visibility(
                            visible: withInputField,
                            child: TextFormField(
                              maxLines: 1,
                              onChanged: (value) => inputText = value,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: inputFieldHint),
                            ),
                          )
                        ] +
                        children,
                  ),
                ],
              ),
              actions: showAnyActionButton
                  ? [
                      FlatButton(
                          shape: roundButtonShape,
                          child: Text(forceCancelText != null
                              ? forceCancelText
                              : (onDone == null ? "Ok" : "Cancel"),
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            _showing = false;
                            Navigator.of(context)
                                .pop(onDone == null ? 'Ok' : null);
                          }),
                      onDone != null
                          ? FlatButton(
                              shape: roundButtonShape,
                              child: Text(
                                onDoneText ?? "",
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                              onPressed: () {
                                _showing = false;
                                Navigator.of(context).pop('Ok');
                              })
                          : Container()
                    ]
                  : [],
            );
          }),
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 300),
  ).then((value) {
    //set showing dialog false
    _showing = false;
    //execute the on done
    if (onDone != null && value != null) {
      if(withInputField)
        onDone(inputText);
      else
        onDone(value);
    }
  });
}
