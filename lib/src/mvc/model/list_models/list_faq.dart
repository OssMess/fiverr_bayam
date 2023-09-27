import 'package:flutter/material.dart';

import '../enums.dart';
import '../models.dart';

class ListFAQ {
  static List<List<FAQ>> map = [];

  static void init(BuildContext context) {
    map.clear();
    map = [
      [
        FAQ(
          question: 'How can I find my transaction history?',
          answer:
              'Your transaction history is available in the "My Account" or "Transaction History" section within the app.',
        ),
        FAQ(
          question: 'Is my personal information safe with the app?',
          answer:
              'We take your privacy seriously. Your personal information is securely stored and protected. For more details, check our Privacy Policy.',
        ),
        FAQ(
          question: 'How can I make a withdrawal?',
          answer:
              'To make a withdrawal, navigate to the "Withdraw" or "Cash Out" option in the app. Follow the on-screen instructions to select your withdrawal method and amount.',
        ),
        FAQ(
          question: 'How can I cancel a payment?',
          answer:
              'To cancel a payment, go to your transaction history and locate the pending payment. If the option is available, you can tap on "Cancel" or "Request a Refund." Follow the prompts to complete the cancellation process. If you encounter issues, contact our support team for assistance.',
        ),
      ],
      [
        FAQ(
          question: 'How do I cancel my order?',
          answer:
              'To cancel your order, go to your order history, select the order you wish to cancel, and tap on the "Cancel" button. Please note that cancellation policies may apply, so review them before proceeding.',
        ),
        FAQ(
          question: 'Can I cancel a subscription at any time?',
          answer:
              'Yes, in most cases, you can cancel a subscription at any time. Visit the "Subscription Management" section in your account settings to locate the subscription and select "Cancel." Be aware of any cancellation terms mentioned in your subscription agreement.',
        ),
        FAQ(
          question: 'What is the cancellation policy for event tickets?',
          answer:
              'The cancellation policy for event tickets varies by event organizer. Please check the event details or contact the organizer directly for information regarding ticket cancellations, refunds, or exchanges.',
        ),
        FAQ(
          question:
              'I accidentally canceled my booking. Can I undo the cancellation?',
          answer:
              'Once a booking is canceled, it may not be reversible. To inquire about reinstating a canceled booking, please contact our customer support team as soon as possible. We\'ll do our best to assist you.',
        ),
      ],
      [
        FAQ(
          question: 'How do I reset my password',
          answer:
              'o reset your password, go to the login screen and tap on the "Forgot Password" option. Follow the instructions sent to your registered email.',
        ),
        FAQ(
          question: 'What should I do if I\'m experiencing app crashes?',
          answer:
              'Try restarting your device first. If the issue persists, uninstall and reinstall the app. If the problem continues, contact our support team.',
        ),
        FAQ(
          question: 'How can I change my notification settings?',
          answer:
              'ou can customize your notification preferences in the app\'s settings menu. Look for the "Notification Settings" option.',
        ),
        FAQ(
          question: 'Can I use the app on multiple devices?',
          answer:
              'In most cases, yes. You can log in to your account on multiple devices, but be aware of any device limits outlined in our Terms of Service.',
        ),
      ],
      [
        FAQ(
          question: 'How do I purchase insurance for my order or reservation?',
          answer:
              'You can purchase insurance during the checkout process when making your order or reservation. Look for the "Add Insurance" or "Protection Plan" option and follow the prompts to select your coverage.',
        ),
        FAQ(
          question: 'What types of insurance coverage are offered?',
          answer:
              'We offer various types of insurance coverage, including travel insurance, product protection plans, and more. The specific coverage options available may vary based on your purchase. Check the insurance details during the checkout process for comprehensive information.',
        ),
        FAQ(
          question:
              'How do I file an insurance claim in case of an incident or loss?',
          answer:
              'To file an insurance claim, visit the "Insurance Claims" or "Claims Center" section in your account. Follow the instructions provided to submit your claim, providing all necessary documentation and details about the incident.',
        ),
        FAQ(
          question:
              'Can I make changes to my insurance coverage after purchase?',
          answer:
              'In some cases, you may be able to make changes to your insurance coverage after purchase, depending on the policy terms. Visit the "Insurance Management" or "Policy Adjustments" section in your account to explore your options and make any necessary adjustments.',
        ),
      ],
    ];
  }

  static List<FAQ> getListFAQ(FAQType faqType) => map[faqType.index];

  static FAQType getFAQTypeFromIndex(int index) => {
        0: FAQType.payment,
        1: FAQType.cancellations,
        2: FAQType.account,
        3: FAQType.insurance,
      }[index]!;
}
