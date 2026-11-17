import 'package:flutter/material.dart';

class FloatingSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;
  final bool isEditable;
  final bool autofocus;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsetsGeometry? margin;

  const FloatingSearchBar({
    super.key,
    this.onTap,
    this.hintText = 'Para onde vamos?',
    this.isEditable = false,
    this.autofocus = false,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: isEditable
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: Colors.grey.shade600,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  autofocus: autofocus,
                  onTapOutside: (_) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        )
            : InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade600,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  hintText,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}