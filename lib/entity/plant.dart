import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@dao
class Plant {
  @primaryKey
  final int id;
  String name;
  DateTime createdAt;
  DateTime? gone;

  Plant(
    this.name,
  ) : createdAt = DateTime.now() {
    createdAt = DateTime.now();
  }
}
