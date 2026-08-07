import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          "Terms & Conditions",
          style: AppTextStyles.rubik.copyWith(
            color: AppColors.softBlack,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header card ──────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF935FA7), Color(0xFF2E1A38)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          color: AppColors.secondary2,
                          size: 13,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Menmo · Nirmal Chhetri',
                          style: AppTextStyles.rubik.copyWith(
                            color: AppColors.secondary2,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Terms & Conditions',
                    style: AppTextStyles.libre.copyWith(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Effective as of August 04, 2026',
                    style: AppTextStyles.rubik.copyWith(
                      color: AppColors.white.withOpacity(0.65),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Intro ────────────────────────────────────────────────────
            _body(
              'These terms and conditions apply to the Menmo app for mobile devices, together with any related services operated by Nirmal Chhetri (collectively, the "Application"). Nirmal Chhetri is hereby referred to as the "Service Provider".\n\nBy downloading or using the Application, you agree to these Terms and Conditions. Please read them carefully before using the Application.',
            ),

            const SizedBox(height: 24),

            // ── Sections ─────────────────────────────────────────────────
            _section(
              'License to Use the Application',
              'Subject to your compliance with these Terms, the Service Provider grants you a limited, non-exclusive, non-transferable, revocable license to install and use the Application on a mobile device for personal or internal business purposes. You may not reproduce, distribute, modify, create derivative works from, reverse engineer, decompile, or disassemble the Application, except as and only to the extent that such activity is expressly permitted by applicable law.',
            ),

            _section(
              'Intellectual Property',
              'The Service Provider retains all intellectual property rights in the Application, including its code, design, trademarks, service marks, trade names, logos, and branding. Nothing in these Terms grants you any license or right to use the Service Provider\'s trademarks, logos, or branding for any purpose. You agree not to remove, alter, or obscure any copyright, trademark, or other proprietary notices displayed in or on the Application.\n\nUnauthorized copying, modification of the Application, or its trademarks is strictly prohibited. Any attempts to extract the source code, translate the Application into other languages, or create derivative versions are not permitted.',
            ),

            _section(
              'Termination',
              'The Service Provider may suspend your access to the Application if you materially breach these Terms. You will receive written notice of the breach and, where it is capable of cure, you will have 14 days from receipt to remedy the breach. If you fail to cure within that period, the Service Provider may terminate your access.\n\nThe Service Provider may suspend or terminate your access immediately without notice if you violate applicable law, infringe intellectual property rights, or engage in activity that could cause harm to other users or the Service Provider.\n\nUpon termination, your right to use the Application will end and you must delete all copies from your devices.',
            ),

            _section(
              'Eligibility',
              'By accessing and using this Application, you represent that you are legally permitted to use it in your jurisdiction. You must be at least 18 years of age (or the age of digital consent in your jurisdiction) to use the Application. If you are below 18, a parent or legal guardian must review and accept these Terms on your behalf.',
            ),

            _section(
              'User-Generated Content & Acceptable Use',
              'If this Application allows users to post, share, or upload content, you agree not to post content that:\n\n• Is illegal or violates third-party intellectual property rights\n• Is abusive, threatening, harassing, defamatory, or hate speech\n• Contains discrimination or incitement to violence or illegal activity\n• Is spam, phishing, or contains malware\n• Violates the privacy or personal data rights of others\n• Is misleading, false, or deceptive\n• Contains explicit violence or sexual content (unless age-gated appropriately)\n\nThe Service Provider reserves the right to remove or disable content that violates these guidelines, suspend or terminate accounts of repeat violators, cooperate with law enforcement, and moderate content that violates applicable law.\n\nBy submitting content, you grant the Service Provider a non-exclusive, worldwide, royalty-free license to use, reproduce, distribute, and display the content in connection with the Application. This license does not grant the right to sell your content to third parties. You retain ownership of your content.\n\nIf you believe content violates these Terms or is unlawful, report it to morespacenirmal@gmail.com with sufficient detail to identify the content and evaluate the complaint.',
            ),

            _section(
              'Third-Party Services',
              'The Application uses the following third-party services, each governed by their own terms:\n\n• Google Play Services\n• Google Analytics for Firebase\n• Firebase Crashlytics\n• RevenueCat\n\nSome functions of the Application require an active internet connection. The Service Provider cannot be held responsible if the Application does not function at full capacity due to lack of Wi-Fi or exhausted data allowance. Your mobile network provider\'s agreement terms still apply and you may incur data charges.',
            ),

            _section(
              'Artificial Intelligence',
              'The Application incorporates Artificial Intelligence (AI) technologies to provide certain features or services. By using the Application, you acknowledge and agree that AI may be used to process data and deliver functionalities. The Service Provider ensures that all AI usage complies with applicable laws and is designed to benefit your experience.',
            ),

            _section(
              'Limitation of Liability',
              'To the fullest extent permitted by law, the Service Provider shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including but not limited to lost profits, data loss, or business interruption, even if advised of the possibility of such damages.\n\nThe Service Provider retains full liability for:\n\n• Death or personal injury caused by negligence\n• Fraud or fraudulent misrepresentation\n• Any other liability that cannot be excluded under applicable law\n\nTo the fullest extent permitted by law, total liability shall not exceed the amount paid by you in the 12 months preceding the claim. If the Application is provided free of charge, the Service Provider\'s liability is limited to the minimum amount permitted by applicable law.',
            ),

            _section(
              'Indemnification',
              'To the fullest extent permitted by law, you agree to indemnify and hold harmless the Service Provider, its affiliates, officers, directors, employees, and agents from and against any claims, liabilities, damages, losses, and expenses, including reasonable legal fees, arising out of your breach of these Terms or intentional misuse of the Application.\n\nThis indemnification does not apply to claims arising from the Service Provider\'s own negligence, breach of these Terms, or violation of applicable law.',
            ),

            _section(
              'Updates & Availability',
              'The Service Provider may update the Application at any time. You are advised to accept updates when offered; if you choose not to, earlier versions may no longer be supported and the Application may not function properly.\n\nThe Service Provider may also cease providing the Application and may terminate its use at any time. Upon such termination, the rights and licenses granted to you will end, and you must cease using and delete the Application from your devices.',
            ),

            _section(
              'DSA Compliance (Digital Services Act)',
              'If the Application qualifies as an intermediary service under the EU Digital Services Act (Regulation (EU) 2022/2065), the following provisions apply:\n\nPoint of Contact: morespacenirmal@gmail.com for direct communication with EU authorities and users.\n\nContent Moderation: When the Service Provider restricts access to content or terminates an account, a clear statement of reasons will be provided, including the nature of the restriction, legal basis, and information on redress.\n\nNotice and Action: Users may submit notices of allegedly illegal content. These will be processed promptly and without automated decision-making where human review is required.\n\nOut-of-Court Dispute Settlement: Disputes regarding moderation decisions may be submitted to an out-of-court dispute settlement body certified under Article 21 of the DSA.\n\nTransparency Reports: Periodic transparency reports are available upon request at morespacenirmal@gmail.com.',
            ),

            _section(
              'Governing Law & Jurisdiction',
              'These Terms and Conditions are governed by the laws of the jurisdiction in which the Service Provider is established, excluding conflict of law rules, except to the extent mandatory consumer protection laws provide otherwise.\n\nAny dispute arising out of or relating to these Terms will be brought before the courts that have jurisdiction under applicable law.',
            ),

            _section(
              'Severability',
              'If any provision of these Terms is held to be invalid, illegal, or unenforceable by a court of competent jurisdiction, such provision shall be modified to the minimum extent necessary to make it valid and enforceable, and the remaining provisions shall remain in full force and effect.',
            ),

            _section(
              'Entire Agreement',
              'These Terms and Conditions, together with the Privacy Policy, constitute the entire agreement between you and the Service Provider concerning your use of the Application, superseding any prior agreements or understandings.',
            ),

            _section(
              'Changes to These Terms',
              'The Service Provider may periodically update these Terms and Conditions. You are advised to review this page regularly for any changes. The Service Provider will notify you of any changes by posting the new Terms on this page.\n\nPrevious versions are maintained and available upon request at morespacenirmal@gmail.com.\n\nThese terms and conditions are effective as of 2026-08-04.',
            ),

            const SizedBox(height: 28),

            // ── Contact footer ───────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.brandBackground,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'If you have any questions or suggestions about these Terms and Conditions, please contact the Service Provider.',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 13,
                      color: AppColors.textBody,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.mail_outline_rounded,
                        size: 15,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'morespacenirmal@gmail.com',
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title with left accent bar
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 3.5,
                height: 20,
                margin: const EdgeInsets.only(top: 1, right: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _body(body),
          const SizedBox(height: 16),
          const Divider(color: AppColors.dividerColor, thickness: 1),
        ],
      ),
    );
  }

  Widget _body(String text) {
    return Text(
      text,
      style: AppTextStyles.rubik.copyWith(
        fontSize: 13.5,
        color: AppColors.textBody,
        height: 1.7,
      ),
    );
  }
}
