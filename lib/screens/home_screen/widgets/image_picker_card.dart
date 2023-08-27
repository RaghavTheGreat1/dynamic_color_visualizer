import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../providers/picker_image_provider.dart';

class ImagePickerCard extends ConsumerWidget {
  const ImagePickerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Image",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8,
              bottom: 8,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                await ref.read(pickerImageProvider.notifier).pickImage();
              },
              child: Container(
                height: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    final loader = SpinKitPulse(
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 24,
                    );
                    final imageFuture = ref.watch(pickerImageProvider);
                    if (imageFuture.value != null) {
                      return Stack(
                        children: [
                          imageFuture.value != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: imageFuture.value!.image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                          if (imageFuture.isLoading)
                            Align(
                              alignment: Alignment.center,
                              child: loader,
                            ),
                        ],
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: imageFuture.isLoading
                            ? loader
                            : Icon(
                                Icons.add_a_photo_outlined,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
