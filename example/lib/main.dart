import 'package:call_log_fetcher/call_log_fetcher.dart';
import 'package:call_log_fetcher/model/call_log_entry.dart';
import 'package:call_log_fetcher/model/call_log_query.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Log Fetcher Example',
      theme: ThemeData(useMaterial3: true),
      home: const CallLogExamplePage(),
    );
  }
}

class CallLogExamplePage extends StatefulWidget {
  const CallLogExamplePage({super.key});

  @override
  State<CallLogExamplePage> createState() => _CallLogExamplePageState();
}

class _CallLogExamplePageState extends State<CallLogExamplePage> {
  List<CallLogEntry> _logs = [];
  String? _error;
  bool _isLoading = false;

  Future<void> _fetchCallLogs() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _logs = [];
    });

    try {
      final logs = await CallLogFetcher.getCallLog(
        CallLogQuery(
          from: DateTime.now().subtract(const Duration(days: 1)),
          to: DateTime.now(),
        ),
      );

      setState(() {
        _logs = logs;
      });
    } on CallLogException catch (e) {
      setState(() {
        _error = '${e.code}: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _callTypeLabel(CallType type) {
    switch (type) {
      case CallType.incoming:
        return 'Incoming';

      case CallType.outgoing:
        return 'Outgoing';

      case CallType.missed:
        return 'Missed';

      case CallType.unknown:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Log Fetcher Example')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: _isLoading ? null : _fetchCallLogs,
              child: const Text('Fetch Last 24 Hours'),
            ),
          ),

          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_error != null)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(_error!, textAlign: TextAlign.center),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];

                  return ListTile(
                    title: Text(log.number),
                    subtitle: Text(
                      '${_callTypeLabel(log.callType)} • ${log.duration.inSeconds}s',
                    ),
                    trailing: Text(
                      '${log.date.day}/${log.date.month} '
                      '${log.date.hour}:${log.date.minute.toString().padLeft(2, '0')}',
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
