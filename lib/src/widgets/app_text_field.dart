import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onTapOutside,
    this.onFieldSubmitted,
    this.labelText,
    this.hintText,
    this.border,
    this.validator,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.suffix,
    this.prefix,
    this.label,
    this.style,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.contextMenuBuilder,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? suffix;
  final Widget? prefix;
  final String? labelText;
  final Widget? label;
  final String? hintText;
  final InputBorder? border;
  final TextStyle? style;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      contextMenuBuilder: contextMenuBuilder,
      inputFormatters: inputFormatters,
      style: style,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: label,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.lPrimary,
              fontWeight: FontWeight.w700,
            ),
        hintText: hintText,
        suffix: suffix,
        prefix: prefix,
        border: border ?? const UnderlineInputBorder(),
        errorMaxLines: 2,
      ),
      validator: validator,
    );
  }
}
