import 'package:memo/core/utils/app_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class CallRecordingService {
  final AudioRecorder _record = AudioRecorder();

  /// Call this when entering call screen
  Future<void> startRecording(String callId) async {
    final hasPermission = await _record.hasPermission();
    if (!hasPermission) {
      print("No recording permission");
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${callId}_audio.mp3';

    try {
      await _record.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: path,
      );
      print("Recording started at path: $path");
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  /// Call this when leaving call screen
  Future<String?> stopRecording() async {
    try {
      if (await _record.isRecording()) {
        final path = await _record.stop();
        print("Recording stopped. File saved at: $path");
        if (path != null) {
          AppUtils.downloadPdf(path);
          print("Download to download folder");
        }
        return path;
      } else {
        print("No active recording to stop.");
        return null;
      }
    } catch (e) {
      print("Error stopping recording: $e");
      return null;
    }
  }

  Future<void> dispose() async {
    await _record.dispose();
  }
}
