import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tela_edicao.dart'; // Importante para a navegação funcionar

class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  late Future<List<dynamic>> _usuariosFuture;

  @override
  void initState() {
    super.initState();
    _usuariosFuture = _buscarUsuarios();
  }

  Future<List<dynamic>> _buscarUsuarios() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/usuarios'));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erro no servidor: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha na conexão. O servidor Node.js está rodando?');
    }
  }

  // Função nova para o DELETE
  Future<void> _deletarUsuario(int id) async {
    // Confirmação antes de deletar
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Usuário?'),
        content: const Text('Tem certeza que deseja apagar este registro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    try {
      final response = await http.delete(Uri.parse('http://localhost:3000/usuarios/$id'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário excluído!'), backgroundColor: Colors.red),
        );
        // Recarrega a lista
        setState(() {
          _usuariosFuture = _buscarUsuarios();
        });
      } else {
        throw Exception('Erro ao excluir');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao excluir o usuário.'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _usuariosFuture = _buscarUsuarios();
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _usuariosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    Text(
                      snapshot.error.toString().replaceAll('Exception: ', ''),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          } 
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum usuário encontrado.'));
          }

          final usuarios = snapshot.data!;
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(usuario['nome'] ?? 'Sem nome'),
                  subtitle: Text(usuario['email'] ?? 'Sem e-mail'),
                  // Aqui estão os novos botões de Editar e Excluir
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          // Aguarda o retorno da tela de edição
                          final atualizou = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaEdicao(usuario: usuario),
                            ),
                          );
                          // Se retornou 'true', recarrega a lista
                          if (atualizou == true) {
                            setState(() {
                              _usuariosFuture = _buscarUsuarios();
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletarUsuario(usuario['id']),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}