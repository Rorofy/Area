import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:mobile/routes/webviews/services_auth.dart';
import 'package:mobile/routes/dashboard_page.dart';

class Url {
  final String url;

  const Url({required this.url});

  factory Url.fromHtml(String uri) {
    return Url(url: uri);
  }

  String get urlGetter {
    return url;
  }
}

Future<Url> fetchUrl(String service) async {
  final response =
      await http.get(Uri.parse(globals.localIp + '/oauth/' + service + '/url'));

  if (response.statusCode == 200) {
    return Url.fromHtml(response.body);
  } else {
    throw Exception('Failed to get Url');
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Url> googleUrlFetched;
  late Future<Url> githubUrlFetched;
  late Future<Url> redditUrlFetched;
  late Future<Url> twitchUrlFetched;
  late Future<Url> discordUrlFetched;
  late Future<Url> messengerUrlFetched;

  @override
  void initState() {
    super.initState();
    googleUrlFetched = fetchUrl('google');
    githubUrlFetched = fetchUrl('github');
    redditUrlFetched = fetchUrl('reddit');
    twitchUrlFetched = fetchUrl('twitch');
    discordUrlFetched = fetchUrl('discord');
    messengerUrlFetched = fetchUrl('messenger');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Profile"),
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()));
              })),
      // List of buttons to connect to services
      body: ListView(
        children: <Widget>[
          FutureBuilder<Url>(
            future: googleUrlFetched,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ServiceAuth(url: snapshot.data!.url)));
                      },
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child:
                            Image.asset("assets/google.png", fit: BoxFit.cover),
                      ),
                      title: const Text('Google'),
                      subtitle: const Text('Connect to Google Services'),
                      trailing: (globals.googleConnected == true)
                          ? const FaIcon(FontAwesomeIcons.check,
                              color: Colors.green)
                          : const FaIcon(FontAwesomeIcons.times,
                              color: Colors.red),
                    ),
                  ),
                ));
              } else {
                ('${snapshot.error}');
                return const SizedBox();
              }
            },
          ),
          FutureBuilder<Url>(
            future: githubUrlFetched,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ServiceAuth(url: snapshot.data!.url)));
                      },
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child:
                            Image.asset("assets/github.png", fit: BoxFit.cover),
                      ),
                      title: const Text('Github'),
                      subtitle: const Text('Connect to Github Services'),
                      trailing: (globals.githubConnected == true)
                          ? const FaIcon(FontAwesomeIcons.check,
                              color: Colors.green)
                          : const FaIcon(FontAwesomeIcons.times,
                              color: Colors.red),
                    ),
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
          FutureBuilder<Url>(
            future: redditUrlFetched,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ServiceAuth(url: snapshot.data!.url)));
                      },
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child:
                            Image.asset("assets/reddit.png", fit: BoxFit.cover),
                      ),
                      title: const Text('Reddit'),
                      subtitle: const Text('Connect to Reddit Services'),
                      trailing: (globals.redditConnected == true)
                          ? const FaIcon(FontAwesomeIcons.check,
                              color: Colors.green)
                          : const FaIcon(FontAwesomeIcons.times,
                              color: Colors.red),
                    ),
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
          FutureBuilder<Url>(
            future: twitchUrlFetched,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ServiceAuth(url: snapshot.data!.url)));
                      },
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child:
                            Image.asset("assets/twitch.png", fit: BoxFit.cover),
                      ),
                      title: const Text('Twitch'),
                      subtitle: const Text('Connect to Twitch Services'),
                      trailing: (globals.twitchConnected == true)
                          ? const FaIcon(FontAwesomeIcons.check,
                              color: Colors.green)
                          : const FaIcon(FontAwesomeIcons.times,
                              color: Colors.red),
                    ),
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
          FutureBuilder<Url>(
            future: discordUrlFetched,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ServiceAuth(url: snapshot.data!.url)));
                      },
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child: Image.asset("assets/discord.png",
                            fit: BoxFit.cover),
                      ),
                      title: const Text('Discord'),
                      subtitle: const Text('Connect to Discord Services'),
                      trailing: (globals.discordConnected == true)
                          ? const FaIcon(FontAwesomeIcons.check,
                              color: Colors.green)
                          : const FaIcon(FontAwesomeIcons.times,
                              color: Colors.red),
                    ),
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
