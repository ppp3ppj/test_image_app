import 'dart:typed_data';

class StreamAudioData {
  final Uint8List data;      // The actual audio bytes
  final int sampleRate;      // Samples per second (e.g., 44100 Hz)
  final int numChannels;     // Mono = 1, Stereo = 2
  final int bitDepth;        // 16-bit, 32-bit, etc.

  // Constructor (internal to package)
  StreamAudioData(this.data, this.sampleRate, this.numChannels, this.bitDepth);
}