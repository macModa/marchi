import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class WhatsAppButton extends StatelessWidget {
  final String phone;
  final String message;

  const WhatsAppButton({super.key, required this.phone, required this.message});

  Future<void> _launchWhatsApp(BuildContext context) async {
    try {
      final Uri whatsappUrl;

      // Clean phone number (remove + and spaces if any, though requirement says input is clean)
      final cleanPhone = phone.replaceAll(RegExp(r'[+\s]'), '');

      if (kIsWeb) {
        whatsappUrl = Uri.parse(
          'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}',
        );
      } else {
        if (Platform.isAndroid) {
          whatsappUrl = Uri.parse(
            'whatsapp://send?phone=$cleanPhone&text=${Uri.encodeComponent(message)}',
          );
        } else {
          // iOS
          whatsappUrl = Uri.parse(
            'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}',
          );
        }
      }

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback for when app is not installed (especially on Android)
        final webUrl = Uri.parse(
          'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}',
        );
        if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Impossible d\'ouvrir WhatsApp'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => _launchWhatsApp(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25D366), // Official WhatsApp Green
          foregroundColor: Colors.white,
          elevation: 0, // Handled by Container shadow for softer effect
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: const FaIcon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
          size: 24,
        ),
        label: const Text(
          'Discuter sur WhatsApp',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
