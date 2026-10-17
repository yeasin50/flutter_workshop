import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),

        actions: [
          IconButton(
            onPressed: () {
              context.push("/setting");
            },
            icon: Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          TextButton(
            onPressed: () {
              context.go("/details");
            },
            child: Text("goto details"),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DetailsPage")),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          TextButton(onPressed: context.pop, child: const Text('Go back')),
          TextButton(
            onPressed: () => context.push('/setting'),
            child: const Text('replace with Settings screen'),
          ),
        ],
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SettingPage"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              // context.go("/");
              context.pop();
            },
            child: Text("Home"),
          ),
        ],
      ),
    );
  }
}
