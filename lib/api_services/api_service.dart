import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todos/models/get_all_todos.dart';
import 'package:todos/models/todo_model.dart';

class ApiService {
  String baseUrl = "https://api.nstack.in";

  // Get all todos
  Future<GetAllTodosModel> getAllTodos() async {
    var response = await http.get(Uri.parse("$baseUrl/v1/todos"));
    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      return GetAllTodosModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  // Add a new todo
  Future<GetAllTodosModel> addTodo(String title, String description, bool isCompleted) async {
    var response = await http.post(
      Uri.parse("$baseUrl/v1/todos"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "description": description,
        "is_completed": isCompleted,
      }),
    );

    if (response.statusCode == 201) {
      debugPrint(jsonDecode(response.body).toString());
      return GetAllTodosModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add todo');
    }
  }

  // Update a todo
  Future<TodoModel> updateTodo(String id, String title, String description, bool isCompleted) async {
    var response = await http.put(
      Uri.parse("$baseUrl/v1/todos/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  // Delete a todo
  Future<void> deleteTodo(String id) async {
    var response = await http.delete(Uri.parse("$baseUrl/v1/todos/$id"));
    if (response.statusCode == 200) {
      debugPrint("Todo deleted successfully");
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
