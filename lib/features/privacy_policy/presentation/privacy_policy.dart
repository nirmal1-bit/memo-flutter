import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          "Privacy Policy",
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
                          Icons.shield_outlined,
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
                    'Privacy Policy',
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
              'This privacy policy applies to the Menmo app for mobile devices, together with any related services operated by Nirmal Chhetri (collectively, the "Application"). Nirmal Chhetri is hereby referred to as the "Service Provider".',
            ),

            const SizedBox(height: 24),

            // ── Sections ─────────────────────────────────────────────────
            _section(
              'Information Collection and Use',
              'The Application collects information when you download and use it. This information may include:\n\n• Your device\'s Internet Protocol address\n• The pages of the Application that you visit, the time and date of your visit, and the time spent on those pages\n• The total time spent on the Application\n• The mobile operating system you use\n\nFor a better experience, the Service Provider may require you to provide certain personally identifiable information, including but not limited to your name, age, and email. This information will be retained and used as described in this privacy policy.',
            ),

            _section(
              'Cookies and Tracking Technologies',
              'The Application or its third-party SDKs may use cookies, SDKs, pixels, and similar technologies to support functionality, analytics, or service delivery. Where required by applicable law, the Service Provider will obtain consent before using non-essential tracking technologies.',
            ),

            _section(
              'Location Information',
              'The Application collects your device\'s location to provide location-based features, improve the Application, and support related services.\n\n• Geolocation Services: The Service Provider may use location data to provide location-based features or content.\n• Analytics and Improvements: Aggregated location data may help the Service Provider understand usage patterns and improve performance.\n• Third-Party Services: Location data may be shared with third-party services used to support Application functionality, subject to this privacy policy and applicable law.',
            ),

            _section(
              'Artificial Intelligence',
              'The Application uses Artificial Intelligence (AI) technologies to enhance user experience and provide certain features. The AI components may process user data to deliver personalized content, recommendations, or automated functionalities. All AI processing is performed in accordance with this privacy policy and applicable laws.\n\nIf you have questions about the AI features or data processing, please contact the Service Provider.',
            ),

            _section(
              'Third-Party Access',
              'Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application. The Application utilizes third-party services that have their own privacy policies:\n\n• Google Play Services\n• Google Analytics for Firebase\n• Firebase Crashlytics\n• RevenueCat\n\nThe Service Provider may disclose your information as required by law; when necessary to protect rights, safety, or investigate fraud; or with trusted service providers who work on their behalf and have agreed to adhere to the rules set forth in this privacy policy.',
            ),

            _section(
              'International Data Transfers',
              'The Service Provider or its third-party service providers may transfer personal data to countries outside your country of residence, including outside the European Economic Area (EEA). Where applicable law requires safeguards, the Service Provider will use appropriate mechanisms such as:\n\n• Standard Contractual Clauses (SCCs) approved by the European Commission\n• Adequacy decisions or other legally recognized transfer mechanisms\n• Your consent, where required and legally permitted',
            ),

            _section(
              'Your Rights',
              'You may request access to, correction of, or deletion of your personal data held by the Service Provider. To exercise these rights, or to withdraw consent where processing is based on consent, contact the Service Provider at morespacenirmal@gmail.com.',
            ),

            _section(
              'Your California Privacy Rights (CCPA/CPRA)',
              'If you are a California resident, you have the following rights:\n\n• The right to know what personal information is collected\n• The right to delete personal information\n• The right to opt out of the sale or sharing of personal information\n• The right to non-discrimination for exercising these rights\n\nTo exercise your CCPA/CPRA rights, contact the Service Provider at morespacenirmal@gmail.com.',
            ),

            _section(
              'Opt-Out Rights',
              'You can stop further collection of information from your mobile device by uninstalling the Application. Uninstalling will stop the Application from collecting data from your device, but does not automatically delete information that has already been transmitted to the Service Provider or to third parties.\n\nTo request deletion of your personal data, withdraw consent, or exercise any of your rights, contact the Service Provider at morespacenirmal@gmail.com.',
            ),

            _section(
              'Data Retention Policy',
              'The Service Provider retains personal data based on its necessity for the stated purposes:\n\n• User Provided Data: Retained for the duration of your use of the Application plus 12 months thereafter, unless longer retention is required by law\n• Automatically Collected Data: Retained for up to 24 months from collection\n• Aggregated and Anonymized Data: Retained indefinitely as it no longer identifies you\n• Data required for legal compliance: Retained as long as required by applicable law',
            ),

            _section(
              'Data Deletion',
              'You can request deletion of your personal data or account by contacting the Service Provider at morespacenirmal@gmail.com. The Service Provider will process your request within the timeframes required by applicable law.\n\nUpon verification of your identity, the Service Provider will delete your personal data from its systems, except where retention is required for legal compliance or legitimate business purposes.',
            ),

            _section(
              'Children',
              'The Application is not intended for children under 18 years of age, or such higher age as required by applicable law. The Service Provider does not knowingly solicit data from children or market the Application to them.\n\nIf the Service Provider discovers that a child has provided personal information, it will immediately delete this from its servers. If you are a parent or guardian and believe your child has provided personal information, please contact morespacenirmal@gmail.com.',
            ),

            _section(
              'Security',
              'The Service Provider is concerned about safeguarding the confidentiality of your information and provides physical, electronic, and procedural safeguards to protect the information it processes and maintains.',
            ),

            _section(
              'Data Breach Notification',
              'If a data breach occurs that affects your personal data, the Service Provider will notify you in accordance with applicable legal requirements, including information about the nature of the breach and the steps being taken to address it.',
            ),

            _section(
              'Your Consent',
              'Where processing is based on consent, you provide that consent by affirmatively opting in to the relevant feature or action. You may withdraw consent at any time without affecting processing carried out before withdrawal.',
            ),

            _section(
              'Changes to This Policy',
              'The Service Provider may update this Privacy Policy from time to time and will notify you of material changes by posting the updated policy with an effective date. Where required by law, consent will be sought before material changes take effect.\n\nPrevious versions of this Privacy Policy are maintained and available upon request at morespacenirmal@gmail.com.\n\nThis privacy policy is effective as of 2026-08-04.',
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
                    'If you have any questions regarding privacy while using the Application, or have questions about our practices, please contact the Service Provider.',
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
