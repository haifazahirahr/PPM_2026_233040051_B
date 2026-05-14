import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
            ),

            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text(
                      'Halaman pengaturan belum tersedia',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // === HEADER PROFIL ===

            Center(
              child: Column(
                children: [

                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://id.pinterest.com/pin/371054456813199513/',
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Haifa Zahirah Ramdhan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Mahasiswa Teknik Informatika',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // === BARIS STATISTIK ===

            Row(
              children: const [

                Expanded(
                  child: _StatBox(
                    label: 'Post',
                    value: '12',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Teman',
                    value: '128',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Like',
                    value: '1.2K',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // === SECTION CARD ===

            const _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content:
              'Saya suka belajar hal baru, terutama yang berkaitan '
                  'dengan teknologi dan pengembangan aplikasi mobile.',
            ),

            const _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content:
              'Universitas Pasundan — Semester 5\nIPK: 3.75',
            ),

            const _SectionCard(
              icon: Icons.favorite,
              title: 'Hobi & Minat',
              content:
              'Coding • Membaca • Berenang • Game',
            ),

            const _SectionCard(
              icon: Icons.email,
              title: 'Kontak',
              content:
              'haifazahirahr5@gmail.com\n+62 878-6812-7889',
            ),

            // === SECTION SKILLS ===

            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: const [

                        Icon(
                          Icons.star,
                          color: Colors.blue,
                          size: 28,
                        ),

                        SizedBox(width: 16),

                        Text(
                          'Skills',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [

                        Chip(label: Text('Flutter')),
                        Chip(label: Text('Dart')),
                        Chip(label: Text('Firebase')),
                        Chip(label: Text('UI Design')),
                        Chip(label: Text('Problem Solving')),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Edit profil belum tersedia',
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),

          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Pesan',
          ),

          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Icon(
              icon,
              color: Colors.blue,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    content,
                    style: const TextStyle(
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}