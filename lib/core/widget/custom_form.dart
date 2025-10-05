import 'package:flutter/material.dart';
import 'package:mobile_intern_pdam/core/widget/app_state_page.dart';

enum InputType { text, dropdown }

class CustomForm<T> extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final bool enabled;
  final bool readOnly;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputType inputType;
  final List<DropdownMenuItem<T>>? dropdownItems;
  final T? dropdownValue;
  final void Function(T?)? onDropdownChanged;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final List<Widget>? chips;

  const CustomForm({
    super.key,
    this.controller,
    required this.hintText,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.minLines,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.inputType = InputType.text,
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.chips,
  });

  @override
  State<CustomForm<T>> createState() => _CustomFormState<T>();
}

class _CustomFormState<T> extends AppStatePage<CustomForm<T>> {
  bool _isPasswordVisible = true;

  @override
  Widget buildPage(BuildContext context) {
    final inputStyle = textTheme.titleLarge;
    const defaultInputPadding = EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    );
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: textTheme.headlineMedium?.copyWith(
              color: color.primary[500],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.chips != null && widget.chips!.isNotEmpty)
                    ? Wrap(
                        spacing: 4, // Jarak antar chip horizontal
                        children: widget.chips!,
                      )
                    : const SizedBox.shrink(),
                widget.inputType == InputType.text
                    ? TextFormField(
                        style: inputStyle,
                        readOnly: widget.readOnly,
                        minLines: widget.minLines,
                        maxLines: widget.maxLines,
                        keyboardType: widget.keyboardType,
                        controller: widget.controller,
                        validator: widget.validator,
                        onTap: widget.onTap,
                        obscureText: widget.obscureText && _isPasswordVisible,
                        focusNode: widget.focusNode,
                        enabled: widget.enabled,
                        onChanged: (value) {
                          widget.onChanged?.call(value);
                        },
                        onFieldSubmitted: (value) {
                          // Gunakan onFieldSubmitted untuk TextFormField
                          widget.onSubmitted?.call(value);
                          widget.focusNode?.unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          isDense: true,
                          contentPadding: defaultInputPadding,
                          prefixIcon: widget.prefixIcon,
                          suffixIcon:
                              widget.suffixIcon ??
                              (widget.obscureText
                                  ? IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    )
                                  : null),
                        ),
                      )
                    : DropdownButtonFormField<T>(
                        style: inputStyle,
                        initialValue: widget.dropdownValue,
                        items:
                            widget.dropdownItems
                                ?.map(
                                  (item) => DropdownMenuItem<T>(
                                    value: item.value,
                                    child: DefaultTextStyle.merge(
                                      style: inputStyle,
                                      child: item.child,
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                        onChanged: widget.enabled
                            ? widget.onDropdownChanged
                            : null,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          isDense: true,
                          contentPadding: defaultInputPadding,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
