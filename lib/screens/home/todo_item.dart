part of 'home.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(this.todo,
      {required this.onTap, required this.onRemoved, required Key? key})
      : super(key: key);
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onRemoved;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
          child: Row(
            children: <Widget>[
              Container(
                child: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (bool? value) {},
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        todo.task,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          decorationThickness: 8,
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      if (todo.description != null)
                        Text(
                          todo.description!,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.grey[700],
                            decorationThickness: 4,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ),
              if (todo.isCompleted)
                IconButton(onPressed: onRemoved, icon: const Icon(Icons.close))
              else if (todo.deadline != null)
                Container(
                  child: Text(
                    DateFormat.jm().format(todo.deadline!) +
                        '\n' +
                        DateFormat.MMMd().format(todo.deadline!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
