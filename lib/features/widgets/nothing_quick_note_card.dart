import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/quick_note_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Nothing Quick Note Widget Card
// ─────────────────────────────────────────────────────────────────────────────

/// Displays a user-editable note on a Nothing OS style card.
///
/// • Tapping the card opens a bottom sheet editor.
/// • The note is persisted via [QuickNoteNotifier] → SharedPreferences.
/// • Saving also pushes the note to the Android home screen widget subtitle.
class NothingQuickNoteCard extends ConsumerWidget {
  const NothingQuickNoteCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(quickNoteProvider);
    final isEmpty = note.trim().isEmpty;

    return GestureDetector(
      onTap: () => _openEditor(context, ref, note),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 120),
        padding: const EdgeInsets.all(AppConstants.spaceMD),
        decoration: BoxDecoration(
          color: AppConstants.surfaceDark,
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          border: Border.all(
            color: AppConstants.borderGrey,
            width: AppConstants.borderNormal,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row ─────────────────────────────────────────────────
            Row(
              children: [
                _TagPill(label: 'QUICK NOTE'),
                const Spacer(),
                Icon(
                  isEmpty ? Icons.add : Icons.edit_outlined,
                  size: 14,
                  color: AppConstants.whiteSubtle,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spaceMD),

            // ── Note content ──────────────────────────────────────────────
            if (isEmpty)
              Text(
                'TAP TO ADD A NOTE\u2026',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppConstants.whiteSubtle,
                  fontStyle: FontStyle.italic,
                ),
              )
            else ...[
              Text(
                note,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.spaceMD),
              Row(
                children: [
                  Icon(Icons.circle, size: 6, color: AppConstants.accentRed),
                  const SizedBox(width: AppConstants.spaceSM),
                  Text(
                    'SYNCED WITH WIDGET',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppConstants.whiteSubtle,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Bottom sheet editor ───────────────────────────────────────────────────

  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref,
    String currentNote,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppConstants.surfaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusLG),
        ),
        side: BorderSide(color: AppConstants.borderGrey),
      ),
      builder: (ctx) => _NoteEditorSheet(
        initialNote: currentNote,
        onSave: (text) async {
          await ref.read(quickNoteProvider.notifier).saveNote(text);
          if (ctx.mounted) Navigator.of(ctx).pop();
        },
        onClear: () async {
          await ref.read(quickNoteProvider.notifier).clearNote();
          if (ctx.mounted) Navigator.of(ctx).pop();
        },
      ),
    );
  }
}

// ── Editor sheet ──────────────────────────────────────────────────────────────

class _NoteEditorSheet extends StatefulWidget {
  const _NoteEditorSheet({
    required this.initialNote,
    required this.onSave,
    required this.onClear,
  });

  final String initialNote;
  final Future<void> Function(String) onSave;
  final Future<void> Function() onClear;

  @override
  State<_NoteEditorSheet> createState() => _NoteEditorSheetState();
}

class _NoteEditorSheetState extends State<_NoteEditorSheet> {
  late final TextEditingController _ctrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppConstants.spaceMD,
        AppConstants.spaceMD,
        AppConstants.spaceMD,
        AppConstants.spaceMD + viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Handle ────────────────────────────────────────────────────────
          Center(
            child: Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: AppConstants.borderGreyLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spaceMD),
          Text('EDIT NOTE', style: textTheme.titleSmall),
          const SizedBox(height: AppConstants.spaceMD),

          // ── Text field ────────────────────────────────────────────────────
          TextField(
            controller: _ctrl,
            style: textTheme.bodyLarge,
            maxLines: 6,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Type your note\u2026',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppConstants.spaceMD),

          // ── Buttons ───────────────────────────────────────────────────────
          Row(
            children: [
              // Clear
              if (widget.initialNote.isNotEmpty)
                TextButton(
                  onPressed: _isSaving ? null : widget.onClear,
                  child: Text(
                    'CLEAR',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppConstants.whiteSubtle,
                    ),
                  ),
                ),
              const Spacer(),
              // Cancel
              TextButton(
                onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                child: Text(
                  'CANCEL',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppConstants.whiteSubtle,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spaceSM),
              // Save
              ElevatedButton(
                onPressed: _isSaving
                    ? null
                    : () async {
                        setState(() => _isSaving = true);
                        try {
                          await widget.onSave(_ctrl.text.trim());
                        } finally {
                          // Always reset — prevents permanently disabled button
                          // if onSave throws or the sheet stays open.
                          if (mounted) setState(() => _isSaving = false);
                        }
                      },
                child: _isSaving
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: AppConstants.black,
                        ),
                      )
                    : Text('SAVE', style: textTheme.labelSmall),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Tag pill ──────────────────────────────────────────────────────────────────

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceSM,
        vertical: AppConstants.spaceXS,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.borderGreyLight,
          width: AppConstants.borderThin,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusSM),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
