import 'package:decode/models/tutorial_model.dart';
import 'package:flutter/material.dart';

import 'models/widgets/tutorial_screen.dart';
import 'models/widgets/tutorials_list_item.dart';

class LearnCodingPage extends StatefulWidget {
  const LearnCodingPage({super.key});

  @override
  State<LearnCodingPage> createState() => _LearnCodingPageState();
}

class _LearnCodingPageState extends State<LearnCodingPage> {
  @override
  Widget build(BuildContext context) {
    List<Tutorial> tutorials = Tutorial.tutorials;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('<Decode/>'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline6,
                children: [
                  TextSpan(
                    text: " Available Tutorials",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  //const TextSpan(text: "Tutorials"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            for (final tutorial in tutorials)
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TutorialScreen(tutorial: tutorial)));
                },
                child: TutorialListItem(
                    imageUrl: tutorial.imagepath, name: tutorial.name),
              )
          ]),
        ),
      ),
    );
  }
}
/*Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              /* image: DecorationImage(
                image: AssetImage('images/bg_main.png'), fit: BoxFit.cover),*/
              ),
        )*/