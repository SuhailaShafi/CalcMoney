import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class userDetailsWidget extends StatelessWidget {
  const userDetailsWidget({
    super.key,
    required this.isAssetImage,
    required String selectedAvatarIndex,
    required String username,
  })  : _selectedAvatarIndex = selectedAvatarIndex,
        _username = username;

  final bool isAssetImage;
  final String _selectedAvatarIndex;
  final String _username;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.87,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.teal[400],
            child: ClipRRect(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: isAssetImage
                        ? AssetImage(_selectedAvatarIndex) as ImageProvider
                        : FileImage(File(_selectedAvatarIndex)),

                    //image: AssetImage('assets/images/img.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Helloo',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                '${_username}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
