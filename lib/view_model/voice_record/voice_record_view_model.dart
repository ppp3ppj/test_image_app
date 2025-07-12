import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class VoiceRecordViewModel extends ChangeNotifier {
  final _recorder = AudioRecorder();
  final _player = AudioPlayer();
  final List<int> _audioBuffer = [];
  StreamSubscription<Uint8List>? _streamSubscription;

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  Future<void> startRecording() async {
    if (!await _recorder.hasPermission()) return;

    _audioBuffer.clear();
    _isRecording = true;
    notifyListeners();

    final stream = await _recorder.startStream(
      const RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 16000),
    );

    _streamSubscription = stream.listen(
      (chunk) {
        _audioBuffer.addAll(chunk);
      },
      onError: (err) {
        print("Error: $err");
        _isRecording = false;
        notifyListeners();
      },
    );
  }

  Future<void> stopRecording() async {
    await _streamSubscription?.cancel();
    await _recorder.stop();
    _isRecording = false;
    notifyListeners();
  }

  Future<String> saveWavToTempFile(Uint8List wavBytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/recorded_audio.wav');
    await file.writeAsBytes(wavBytes);
    return file.path;
  }

  Future<void> playRecording() async {
    if (_audioBuffer.isEmpty) return;

    final wavBytes = _convertToWav2(Uint8List.fromList(_audioBuffer));
    final filePath = await saveWavToTempFile(wavBytes);
    try {
      await _player.setFilePath(filePath);
      await _player.play();
    } catch (e) {
      print('Playback failed: $e');
    }
  }

  // --- WAV Header Generator ---
  Uint8List _convertToWav(Uint8List pcmData) {
    const sampleRate = 16000;
    const bitsPerSample = 16;
    const channels = 1;

    final byteRate = sampleRate * channels * (bitsPerSample ~/ 8);
    final blockAlign = channels * (bitsPerSample ~/ 8);
    final dataLength = pcmData.length;
    final fileSize = 44 + dataLength - 8;

    final header = BytesBuilder();
    header.add(ascii.encode('RIFF'));
    header.add(_int32LE(fileSize));
    header.add(ascii.encode('WAVE'));
    header.add(ascii.encode('fmt '));
    header.add(_int32LE(16)); // PCM
    header.add(_int16LE(1)); // PCM format
    header.add(_int16LE(channels));
    header.add(_int32LE(sampleRate));
    header.add(_int32LE(byteRate));
    header.add(_int16LE(blockAlign));
    header.add(_int16LE(bitsPerSample));
    header.add(ascii.encode('data'));
    header.add(_int32LE(dataLength));
    header.add(pcmData);

    return header.toBytes();
  }
Uint8List _convertToWav2(Uint8List pcmData) {
  const sampleRate = 16000;
  const bitsPerSample = 16;
  const channels = 1;

  final byteRate = sampleRate * channels * (bitsPerSample ~/ 8);
  final blockAlign = channels * (bitsPerSample ~/ 8);
  final dataLength = pcmData.length;
  final fileSize = 36 + dataLength; // FIXED

  final header = BytesBuilder();
  header.add(ascii.encode('RIFF'));
  header.add(_int32LE(fileSize));
  header.add(ascii.encode('WAVE'));
  header.add(ascii.encode('fmt '));
  header.add(_int32LE(16)); // PCM
  header.add(_int16LE(1)); // PCM format
  header.add(_int16LE(channels));
  header.add(_int32LE(sampleRate));
  header.add(_int32LE(byteRate));
  header.add(_int16LE(blockAlign));
  header.add(_int16LE(bitsPerSample));
  header.add(ascii.encode('data'));
  header.add(_int32LE(dataLength));
  header.add(pcmData);

  return header.toBytes();
}

  List<int> _int16LE(int value) => [value & 0xff, (value >> 8) & 0xff];
  List<int> _int32LE(int value) => [
    value & 0xff,
    (value >> 8) & 0xff,
    (value >> 16) & 0xff,
    (value >> 24) & 0xff,
  ];

  @override
  void dispose() {
    _player.dispose();
    _recorder.dispose();
    super.dispose();
  }
}