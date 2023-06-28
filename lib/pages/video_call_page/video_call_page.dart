import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/main.dart';
import 'package:sirenhead_test/pages/home_page/home_page.dart';
import 'package:sirenhead_test/pages/widgets/end_call_button.dart';
import 'package:sirenhead_test/pages/widgets/rate_us.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/services/cas.dart';
import 'package:sirenhead_test/services/toggle_review.dart';
import 'package:video_player/video_player.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({Key? key, this.cameras}) : super(key: key);
  final List<CameraDescription>? cameras;
  static const routeName = 'video-call-page';

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final VideoPlayerController _videoController = VideoPlayerController.asset(
    'assets/videos/video.mp4',
  );
  CameraController? _cameraController;

  final double _containerWidth = 120;
  double _containerHeight = 160;
  bool _ratingCalled = false;

  Future<void> initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      widget.cameras![1],
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await _cameraController?.initialize().then((_) async {
        await _initVideo();
        setState(() {
          _containerHeight =
              _containerWidth * _cameraController!.value.aspectRatio;
        });
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  Future<void> _initVideo() async {
    await _videoController.initialize().then((value) {
      setState(() {});
      _videoController.play();
    });
    _videoController.addListener(_checkIfFinish);
  }

  void _checkIfFinish() {
    if (_videoController.value.duration == _videoController.value.position &&
        !_videoController.value.isPlaying &&
        !_ratingCalled) {
      _ratingCalled = true;
      _callRating();
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    }
  }

  Future<void> _callRating() async {
    final ifReviewed = await LocalStorageService.ifReviewed;
    if (!ifReviewed) {
      await Future.delayed(const Duration(milliseconds: 700));
      showDialog(
          context: GlobalKeys.navigatorKey.currentState!.context,
          builder: (_) {
            return const RatingDialog();
          });
    }
  }

  @override
  void initState() {
    CASAd.view?.hideBanner();
    super.initState();

    initCamera(widget.cameras![1]);
  }

  @override
  void dispose() {
    _videoController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.incomingCallBackgroundBlack,
      child: _cameraController?.value.isInitialized ?? false
          ? Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(
            _videoController,
          ),
          Positioned(
            top: 20,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                  height: _containerHeight,
                  width: _containerWidth,
                  child: CameraPreview(_cameraController!)),
            ),
          ),
          const Positioned(
            bottom: 40,
            child: EndCallButton(),
          )
        ],
      )
          : const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      // : const Center(child: CircularProgressIndicator())
    );
  }
}
