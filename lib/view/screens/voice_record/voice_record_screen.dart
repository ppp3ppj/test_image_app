import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_image_app/view_model/voice_record/voice_record_view_model.dart';

class VoiceRecordScreen extends StatelessWidget {
  const VoiceRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<VoiceRecordViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Voice Record Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(vm.isRecording ? 'Recording...' : 'Not recording'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: vm.isRecording ? vm.stopRecording : vm.startRecording,
              child: Text(vm.isRecording ? 'Stop' : 'Start'),
            ),
            ElevatedButton(
              onPressed: vm.playRecording,
              child: const Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
