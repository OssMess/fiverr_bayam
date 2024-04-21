import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../enums.dart';
import '../models.dart';

class ListFAQ {
  static List<List<FAQ>> map = [];

  static void init(BuildContext context) {
    map.clear();
    if (AppLocalizations.of(context)!.localeName == 'en') {
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
                'To reset your password, go to the login screen and tap on the "Forgot Password" option. Follow the instructions sent to your registered email.',
          ),
          FAQ(
            question: 'What should I do if I\'m experiencing app crashes?',
            answer:
                'Try restarting your device first. If the issue persists, uninstall and reinstall the app. If the problem continues, contact our support team.',
          ),
          FAQ(
            question: 'How can I change my notification settings?',
            answer:
                'You can customize your notification preferences in the app\'s settings menu. Look for the "Notification Settings" option.',
          ),
          FAQ(
            question: 'Can I use the app on multiple devices?',
            answer:
                'In most cases, yes. You can log in to your account on multiple devices, but be aware of any device limits outlined in our Terms of Service.',
          ),
        ],
        [
          FAQ(
            question:
                'How do I purchase insurance for my order or reservation?',
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
    } else {
      map = [
        [
          FAQ(
            question:
                'Comment puis-je trouver mon historique de transactions ?',
            answer:
                'Votre historique de transactions est disponible dans la section "Mon Compte" ou "Historique des Transactions" de l\'application.',
          ),
          FAQ(
            question:
                'Mes informations personnelles sont-elles en sécurité avec l\'application ?',
            answer:
                'Nous prenons votre vie privée au sérieux. Vos informations personnelles sont stockées et protégées de manière sécurisée. Pour plus de détails, consultez notre Politique de confidentialité.',
          ),
          FAQ(
            question: 'Comment puis-je effectuer un retrait ?',
            answer:
                'Pour effectuer un retrait, rendez-vous sur l\'option "Retrait" ou "Encaissement" dans l\'application. Suivez les instructions à l\'écran pour sélectionner votre méthode de retrait et le montant.',
          ),
          FAQ(
            question: 'Comment puis-je annuler un paiement ?',
            answer:
                'Pour annuler un paiement, accédez à votre historique de transactions et localisez le paiement en attente. Si l\'option est disponible, vous pouvez appuyer sur "Annuler" ou "Demander un remboursement". Suivez les invites pour compléter le processus d\'annulation. Si vous rencontrez des problèmes, contactez notre équipe d\'assistance pour obtenir de l\'aide.',
          ),
        ],
        [
          FAQ(
            question: 'Comment puis-je annuler ma commande ?',
            answer:
                'Pour annuler votre commande, rendez-vous dans votre historique de commandes, sélectionnez la commande que vous souhaitez annuler et appuyez sur le bouton "Annuler". Veuillez noter que des politiques d\'annulation peuvent s\'appliquer, donc examinez-les avant de procéder.',
          ),
          FAQ(
            question: 'Puis-je annuler un abonnement à tout moment ?',
            answer:
                'Oui, dans la plupart des cas, vous pouvez annuler un abonnement à tout moment. Rendez-vous dans la section "Gestion des abonnements" dans les paramètres de votre compte pour localiser l\'abonnement et sélectionner "Annuler". Soyez conscient des termes d\'annulation mentionnés dans votre contrat d\'abonnement.',
          ),
          FAQ(
            question:
                'Quelle est la politique d\'annulation pour les billets d\'événement ?',
            answer:
                'La politique d\'annulation pour les billets d\'événement varie selon l\'organisateur de l\'événement. Veuillez vérifier les détails de l\'événement ou contacter directement l\'organisateur pour obtenir des informations sur l\'annulation des billets, les remboursements ou les échanges.',
          ),
          FAQ(
            question:
                'J\'ai annulé ma réservation par erreur. Est-il possible d\'annuler l\'annulation ?',
            answer:
                'Une fois qu\'une réservation est annulée, elle peut ne pas être réversible. Pour vous renseigner sur la réactivation d\'une réservation annulée, veuillez contacter notre équipe de support client dès que possible. Nous ferons de notre mieux pour vous aider.',
          ),
        ],
        [
          FAQ(
            question: 'Comment réinitialiser mon mot de passe ?',
            answer:
                'Pour réinitialiser votre mot de passe, allez à l\'écran de connexion et appuyez sur l\'option "Mot de passe oublié". Suivez les instructions envoyées à votre adresse e-mail enregistrée.',
          ),
          FAQ(
            question: 'Que dois-je faire si l\'application plante ?',
            answer:
                'Essayez d\'abord de redémarrer votre appareil. Si le problème persiste, désinstallez puis réinstallez l\'application. Si le problème persiste, contactez notre équipe d\'assistance.',
          ),
          FAQ(
            question:
                'Comment puis-je modifier mes paramètres de notification ?',
            answer:
                'Vous pouvez personnaliser vos préférences de notification dans le menu des paramètres de l\'application. Recherchez l\'option "Paramètres de notification".',
          ),
          FAQ(
            question:
                'Puis-je utiliser l\'application sur plusieurs appareils ?',
            answer:
                'Dans la plupart des cas, oui. Vous pouvez vous connecter à votre compte sur plusieurs appareils, mais veillez à respecter les limites de périphérique définies dans nos Conditions d\'utilisation.',
          ),
        ],
        [
          FAQ(
            question:
                'Comment puis-je acheter une assurance pour ma commande ou ma réservation ?',
            answer:
                'Vous pouvez souscrire une assurance lors du processus de paiement lors de votre commande ou réservation. Recherchez l\'option "Ajouter une assurance" ou "Plan de protection" et suivez les invites pour sélectionner votre couverture.',
          ),
          FAQ(
            question: 'Quels types de couverture d\'assurance sont proposés ?',
            answer:
                'Nous proposons différents types de couverture d\'assurance, y compris l\'assurance voyage, les plans de protection des produits, et plus encore. Les options de couverture spécifiques disponibles peuvent varier en fonction de votre achat. Consultez les détails de l\'assurance lors du processus de paiement pour des informations détaillées.',
          ),
          FAQ(
            question:
                'Comment puis-je déposer une réclamation d\'assurance en cas d\'incident ou de perte ?',
            answer:
                'Pour déposer une réclamation d\'assurance, rendez-vous dans la section "Réclamations d\'assurance" ou "Centre des réclamations" de votre compte. Suivez les instructions fournies pour soumettre votre réclamation, en fournissant tous les documents nécessaires et les détails sur l\'incident.',
          ),
          FAQ(
            question:
                'Puis-je modifier ma couverture d\'assurance après l\'achat ?',
            answer:
                'Dans certains cas, vous pouvez être en mesure de modifier votre couverture d\'assurance après l\'achat, selon les termes de la police. Rendez-vous dans la section "Gestion de l\'assurance" ou "Ajustements de la police" de votre compte pour explorer vos options et effectuer les ajustements nécessaires.',
          ),
        ],
      ];
    }
  }

  static List<FAQ> getListFAQ(FAQType faqType) => map[faqType.index];

  static FAQType getFAQTypeFromIndex(int index) => {
        0: FAQType.payment,
        1: FAQType.cancellations,
        2: FAQType.account,
        3: FAQType.insurance,
      }[index]!;
}
