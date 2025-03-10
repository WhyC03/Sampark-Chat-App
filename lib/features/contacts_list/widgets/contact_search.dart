import 'dart:developer';
import 'package:flutter/material.dart';

class ContactSearch extends StatelessWidget {
  const ContactSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (val) => {
          log(val),
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: "Search Contact",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
