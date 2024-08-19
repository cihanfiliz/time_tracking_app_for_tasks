import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/project_viewmodel.dart';
import 'viewmodels/task_viewmodel.dart';
import 'viewmodels/comment_viewmodel.dart';
import 'views/kanban_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectViewModel()),
        ChangeNotifierProvider(create: (context) => TaskViewModel()),
        ChangeNotifierProvider(create: (context) => CommentViewModel()),
      ],
      child: MaterialApp(
        title: 'Todoist Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: KanbanBoard(),
      ),
    );
  }
}
