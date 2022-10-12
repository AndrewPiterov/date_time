## 0.8.0

* [Changed] `Time` formatting with `enum`
* [Changed] `Time` toString now is 'HH:mm:ss:SSS'
* [Remove]  `totalMilliseconds` use `inMilliseconds` instead
* [Fix] typos

## 0.7.1

* [Add] `milliseconds`

## 0.6.1

* [Add] extension on `DateFormat` to format `Date`
## 0.6.0

* **[BREAKING CHANGE]** getters `now` of `Date` and `Time` into method `now()`
* **[BREAKING CHANGE]** constructors of `Date` and `Time` with required named parameters
* [Add] `copyWith()` for `Date` and `Time`

## 0.5.0

* [Add] getter `now` for `Date`
* [Add] methods `parse` & `tryParse` for `Date`
* [Add] methods `addDuration(dur:)`, `closeTo()`, `formatAs()` for `Time`
* [Add] new date functions and manipulations. Inspirited by dart_date (thanks for [westito](https://github.com/westito))

## 0.4.5

* [Add] arithmetic operators

## 0.4.4

* [Add] `OverflowedTime`
* [Add] more tests

## 0.3.3

[Add] `roundToTheNearestMin` for `Time`

## 0.2.2

[Fix] `addDays` of `Date`

## 0.1.2

* [Add] `upTo` for `TimeRange`
* [Add] `format` for `Time`
* [Rename] `isInRange` to `contains`

## 0.0.2

* [Add] examples

## 0.0.1

* [Add] `Date` and `DateRange` classes
* [Add] `Time` and `TimeRange` classes
* [Add] extensions for `DateTime` to separate `Date` & `Time`
