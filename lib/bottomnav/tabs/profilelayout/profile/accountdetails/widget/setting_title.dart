import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTapping;
  final bool isLogOut;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTapping,
    this.isLogOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            border: BoxBorder.all(width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListTile(
              leading: Icon(icon, size: 15),
              title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.chevron_right_outlined),
              onTap: onTapping,
            ),
          ),
        ),
      ),
    );
  }
}

/* class AppThemeSetting extends ConsumerWidget {
  final IconData icon;
  final String title;
  final ValueChanged<bool> onTapping;


  const AppThemeSetting({
    super.key,
    required this.icon,
    required this.title,
    required this.onTapping,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            border: BoxBorder.all(width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SwitchListTile(
            
            title:Text(title),
            subtitle: Icon(Icons.color_lens_outlined),
            
              value: true,
                        onChanged: onTapping , 
          ),
        ),
      ),
      );
    
  }
}
 */