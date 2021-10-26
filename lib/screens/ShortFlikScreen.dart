// import 'package:imgly_sdk/imgly_sdk.dart';
// import 'package:photo_editor_sdk/photo_editor_sdk.dart';
//
// /// Here, we assign custom stickers to the editor.
// ///
// /// We create a completely custom category
// /// containing custom stickers:
//
// /// A custom sticker displaying the Flutter logo:
// final flutterSticker = Sticker(
//     "example_sticker_logos_flutter", "Flutter", "assets/Flutter-logo.png");
//
// /// A custom sticker displaying the img.ly logo:
// final imglySticker = Sticker(
//     "example_sticker_logos_imgly", "img.ly", "assets/imgly-Logo.png",
//     tintMode: TintMode.solid);
//
// /// Assign the custom stickers to a new custom category:
// final logos = StickerCategory(
//     "example_sticker_category_logos", "Logos", "assets/Flutter-logo.png",
//     items: [flutterSticker, imglySticker]);
//
// /// Finally, add the custom category to your configuration:
// final configuration = Configuration(
//     sticker:
//     StickerOptions(personalStickers: true, categories: [logos]));
//
//
// final audios = AudioClip("", "")
// /// Open the editor with customizations applied:
// PESDK.openEditor(
// image: "assets/demo-image.jpg", configuration: configuration);
