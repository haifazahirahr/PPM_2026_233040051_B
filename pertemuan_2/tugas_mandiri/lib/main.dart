import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanProfil(),
    );
  }
}

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE8F3),
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: const Color(0xFFA7BCD1),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFDDE8F3),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF6887A6)),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Home')),
            const ListTile(leading: Icon(Icons.person), title: Text('Profile')),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text(
                        'Halaman pengaturan sedang dalam perbaikan.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK',
                            style: TextStyle(color: Color(0xFF6887A6))),
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HalamanGallery(),
                  ),
                );
              },
            ),
            const ListTile(leading: Icon(Icons.info), title: Text('About')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/300',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Haifa Zahirah Ramdhan',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mahasiswa Teknik Informatika',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(child: BoxStat(judul: 'Post', angka: '12')),
                Expanded(child: BoxStat(judul: 'Teman', angka: '128')),
                Expanded(child: BoxStat(judul: 'Like', angka: '1.2K')),
              ],
            ),
            const SizedBox(height: 24),
            const KartuInfo(
              icon: Icons.info_outline,
              title: 'About Me',
              isi:
              'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan pengembangan aplikasi mobile.',
            ),
            const KartuInfo(
              icon: Icons.school,
              title: 'Education',
              isi: 'Universitas Pasundan — Semester 5\nIPK: 3.75',
            ),
            const KartuInfo(
              icon: Icons.favorite,
              title: 'Hobby & Interest',
              isi: 'Coding • Membaca • Berenang • Game',
            ),
            const KartuInfo(
              icon: Icons.email,
              title: 'Contact',
              isi: 'haifazahirahr5@gmail.com\n+62 878-36812-7889',
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star,
                            color: Color(0xFF6887A6), size: 28),
                        SizedBox(width: 16),
                        Text('Skills',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: const [
                        Chip(label: Text('PHP')),
                        Chip(label: Text('Java')),
                        Chip(label: Text('Flutter')),
                        Chip(label: Text('UI/UX')),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Edit profil belum tersedia'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        label: const Text('Edit'),
        icon: const Icon(Icons.edit),
        backgroundColor: const Color(0xFF6887A6),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (i) {},
        indicatorColor: const Color(0xFFC6D6E6),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Message'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

class BoxStat extends StatelessWidget {
  final String judul;
  final String angka;
  const BoxStat({required this.judul, required this.angka, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(angka,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(judul, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class KartuInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String isi;
  const KartuInfo(
      {required this.icon, required this.title, required this.isi, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF6887A6), size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(isi)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanGallery extends StatelessWidget {
  const HalamanGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
      ('Display', Icons.image, Colors.pink),
      ('Input', Icons.edit, Colors.blue),
      ('Button', Icons.smart_button, Colors.yellow),
      ('Feedback', Icons.notifications, Colors.green),
      ('Layout', Icons.dashboard, Colors.teal),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Widget Gallery')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (c, i) {
          final item = list[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item.$3,
                child: Icon(item.$2, color: Colors.white),
              ),
              title: Text(item.$1),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}