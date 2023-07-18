import 'package:flutter/material.dart';

import '../../ui/colors.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final List<Color> noteColors = [
    roseBud,
    primrose,
    wisteria,
    skyBlue,
    illusion
  ];

  Color _color = skyBlue;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
      body: AnimatedContainer(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        color: _color,
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: noteColors
                  .map(
                    (color) => InkWell(
                      onTap: () {
                        setState(() {
                          _color = color;
                        });
                      },
                      child: _buildBackgroundColor(
                          color: color, selected: _color == color),
                    ),
                  )
                  .toList(),
            ),
            TextField(
              controller: _titleController,
              maxLines: 1,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: darkGray,
                  ),
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요',
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _contentController,
              maxLines: null,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: darkGray,
                  ),
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundColor({
    required Color color,
    required bool selected,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 5.0,
              spreadRadius: 1.0)
        ],
        border: selected
            ? Border.all(
                color: Colors.black,
                width: 3.0,
              )
            : null,
      ),
    );
  }
}
