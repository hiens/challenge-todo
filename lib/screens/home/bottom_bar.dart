import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar(
      {required this.activeIndex, required this.onTap, Key? key})
      : super(key: key);
  final int activeIndex;
  final Function(int) onTap;

  Widget _buildBottomAppBarItem({
    required bool isActive,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.grey[700],
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(top: 4),
                width: isActive ? 55 : 0,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <String>['All', 'Incomplete', 'Completed']
              .asMap()
              .map((int index, String label) {
                return MapEntry<int, Widget>(
                  index,
                  Expanded(
                    child: _buildBottomAppBarItem(
                      isActive: activeIndex == index,
                      label: label,
                      onTap: () => onTap(index),
                    ),
                  ),
                );
              })
              .values
              .toList(),
        ),
      ),
    );
  }
}
