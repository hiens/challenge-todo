import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  Widget _buildBottomAppBarItem({required bool isActive}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Completed',
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.grey[700],
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: isActive ? 50 : 0,
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
          children: <Widget>[
            Expanded(
              child: _buildBottomAppBarItem(isActive: true),
            ),
            Expanded(
              child: _buildBottomAppBarItem(isActive: false),
            ),
            Expanded(
              child: _buildBottomAppBarItem(isActive: false),
            ),
          ],
        ),
      ),
    );
  }
}
