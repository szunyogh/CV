import 'package:common/model/response/experience.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExperienceDetails extends StatelessWidget {
  const ExperienceDetails({Key? key, required this.experience}) : super(key: key);

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat("yyyy.MM.dd");
    String completion = "Jelenleg is";
    try {
      completion = dateFormat.format(experience.completion!);
    } catch (e) {
      null;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tapasztalat'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(experience.name),
              Text(
                "${dateFormat.format(experience.beginning!)} - $completion",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 20),
              Text(experience.description),
              const SizedBox(height: 20),
              Wrap(
                children: experience.keywords
                    .map(
                      (e) => Chip(
                        label: Text(e),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
