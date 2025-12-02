import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchingBar extends StatefulWidget {
  bool isSearch;

  final ValueChanged<String> onChanged;
  final TextEditingController searchControl;
  SearchingBar({super.key, required this.searchControl,   required this.onChanged,this.isSearch = true});


  @override
  State<StatefulWidget> createState() => _SearchingBar();
}

class _SearchingBar extends State<SearchingBar> {
  @override
  void dispose() {
    widget.searchControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // shadow color
            blurRadius: 8, // soften the shadow
            offset: Offset(0, 4), // move shadow down
          ),
        ],
      ),

      child:TextFormField(
      controller: widget.searchControl,
      keyboardType: TextInputType.text,
      textInputAction: widget.isSearch ?TextInputAction.search : null,
      maxLines: 1,
      onChanged:  widget.onChanged,
      decoration: InputDecoration(
        hintText: "searching".tr(),
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: widget.isSearch ? Icon(Icons.search,color: Colors.black,) : null,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),

        border: OutlineInputBorder( borderSide: BorderSide.none ,borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(color: Colors.black),
    ) ,);

  }
}
