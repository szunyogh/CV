import 'dart:ui';
import 'package:common/model/response/profile.dart';
import 'package:common/ui/theme/theme.dart';
import 'package:mobile_cv/helper/custom_rout.dart';
import 'package:mobile_cv/ui/page/experience_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:common/logic/profile_logic.dart';
import 'package:common/model/response/experience.dart';
import 'package:common/model/response/my_abilities.dart';
import 'package:common/model/response/school.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:common/ui/widget/circle_button.dart';

class HomPage extends ConsumerStatefulWidget {
  const HomPage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomPage> createState() => _HomPageState();
}

class _HomPageState extends ConsumerState<HomPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(profileLogic.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileLogic).profile;

    final days = ref.watch(profileLogic).yearsOfExperience;
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(me: profile),
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(profile.aboutMe),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: builtWrap((days / 365).toStringAsFixed(2), (days * 2).toString()),
                    ),
                    const SizedBox(height: 20),
                    const Text("Iskoláim"),
                    const SizedBox(height: 10),
                    const SchoolCard(),
                    const SizedBox(height: 20),
                    const Text("Tapasztalataim"),
                    const SizedBox(height: 10),
                    const ExperienceCard(),
                    const SizedBox(height: 20),
                    const Text("Képességeim"),
                    const SizedBox(height: 10),
                    const MyAbilitiesCard(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget builtWrap(String text1, String text2) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.spaceBetween,
      runSpacing: 10,
      spacing: 10,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [Text("$text1 év"), const Text("Tapasztalat")],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [Text("$text2 db"), const Text("Kávé fogyasztás")],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: const [Text("0 óra"), Text("Alvás")],
            ),
          ),
        ),
      ],
    );
  }
}

class HomeHeader extends StatelessWidget {
  final Profile me;
  const HomeHeader({
    Key? key,
    required this.me,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = DateFormat("yyyy.MM.dd");
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: NetworkImage(me.profile),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
            color: Colors.white.withOpacity(0.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    me.profile,
                    width: 150.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) {
                      return Container(
                        width: 150.0,
                        height: 200.0,
                        color: Colors.grey,
                      );
                    },
                    loadingBuilder: (c, child, loading) {
                      if (loading == null) return child;
                      return Container(
                        width: 150.0,
                        height: 200.0,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          me.name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Text(f.format(me.birthday ?? DateTime(0))),
                      const Spacer(),
                      Row(
                        children: [
                          CircleButton(
                            onTap: () {
                              _launchEmail(me.email);
                            },
                            icon: Icons.mail,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          CircleButton(
                            onTap: () {
                              _makePhoneCall(me.phone);
                            },
                            icon: Icons.phone,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          CircleButton(
                            onTap: () {
                              _launchFaceBook(me.facebook);
                            },
                            icon: Icons.facebook,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future<void> _launchFaceBook(String url) async {
    await launch(url, forceSafariVC: false, universalLinksOnly: true).catchError((onError) {});
  }

  Future<void> _launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Flutter work&body=Hello world!',
    );

    if (await canLaunch(params.toString())) {
      await launch(params.toString());
    } else {
      throw 'Could not launch';
    }
  }
}

class ExperienceCard extends ConsumerWidget {
  const ExperienceCard({
    Key? key,
  }) : super(key: key);

  List<Widget> experienceElemnt(List<Experience> experience, BuildContext context) {
    var dateFormat = DateFormat("yyyy.MM.dd");
    List<Widget> widgets = [];
    for (int i = 0; i < experience.length; i++) {
      String completion = "Jelenleg is";
      try {
        completion = dateFormat.format(experience[i].completion!);
      } catch (e) {
        null;
      }
      widgets.add(InkWell(
        onTap: () {
          Navigator.of(context).push(
            MyCustomRoute(
              builder: (context) => ExperienceDetails(experience: experience[i]),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: double.maxFinite,
          decoration: i == experience.length - 1
              ? null
              : const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(experience[i].name),
              Text(
                "${dateFormat.format(experience[i].beginning!)} - $completion",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                experience[i].description,
                maxLines: 2,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiences = ref.watch(profileLogic).experiences;
    if (experiences.isEmpty) {
      return const Card(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text('Empty'),
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          children: [...experienceElemnt(experiences, context)],
        ),
      ),
    );
  }
}

class MyAbilitiesCard extends ConsumerWidget {
  const MyAbilitiesCard({
    Key? key,
  }) : super(key: key);

  List<Widget> myAbilitiesElemnt(BuildContext context, List<MyAbilities> myAbilities) {
    List<Widget> widgets = [];
    for (int i = 0; i < myAbilities.length; i++) {
      widgets.add(Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        width: double.maxFinite,
        decoration: i == myAbilities.length - 1
            ? null
            : const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
        child: Row(
          children: [
            SizedBox(width: 120, child: Text(myAbilities[i].name)),
            Expanded(
              child: LinearPercentIndicator(
                lineHeight: 15.0,
                percent: (myAbilities[i].strength ?? 0) / 5,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: blueColor,
                backgroundColor: blueColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myAbilities = ref.watch(profileLogic).myAbilities;
    if (myAbilities.isEmpty) {
      return const Card(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text('Empty'),
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          children: [...myAbilitiesElemnt(context, myAbilities)],
        ),
      ),
    );
  }
}

class SchoolCard extends ConsumerWidget {
  const SchoolCard({
    Key? key,
  }) : super(key: key);

  List<Widget> schoolElemnt(BuildContext context, List<School> school) {
    var dateFormat = DateFormat("yyyy.MM.dd");
    List<Widget> widgets = [];
    for (int i = 0; i < school.length; i++) {
      String completion = "Jelenleg is";
      try {
        completion = dateFormat.format(school[i].completion!);
      } catch (e) {}
      widgets.add(Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        width: double.maxFinite,
        decoration: i == school.length - 1
            ? null
            : const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${school[i].schoolName} - ${school[i].department}"),
            Text(
              "${dateFormat.format(school[i].beginning!)} - $completion",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              school[i].qualification,
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schools = ref.watch(profileLogic).schools;
    if (schools.isEmpty) {
      return const Card(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text('Empty'),
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          children: [...schoolElemnt(context, schools)],
        ),
      ),
    );
  }
}
