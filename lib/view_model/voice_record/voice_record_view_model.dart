import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class VoiceRecordViewModel extends ChangeNotifier {
  final _recorder = AudioRecorder();
  final _player = AudioPlayer();

  bool _isRecording = false;
  bool get isRecording => _isRecording;
  String? _recordedFilePath;

  Future<void> startRecording() async {
    if (!await _recorder.hasPermission()) return;

    _isRecording = true;
    notifyListeners();

    final dir = await getTemporaryDirectory();
    _recordedFilePath = '${dir.path}/recorded_audio.wav';

    const cfg = RecordConfig(
      encoder: AudioEncoder.wav,
      sampleRate: 16000,
      bitRate: 128000,
      numChannels: 1,
    );

    await _recorder.start(cfg, path: _recordedFilePath!);
  }

  Future<void> stopRecording() async {
    await _recorder.stop();
    _isRecording = false;
    notifyListeners();
  }

  Future<void> playRecording() async {
    if (_recordedFilePath == null || !File(_recordedFilePath!).existsSync())
      return;

    try {
      await _player.setFilePath(_recordedFilePath!);
      await _player.play();
    } catch (e) {
      print('Playback failed: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _recorder.dispose();
    super.dispose();
  }
}
