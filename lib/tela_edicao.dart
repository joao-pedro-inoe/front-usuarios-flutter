import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaEdicao extends StatefulWidget {
  // Recebe os dados do usuário que foi clicado na lista
  final Map<String, dynamic> usuario;

  const TelaEdicao({super.key, required this.usuario});

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  bool _carregando = false;

  @override
  void initState() {
    super.initState();
    // Preenche os campos com os dados atuais do usuário
    _nomeController = TextEditingController(text: widget.usuario['nome']);
    _emailController = TextEditingController(text: widget.usuario['email']);
  }

  Future<void> _atualizarUsuario() async {
    final nome = _nomeController.text;
    final email = _emailController.text;

    if (nome.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    setState(() => _carregando = true);

    try {
      final id = widget.usuario['id'];
      final response = await http.put(
        Uri.parse('http://localhost:3000/usuarios/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuário atualizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          // Volta para a tela anterior enviando "true" para avisar que houve mudança
          Navigator.pop(context, true);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao atualizar: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha na conexão com o servidor.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 32),
            _carregando
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _atualizarUsuario,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Atualizar'),
                  ),
          ],
        ),
      ),
    );
  }
}