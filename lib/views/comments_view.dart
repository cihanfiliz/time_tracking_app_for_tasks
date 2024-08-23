import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/comment_viewmodel.dart';

class CommentsView extends StatelessWidget {
  final String taskId;

  CommentsView({required this.taskId});

  @override
  Widget build(BuildContext context) {
    final commentViewModel = Provider.of<CommentViewModel>(context);
    commentViewModel.fetchComments(taskId);
    String submittedComment = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: commentViewModel.comments.length,
              itemBuilder: (context, index) {
                final comment = commentViewModel.comments[index];
                return ListTile(
                  title: Text(comment.content),
                  subtitle: Text(comment.postedAt),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Add a comment'),
                    onChanged: (value) {
                      submittedComment = value;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    commentViewModel.addComment(taskId, submittedComment);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
