import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/food_spot_thumbnails_cubit.dart';
import '../../constants.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _textFieldController;
  late final FocusNode _textFieldFocusNode;

  bool closeButtonIsVisible = false;
  bool searchIconIsReplacedByBackIcon = false;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    _textFieldFocusNode = FocusNode();

    _textFieldController.addListener(_textFieldControllerListener);
    _textFieldFocusNode.addListener(_textFieldFocusNodeListener);
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _textFieldFocusNodeListener() {
    setState(() {
      searchIconIsReplacedByBackIcon = _textFieldFocusNode.hasFocus;
    });
  }

  void _textFieldControllerListener() {
    setState(() {
      closeButtonIsVisible = _textFieldController.value.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_textFieldFocusNode),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: ColorConstants.lightGrey1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            searchIconIsReplacedByBackIcon
                ? GestureDetector(
                    onTap: () {
                      _textFieldController.clear();
                      _textFieldFocusNode.unfocus();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: ColorConstants.darkGrey2,
                    ),
                  )
                : const Icon(
                    Icons.search,
                    size: 20,
                    color: ColorConstants.darkGrey1,
                  ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.center,
                child: TextField(
                  controller: _textFieldController,
                  focusNode: _textFieldFocusNode,
                  onChanged: context.read<FoodSpotThumbnailsCubit>().search,
                  keyboardType: TextInputType.text,
                  cursorColor: ColorConstants.darkGrey1,
                  cursorHeight: 15,
                  style: const TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 13.3),
                    fillColor: Colors.red,
                    hintText: "Search food services",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            closeButtonIsVisible
                ? GestureDetector(
                    onTap: _textFieldController.clear,
                    child: Container(
                      padding: const EdgeInsets.all(1.5),
                      decoration: const BoxDecoration(
                        color: ColorConstants.darkGrey1,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
