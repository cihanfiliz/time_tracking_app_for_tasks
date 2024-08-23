import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kanban_board_view.dart';
import 'completed_tasks_view.dart';
import '../viewmodels/task_viewmodel.dart';
import '../viewmodels/comment_viewmodel.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    KanbanBoardView(),
    CompletedTasksView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_column),
            label: 'Kanban Board',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}
