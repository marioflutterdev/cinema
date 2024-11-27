import 'package:flutter/material.dart';

final messages = [
  "Cargando Películas",
  "Comprando Palomitas de Maíz",
  "Cargado Populares",
  "Llmando a mi novia",
  "Ya mero...",
  "Esto está tardando más de lo esperado"
];

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("cargando...");

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
