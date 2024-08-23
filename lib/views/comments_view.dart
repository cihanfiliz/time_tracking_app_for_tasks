import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/comment_viewmodel.dart';

class CommentsView extends StatefulWidget {
  final String taskId;

  CommentsView({required this.taskId});

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    // Fetch comments when the view is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommentViewModel>(context, listen: false).fetchComments(widget.taskId);
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentViewModel = Provider.of<CommentViewModel>(context);

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
                    controller: textEditingController,
                    decoration: InputDecoration(labelText: 'Add a comment'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    commentViewModel.addComment(widget.taskId, textEditingController.text);
                    textEditingController.clear();
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
