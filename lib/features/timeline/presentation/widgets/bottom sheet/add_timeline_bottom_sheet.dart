import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/timeline/cubits/create_memories_cubit.dart';
import 'package:memo/features/timeline/data/request/memory_request.dart';

void showAddMemorySheet(BuildContext parentContext, int connectionId) {
  final controller = TextEditingController();
  const types = <String>['personal', 'work', 'behavioral', 'event', 'reminder'];
  String selectedType = types.first;

  showModalBottomSheet(
    context: parentContext,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Add a memory',
              style: TextStyle(
                fontFamily: 'Libre',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.softPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'For this connection',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 13,
                color: AppColors.softTextGrey,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedType,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Memory type',
                labelStyle: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 13,
                  color: AppColors.textGrey,
                ),
                filled: true,
                fillColor: AppColors.scaffoldBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: types
                  .map(
                    (type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type[0].toUpperCase() + type.substring(1),
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  selectedType = value;
                });
              },
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              maxLines: 4,
              style: const TextStyle(fontFamily: 'Rubik', fontSize: 14),
              decoration: InputDecoration(
                hintText: 'What do you want to remember?',
                hintStyle: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  color: AppColors.textGrey,
                ),
                filled: true,
                fillColor: AppColors.scaffoldBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.text.trim().isEmpty) {
                    AppUtils.showErrorSnackbar(
                      message: 'Please enter some content',
                    );
                    return;
                  }
                  parentContext.read<CreateMemoriesCubit>().createMemory(
                    MemoryRequest(
                      connectionId: connectionId,
                      content: controller.text.trim(),
                      type: selectedType,
                    ),
                  );
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save memory',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
