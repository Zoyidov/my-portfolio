import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/responsive/responsive.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text.dart';
import '../../../../core/widgets/ui_card.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // ✅ Your real data (edit these)
  static const String telegramUsername = 'zoyidov_nurmuxammad'; // without @
  static const String email = 'nurmuxammad_zoyidov@gmail.com';
  static const String location = 'Fergana, Uzbekistan';
  static const String timezone = 'UTC+5 (GMT+5)';

  static const String githubUrl = 'https://github.com/Zoyidov';
  static const String linkedinUrl = 'https://uz.linkedin.com/in/nurmuhammad-zoyidov-4abb9a273';
  static const String twitterUrl = 'https://x.com/nurmuxammad_dev';
  static const String instagramUrl = 'https://www.instagram.com/zoyidov_nurmuxammad/';

  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _subjectC = TextEditingController();
  final _messageC = TextEditingController();

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _subjectC.dispose();
    _messageC.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // fallback: try in browser
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  String _buildTelegramText() {
    final name = _nameC.text.trim();
    final mail = _emailC.text.trim();
    final subject = _subjectC.text.trim();
    final msg = _messageC.text.trim();

    return [
      "Hello Nurmuxammad 👋",
      "",
      if (subject.isNotEmpty) "Subject: $subject",
      if (name.isNotEmpty) "Name: $name",
      if (mail.isNotEmpty) "Email: $mail",
      "",
      msg.isEmpty ? "(No message body)" : msg,
    ].join("\n");
  }

  Future<void> _sendToTelegram() async {
    final text = _buildTelegramText();

    // ✅ Copy to clipboard
    await Clipboard.setData(ClipboardData(text: text));

    final encoded = Uri.encodeComponent(text);

    // ✅ Best-effort direct profile chat with prefilled text
    final direct = Uri.parse('https://t.me/$telegramUsername?text=$encoded');

    // ✅ Fallback: Telegram share URL (always supported)
    final share = Uri.parse('https://t.me/share/url?text=$encoded');

    // Try direct first, then fallback
    final okDirect = await launchUrl(direct, mode: LaunchMode.externalApplication);
    if (!okDirect) {
      await launchUrl(share, mode: LaunchMode.externalApplication);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message copied ✅ Opening Telegram...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.pagePadding(context),
      child: ListView(
        children: [
          const Text('Get In Touch', style: AppText.h2),
          const SizedBox(height: 6),
          Text(
            "Let’s discuss your next Flutter project or collaboration opportunity",
            style: AppText.body.copyWith(color: AppColors.text3),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(builder: (context, c) {
            final twoCol = c.maxWidth >= 1100;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: _messageForm()),
                if (twoCol) const SizedBox(width: 16),
                if (twoCol)
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        _contactInfo(),
                        const SizedBox(height: 16),
                        _connect(),
                        const SizedBox(height: 16),
                        _status(),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _messageForm() {
    InputDecoration deco(String hint) => InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.text3),
      filled: true,
      fillColor: AppColors.card2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.stroke),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary.withOpacity(0.7)),
      ),
    );

    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.send_outlined, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text('Send Me a Message', style: AppText.h3),
        ]),
        const SizedBox(height: 16),

        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Your Name', style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 6),
              TextField(
                controller: _nameC,
                decoration: deco('e.g. Zoyidov Nurmuxammad'),
              ),
            ]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Your Email', style: AppText.caption.copyWith(color: AppColors.text3)),
              const SizedBox(height: 6),
              TextField(
                controller: _emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: deco('e.g. nurmuxammadzoyidov@gmail.com'),
              ),
            ]),
          ),
        ]),
        const SizedBox(height: 12),

        Text('Subject', style: AppText.caption.copyWith(color: AppColors.text3)),
        const SizedBox(height: 6),
        TextField(
          controller: _subjectC,
          decoration: deco('Flutter MVP • UI/UX • Backend integration • Consulting'),
        ),
        const SizedBox(height: 12),

        Text('Message', style: AppText.caption.copyWith(color: AppColors.text3)),
        const SizedBox(height: 6),
        TextField(
          controller: _messageC,
          minLines: 6,
          maxLines: 10,
          decoration: deco(
            "Hi Nurmuxammad! I’d like to discuss...\n"
                "- Project type:\n"
                "- Timeline:\n"
                "- Budget range:\n"
                "- Key features:\n",
          ),
        ),
        const SizedBox(height: 14),

        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _sendToTelegram,
            icon: const Icon(Icons.send),
            label: const Text('Send Message (Telegram)'),
          ),
        ),
      ]),
    );
  }

  Widget _contactInfo() {
    Widget tile(IconData icon, String title, String value, Color color) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.14),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.stroke),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: AppText.caption.copyWith(color: AppColors.text3)),
                const SizedBox(height: 4),
                Text(value, style: AppText.body.copyWith(fontWeight: FontWeight.w800)),
              ]),
            ),
          ],
        ),
      );
    }

    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Contact Information', style: AppText.h3),
        const SizedBox(height: 14),
        tile(Icons.mail_outline, 'Email', email, AppColors.primary),
        const SizedBox(height: 12),
        tile(Icons.location_on_outlined, 'Location', location, AppColors.green),
        const SizedBox(height: 12),
        tile(Icons.schedule, 'Timezone', timezone, AppColors.orange),
        const SizedBox(height: 12),
        tile(Icons.chat_bubble_outline, 'Response Time', 'Usually within 24 hours', AppColors.purple),
      ]),
    );
  }

  Widget _connect() {
    Widget linkTile(IconData icon, String title, String handle, String url) {
      return InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _openUrl(url),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.card2,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.stroke),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.text2, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: AppText.body.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(handle, style: AppText.caption.copyWith(color: AppColors.text3)),
                ]),
              ),
              const Icon(Icons.open_in_new, size: 16, color: AppColors.text3),
            ],
          ),
        ),
      );
    }

    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Connect With Me', style: AppText.h3),
        const SizedBox(height: 14),

        linkTile(Icons.code, 'GitHub', '@Zoyidov', githubUrl),
        const SizedBox(height: 12),

        linkTile(Icons.business_center_outlined, 'LinkedIn', 'zoyidov_nurmuxammad', linkedinUrl),
        const SizedBox(height: 12),

        // linkTile(Icons.alternate_email, 'Twitter (X)', '@nurmuxammad_dev', twitterUrl),
        // const SizedBox(height: 12),

        linkTile(Icons.alternate_email, 'Instagram', '@zoyidov_nurmuxammad', instagramUrl),

        const SizedBox(height: 12),

        // ✅ Telegram quick link (optional)
        linkTile(Icons.send, 'Telegram', '@$telegramUsername', 'https://t.me/$telegramUsername'),
      ]),
    );
  }

  Widget _status() {
    return UiCard(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.stroke),
            ),
            child: const Icon(Icons.bolt, color: AppColors.orange, size: 18),
          ),
          const SizedBox(width: 12),
          const Text('Current Status', style: AppText.h3),
        ]),
        const SizedBox(height: 12),
        Text('Busy', style: AppText.h3.copyWith(color: AppColors.orange)),
        const SizedBox(height: 6),
        Text(
          'Currently working on ChortoqGo MVP.\nAvailable for new projects from March 2026.',
          style: AppText.body2.copyWith(color: AppColors.text3),
        ),
      ]),
    );
  }
}