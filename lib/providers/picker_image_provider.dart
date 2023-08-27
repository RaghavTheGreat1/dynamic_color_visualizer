import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pickerImageProvider =
    StateNotifierProvider<PickerImageController, AsyncValue<Image?>>((ref) {
  return PickerImageController();
});

class PickerImageController extends StateNotifier<AsyncValue<Image?>> {
  PickerImageController() : super(const AsyncValue.data(null));

  Future<void> pickImage() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result == null || result.files.isEmpty) return state.value;

      final bytes = result.files.first.bytes;

      if (bytes == null) return state.value;
      return Image.memory(bytes);
    });
  }
}
