import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/routes/widget_config_page2.dart';

class WidgetLogo extends StatefulWidget {
  final String logo;
  const WidgetLogo({Key? key, required this.logo}) : super(key: key);

  @override
  _WidgetLogoState createState() => _WidgetLogoState();
}

class _WidgetLogoState extends State<WidgetLogo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/" + widget.logo + ".png",
      fit: BoxFit.cover,
      height: 80,
      width: 80,
    );
  }
}

class ActionDetails extends StatelessWidget {
  final String action;
  const ActionDetails({required this.action, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (action) {
      case 'gmail':
        return const Text('Gmail receive mail', textAlign: TextAlign.center);
      case 'calendar':
        return const Text('Calendar event incoming',
            textAlign: TextAlign.center);
      case 'reddit':
        return const Text('Reddit receive message',
            textAlign: TextAlign.center);
      case 'github':
        return const Text('Github new push on repo', textAlign: TextAlign.center);
      case 'twitch':
        return const Text('Twitch new followers', textAlign: TextAlign.center);
      case 'drive':
        return const Text('Drive receive answer', textAlign: TextAlign.center);
      case 'alarm':
        return const Text('Set a daily alarm', textAlign: TextAlign.center);
      case 'water':
        return const Text('Reminder to drink water every hours',
            textAlign: TextAlign.center);
      default:
        return const Text('Unknown action', textAlign: TextAlign.center);
    }
  }
}

class ReactionDetails extends StatelessWidget {
  final String reaction;
  const ReactionDetails({required this.reaction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (reaction) {
      case 'gmail':
        return const Text('Gmail sends you a mail',
            textAlign: TextAlign.center);
      case 'reddit':
        return const Text('Reddit sends you a message',
            textAlign: TextAlign.center);
      case 'discord':
        return const Text('Discord sends you a message',
            textAlign: TextAlign.center);
      case 'sms':
        return const Text('Phone sends you a SMS', textAlign: TextAlign.center);
      default:
        return const Text('Unknown reaction', textAlign: TextAlign.center);
    }
  }
}

class MyWidget extends StatefulWidget {
  final String action;
  final String reaction;
  final int id;
  const MyWidget(this.action, this.reaction, this.id, {Key? key})
      : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WidgetConfigPage2(
              action: widget.action,
              reaction: widget.reaction,
              id: widget.id,
            ),
          ),
        );
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SizedBox(
            height: 180,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        child: WidgetLogo(logo: widget.action),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                      ),
                      const FaIcon(FontAwesomeIcons.arrowRight),
                      Padding(
                        child: WidgetLogo(logo: widget.reaction),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        child: SizedBox(
                            child: ActionDetails(action: widget.action),
                            width: 110,
                            height: 50),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        child: SizedBox(
                            child: ReactionDetails(reaction: widget.reaction),
                            width: 120,
                            height: 50),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetArgs {
  final String action;
  final String reaction;
  final int id;

  WidgetArgs({required this.action, required this.reaction, required this.id});
}
