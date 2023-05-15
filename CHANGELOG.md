# Changelog

## [2.1.2]
* Remove deprecated ThemeData's properties  

## [2.1.1]

* Fixed `infiteLoop` to `infiniteLoop` typo...

## [2.1.0]

* Added missing params in decimal numberpicker. #99 
* Fixed `itemCount` parameter to actually work. #87
* Added `padding: EdgeInsets.zero` to ListView to make it work without SafeArea. #74
* Added `infiniteLoop` option. #97

## [2.0.1]

* Fixed empty scrollController position bug #95 

## [2.0.0] **BREAKING CHANGES**
* Migrate to **null-safety**.
* Changed named constructors to two separate widgets.
  * `NumberPicker.integer` is now `NumberPicker`.
  * `NumberPicker.decimal` is now `DecimalNumberPicker`.
  * `NumberPicker.horizontal` is now `NumberPicker` with `axis: Axis.horizontal`
* Removed `infiniteLoop` to make it possible to go to null safety. The feature will come back once the `infitniteListView` package gets null-safe.
* Removed dialogs containing pickers. I think it's better to just leave it for developers.
* Removed `animateInt` method and replaced it with just reacting to value changed (see example).
* Changed animation curve to `Curves.easeOutCubic`.
* Changed `initialValue` to `value` to avoid confusion from my awful naming.
* Removed `highlightSelectedValue` as it can be obtained by providing `selectedTextStyle`.
* Migrated example to Android embedding v2
* Fixed some minor bugs.

## [1.3.0]

* Added `textStyle` and `selectedTextStyle` params (Thanks to @AliRn76)
* Made animate methods asynchronous

## [1.2.1]

* Added optional haptics
* Added missing params to NumberPickerDialog
* Minor code cleanups

## [1.2.0]

* Added a text mapper to customize number text

## [1.1.0]
* Added zero-pad
* Added custom decoration for selected value
* Added disabling highlight of selected value
* Added horizontal number picker
* Fixed bug with animating selected value when user stops scrolling

## [1.0.0]
* Added infinite loop option

## [0.1.7]
* Fixed step bug

## [0.1.6]
* Updated environment sdk dependency

## [0.1.5]
* Added `step` paramater for integer picker

## [0.1.4]
* Solved normalizing decimal places bug

## [0.1.3]

* Fixed issue with small integer ranges

## [0.1.2]

* Added environment restrictions

## [0.1.1]

* Fixed iOS overscroll bug
* Updated example's dependencies

## [0.1.0]

* NEW: Initial Release.
