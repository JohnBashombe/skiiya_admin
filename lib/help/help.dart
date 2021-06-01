import 'package:skiiya_admin/Responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: new EdgeInsets.only(left: 10.0),
        padding: EdgeInsets.only(
            left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0,
            top: 10.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
            right: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 0.0),
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Règles & Aide',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.grey, thickness: 0.5),
            SizedBox(height: 10.0),
            Text(
              'Comment jouer?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat, itaque quas? Recusandae enim quas maxime rerum voluptatem quaerat ab. Cupiditate aut repellat     perspiciatis atque quae, voluptates suscipit nesciunt consequuntur accusantium!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5.0),
            Divider(color: Colors.grey, thickness: 0.5),
            SizedBox(height: 5.0),
            // Text(
            //   'Comment participer au Jackpot?',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 5.0),
            Text(
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat, itaque quas? Recusandae enim quas maxime rerum voluptatem quaerat ab. Cupiditate aut repellat     perspiciatis atque quae, voluptates suscipit nesciunt consequuntur accusantium!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat, itaque quas? Recusandae enim quas maxime rerum voluptatem quaerat ab. Cupiditate aut repellat     perspiciatis atque quae, voluptates suscipit nesciunt consequuntur accusantium!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
