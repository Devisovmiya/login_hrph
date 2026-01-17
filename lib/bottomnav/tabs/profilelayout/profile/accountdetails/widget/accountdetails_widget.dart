import 'package:flutter/material.dart';

//Top_profileSection
class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Stack(
            alignment: AlignmentGeometry.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 174, 188, 196),
                radius: 40,
                child: Icon(Icons.person),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.inner,
                        blurRadius: 5,

                        color: const Color.fromARGB(179, 14, 191, 214),
                      ),
                    ],
                  ),
                  child: Icon(Icons.mode_edit_outline_outlined, size: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//info_feild
class InfoFeild extends StatelessWidget {
  const InfoFeild({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color.fromARGB(255, 208, 217, 221),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: const Color.fromARGB(238, 180, 215, 255),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 23,
            fontWeight: FontWeight.w200,
            color: const Color.fromARGB(249, 37, 37, 37),
          ),
        ),
      ),
    );
  }
}

//label
class Label extends StatelessWidget {
  const Label({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromARGB(255, 179, 177, 177),
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: const Color.fromARGB(255, 48, 57, 61),
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
