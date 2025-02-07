import 'package:flutter/material.dart';

class GetEmailDialogWidget extends StatefulWidget {
  const GetEmailDialogWidget({super.key});

  @override
  State<GetEmailDialogWidget> createState() => _GetEmailDialogWidgetState();
}

class _GetEmailDialogWidgetState extends State<GetEmailDialogWidget> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Email'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Enter email to send a .ics file to it'),
          SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'example@mail.com',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String email = _emailController.text.trim();

            if (email.isEmpty || !_isValidEmail(email)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a valid email address')),
              );
            } else {
              Navigator.of(context).pop(email);
            }
          },
          child: Text('Send .ics'),
        ),
      ],
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
