import 'package:flutter/material.dart';

class SelectedTask extends StatelessWidget {
  final String content;
  const SelectedTask({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      color: Colors.blue,
      child: Row(
        children: [
          Text(content, style: TextStyle(color: Colors.white)),
          Spacer(),
          GestureDetector(
              onTap: () => showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('AlertDialog Title'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('This is a demo alert dialog.'),
                              Text('Would you like to approve of this message?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Approve'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  ),
              child: Icon(Icons.open_in_new, color: Colors.white)),
        ],
      ),
    );
  }
}
