
import 'package:url_launcher/url_launcher_string.dart';

const _shareUrl = "https://usapyon.fastriver.dev";

const _twitterShareLink = """https://twitter.com/share?url=$_shareUrl&text=""";

const _facebookShareLink = """http://www.facebook.com/share.php?u=$_shareUrl""";

const _lineShareLink = """https://line.naver.jp/R/msg/text/?$_shareUrl""";

void shareTwitter(String height, String award) async {
  final encoded = Uri.encodeFull("うさぴょん${height}m達成！$award");
  await launchUrlString(_twitterShareLink + encoded);
}

void shareFacebook() async {
  await launchUrlString(_facebookShareLink);
}

void shareLine(String height, String award) async {
  final encoded = Uri.encodeFull("うさぴょん${height}m達成！$award");
  await launchUrlString("$_lineShareLink $encoded");
}
