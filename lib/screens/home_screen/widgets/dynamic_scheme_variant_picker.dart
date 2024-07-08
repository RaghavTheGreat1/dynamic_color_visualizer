import 'package:flutter/material.dart';

class DynamicSchemeVariantPicker extends StatefulWidget {
  final DynamicSchemeVariant initialVariant;
  final ValueChanged<DynamicSchemeVariant> onVariantChanged;

  const DynamicSchemeVariantPicker({
    required this.initialVariant,
    required this.onVariantChanged,
    super.key,
  });

  @override
  DynamicSchemeVariantPickerState createState() =>
      DynamicSchemeVariantPickerState();
}

class DynamicSchemeVariantPickerState
    extends State<DynamicSchemeVariantPicker> {
  late DynamicSchemeVariant _selectedVariant;

  @override
  void initState() {
    super.initState();
    _selectedVariant = widget.initialVariant;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.primaryContainer,
      ),
      child: DropdownMenu<DynamicSchemeVariant>(
        initialSelection: _selectedVariant,
        enableSearch: false,
        menuStyle: const MenuStyle(
          minimumSize: WidgetStatePropertyAll(Size.fromWidth(80)),

        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        onSelected: (DynamicSchemeVariant? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedVariant = newValue;
            });
            widget.onVariantChanged(newValue);
          }
        },
        dropdownMenuEntries:
            DynamicSchemeVariant.values.map((DynamicSchemeVariant variant) {
          return DropdownMenuEntry<DynamicSchemeVariant>(
            value: variant,
            label: _getVariantName(variant),
          );
        }).toList(),
      ),
    );
  }

  String _getVariantName(DynamicSchemeVariant variant) {
    switch (variant) {
      case DynamicSchemeVariant.tonalSpot:
        return 'Tonal Spot';
      case DynamicSchemeVariant.fidelity:
        return 'Fidelity';
      case DynamicSchemeVariant.monochrome:
        return 'Monochrome';
      case DynamicSchemeVariant.neutral:
        return 'Neutral';
      case DynamicSchemeVariant.vibrant:
        return 'Vibrant';
      case DynamicSchemeVariant.expressive:
        return 'Expressive';
      case DynamicSchemeVariant.content:
        return 'Content';
      case DynamicSchemeVariant.rainbow:
        return 'Rainbow';
      case DynamicSchemeVariant.fruitSalad:
        return 'Fruit Salad';
    }
  }
}
