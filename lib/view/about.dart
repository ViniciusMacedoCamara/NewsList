import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://media-exp1.licdn.com/dms/image/C4E03AQFRoIfnjUV9wg/profile-displayphoto-shrink_800_800/0/1591581286452?e=1622678400&v=beta&t=ZbvxA66c3yFV_IFQqYj4LyB0aBkonX3aUCWL3jXWp-I',
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vinicius Macedo Camara',
                            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text(
                              '25 years old',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Text(
                            'Balneário Camboriú to the 🌎',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'About This Project:',
                  style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Without any doubt it was a challenging project, pulling me to go even deeper into some Flutter concepts."),
                SizedBox(height: 8),
                Text(
                    "While I was executing the tasks of this test, I was imagining it as a daily task, and because I am doing it in the middle of the weekend, because on weekdays I don't have much time to perform additional tasks, it made me realize how much I like to Flutter and developing for mobile devices, and that undoubtedly, making this a daily routine would be rewarding."),
                SizedBox(height: 8),
                Text("Thanks to everyone at Cheesecake Labs for approving me to take this technical test. I know I have a lot to learn and it would be an honor to learn from you guys."),
                SizedBox(height: 8),
                Text("PS: if you notice the functionality to mark as unread this is included in the longPress of the ListTile itself."),
                SizedBox(height: 16),
                Text(
                  'About Me:',
                  style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                    "Android developer, creating with Java and Realm for 2 years. Shortening the gap between Designers and Devs. Based in Balneário Camboriú, Brazil. Available to move worldwide 🌎 and work remotely."),
                SizedBox(height: 16),
                Text("My goal is make technology accessible to as many people as possible! 📲"),
                SizedBox(height: 16),
                Text(
                    "I have been a Developer for 5 years, working with web technologies such as: HTML, CSS and JavaScript, AngularJS and currently my focus is on mobile applications using Java and Flutter and I am also learning Kotlin. Always trying to align the code with UX standards. 👨‍💻"),
                SizedBox(height: 16),
                Text("I have a great interest in UX area and I want to use this combined with my knowledge as a Developer.🎨"),
                SizedBox(height: 16),
                Text("I've worked on web and mobile projects in multidisciplinary teams and I'm familiar with agile methodologies and most popular softwares."),
                SizedBox(height: 16),
                Text("All people matter 💪"),
                SizedBox(height: 16),
                Text("Feel free to contact me with you want to chat about design or if you're interested in my work."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
