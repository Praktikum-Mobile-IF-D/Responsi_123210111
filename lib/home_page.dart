import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_123210111/model/job_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<JobData>? _jobs;

  @override
  void initState() {
    super.initState();
    _jobs = _getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: FutureBuilder<JobData>(
        future: _jobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.jobs == null) {
            return const Center(child: Text(''));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.jobs!.length,
              itemBuilder: (context, index) {
                var job = snapshot.data!.jobs![index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        job.companyLogo != null ? Center(
                          child: Image.network(
                            job.companyLogo!,
                            height: 50,
                          ),
                        ) : Container(),
                        const SizedBox(height: 10),
                        ListTile(
                          title: Text(
                            job.jobTitle ?? '',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text('Company: ${job.companyName ?? ''}'),
                              Text('Type: ${job.jobType?.join(', ') ?? ''}'),
                              Text('Salary: ${job.annualSalaryMin ?? ''} - ${job.annualSalaryMax ?? ''}'),
                            ],
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<JobData> _getJobs() async {
    var url = Uri.parse('https://jobicy.com/api/v2/remote-jobs');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return JobData.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('gagal');
    }
  }
}
