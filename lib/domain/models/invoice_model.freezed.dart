// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvoiceModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get contrahent => throw _privateConstructorUsedError;
  double get net => throw _privateConstructorUsedError;
  int get vat => throw _privateConstructorUsedError;
  String get gross => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvoiceModelCopyWith<InvoiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceModelCopyWith<$Res> {
  factory $InvoiceModelCopyWith(
          InvoiceModel value, $Res Function(InvoiceModel) then) =
      _$InvoiceModelCopyWithImpl<$Res, InvoiceModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String contrahent,
      double net,
      int vat,
      String gross,
      String fileName});
}

/// @nodoc
class _$InvoiceModelCopyWithImpl<$Res, $Val extends InvoiceModel>
    implements $InvoiceModelCopyWith<$Res> {
  _$InvoiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? contrahent = null,
    Object? net = null,
    Object? vat = null,
    Object? gross = null,
    Object? fileName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contrahent: null == contrahent
          ? _value.contrahent
          : contrahent // ignore: cast_nullable_to_non_nullable
              as String,
      net: null == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as double,
      vat: null == vat
          ? _value.vat
          : vat // ignore: cast_nullable_to_non_nullable
              as int,
      gross: null == gross
          ? _value.gross
          : gross // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InvoiceModelCopyWith<$Res>
    implements $InvoiceModelCopyWith<$Res> {
  factory _$$_InvoiceModelCopyWith(
          _$_InvoiceModel value, $Res Function(_$_InvoiceModel) then) =
      __$$_InvoiceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String contrahent,
      double net,
      int vat,
      String gross,
      String fileName});
}

/// @nodoc
class __$$_InvoiceModelCopyWithImpl<$Res>
    extends _$InvoiceModelCopyWithImpl<$Res, _$_InvoiceModel>
    implements _$$_InvoiceModelCopyWith<$Res> {
  __$$_InvoiceModelCopyWithImpl(
      _$_InvoiceModel _value, $Res Function(_$_InvoiceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? contrahent = null,
    Object? net = null,
    Object? vat = null,
    Object? gross = null,
    Object? fileName = null,
  }) {
    return _then(_$_InvoiceModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contrahent: null == contrahent
          ? _value.contrahent
          : contrahent // ignore: cast_nullable_to_non_nullable
              as String,
      net: null == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as double,
      vat: null == vat
          ? _value.vat
          : vat // ignore: cast_nullable_to_non_nullable
              as int,
      gross: null == gross
          ? _value.gross
          : gross // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_InvoiceModel extends _InvoiceModel {
  const _$_InvoiceModel(
      {required this.id,
      required this.title,
      required this.contrahent,
      required this.net,
      required this.vat,
      required this.gross,
      required this.fileName})
      : super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final String contrahent;
  @override
  final double net;
  @override
  final int vat;
  @override
  final String gross;
  @override
  final String fileName;

  @override
  String toString() {
    return 'InvoiceModel(id: $id, title: $title, contrahent: $contrahent, net: $net, vat: $vat, gross: $gross, fileName: $fileName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InvoiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contrahent, contrahent) ||
                other.contrahent == contrahent) &&
            (identical(other.net, net) || other.net == net) &&
            (identical(other.vat, vat) || other.vat == vat) &&
            (identical(other.gross, gross) || other.gross == gross) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, contrahent, net, vat, gross, fileName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InvoiceModelCopyWith<_$_InvoiceModel> get copyWith =>
      __$$_InvoiceModelCopyWithImpl<_$_InvoiceModel>(this, _$identity);
}

abstract class _InvoiceModel extends InvoiceModel {
  const factory _InvoiceModel(
      {required final String id,
      required final String title,
      required final String contrahent,
      required final double net,
      required final int vat,
      required final String gross,
      required final String fileName}) = _$_InvoiceModel;
  const _InvoiceModel._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String get contrahent;
  @override
  double get net;
  @override
  int get vat;
  @override
  String get gross;
  @override
  String get fileName;
  @override
  @JsonKey(ignore: true)
  _$$_InvoiceModelCopyWith<_$_InvoiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
