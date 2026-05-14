import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

// APP

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Saya',
      home: const HomeScreen(),
    );
  }
}


// MODEL

class PengalamanItem {
  Uint8List? gambar;
  String judul;
  String deskripsi;

  PengalamanItem({
    this.gambar,
    required this.judul,
    required this.deskripsi,
  });
}

class ProfileData {
  static final ProfileData _instance = ProfileData._internal();

  factory ProfileData() => _instance;

  ProfileData._internal();

  Uint8List? fotoProfil;

  String nama = 'Haifa Zahirah Ramdhan';
  String bio = 'Mahasiswa Teknik Informatika';
  String tentang = 'Belajar Flutter!';
  String pendidikan = 'Teknik Informatika - Semester 6';
  String lokasi = 'Bandung, Jawa Barat';
  String kontak = 'haifazahirahr5@gmail.com';

  List<String> skills = [
    'Flutter',
    'Dart',
    'Java',
    'Python',
    'Git'
  ];

  int post = 12;
  int teman = 128;
  double like = 1.2;

  List<PengalamanItem> pengalaman = [];
}


// HOME

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileData data = ProfileData();

  static const Color primary = Color(0xFF6C63FF);

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search, color: Colors.black87),
          ),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, bottom: 24),
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5B5CFF),
                    Color(0xFF9A8BFF),
                  ],
                ),
              ),
              child: const Text(
                'Menu Utama',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Upload Pengalaman'),
              onTap: () async {
                Navigator.pop(context);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditPengalamanScreen(
                      onSaved: refresh,
                    ),
                  ),
                );

                refresh();
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: primary.withOpacity(0.15),
                    backgroundImage: data.fotoProfil != null
                        ? MemoryImage(data.fotoProfil!)
                        : null,
                    child: data.fotoProfil == null
                        ? const Icon(
                      Icons.person,
                      size: 45,
                      color: primary,
                    )
                        : null,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    data.nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    data.bio,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      stat('${data.post}', 'Post'),
                      garis(),
                      stat('${data.teman}', 'Teman'),
                      garis(),
                      stat('${data.like}K', 'Like'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // INFO
            boxPutih(
              child: Column(
                children: [
                  info(Icons.info, Colors.blue, 'Tentang', data.tentang),
                  info(Icons.school, Colors.orange, 'Pendidikan',
                      data.pendidikan),
                  info(Icons.location_on, Colors.red, 'Lokasi', data.lokasi),
                  info(Icons.email, Colors.teal, 'Kontak', data.kontak),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // SKILLS
            boxPutih(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Skills',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: data.skills.map((e) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: primary),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // PENGALAMAN
            boxPutih(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.work, color: primary),
                        const SizedBox(width: 8),
                        const Text(
                          'Pengalaman',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${data.pengalaman.length}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (data.pengalaman.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Belum ada pengalaman',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.pengalaman.length,
                    itemBuilder: (context, index) {
                      final item = data.pengalaman[index];

                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: item.gambar != null
                              ? Image.memory(
                            item.gambar!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image),
                          ),
                        ),
                        title: Text(item.judul),
                        subtitle: Text(item.deskripsi),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFECE8FF),
        foregroundColor: primary,
        elevation: 2,
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditProfileScreen(
                onSaved: refresh,
              ),
            ),
          );

          refresh();
        },
      ),
    );
  }

  Widget garis() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey[300],
    );
  }

  Widget stat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget info(
      IconData icon,
      Color warna,
      String title,
      String subtitle,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: warna.withOpacity(0.15),
        child: Icon(icon, color: warna),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget boxPutih({
    required Widget child,
    EdgeInsets? padding,
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      color: Colors.white,
      child: child,
    );
  }
}

// EDIT PROFILE

class EditProfileScreen extends StatefulWidget {
  final VoidCallback? onSaved;

  const EditProfileScreen({
    super.key,
    this.onSaved,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileData data = ProfileData();

  static const Color primary = Color(0xFF6C63FF);

  late TextEditingController nama;
  late TextEditingController bio;
  late TextEditingController tentang;
  late TextEditingController pendidikan;
  late TextEditingController lokasi;
  late TextEditingController kontak;
  late TextEditingController skills;

  Uint8List? image;

  @override
  void initState() {
    super.initState();

    nama = TextEditingController(text: data.nama);
    bio = TextEditingController(text: data.bio);
    tentang = TextEditingController(text: data.tentang);
    pendidikan = TextEditingController(text: data.pendidikan);
    lokasi = TextEditingController(text: data.lokasi);
    kontak = TextEditingController(text: data.kontak);
    skills = TextEditingController(
      text: data.skills.join(', '),
    );

    image = data.fotoProfil;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      setState(() {
        image = bytes;
      });
    }
  }

  void simpan() {
    data.nama = nama.text;
    data.bio = bio.text;
    data.tentang = tentang.text;
    data.pendidikan = pendidikan.text;
    data.lokasi = lokasi.text;
    data.kontak = kontak.text;

    data.skills = skills.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    data.fotoProfil = image;

    widget.onSaved?.call();

    Navigator.pop(context);
  }

  Widget field(
      TextEditingController controller,
      String label,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profil',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor:
                    primary.withOpacity(0.15),

                    backgroundImage: image != null
                        ? MemoryImage(image!)
                        : null,

                    child: image == null
                        ? const Icon(
                      Icons.person,
                      size: 50,
                      color: primary,
                    )
                        : null,
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              field(nama, 'Nama'),
              field(bio, 'Bio'),
              field(tentang, 'Tentang'),
              field(pendidikan, 'Pendidikan'),
              field(lokasi, 'Lokasi'),
              field(kontak, 'Kontak'),
              field(
                skills,
                'Skills (pisahkan koma)',
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: simpan,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),

                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// EDIT PENGALAMAN

class EditPengalamanScreen extends StatefulWidget {
  final VoidCallback? onSaved;

  const EditPengalamanScreen({
    super.key,
    this.onSaved,
  });

  @override
  State<EditPengalamanScreen> createState() =>
      _EditPengalamanScreenState();
}

class _EditPengalamanScreenState
    extends State<EditPengalamanScreen> {
  final ProfileData data = ProfileData();

  static const Color primary = Color(0xFF6C63FF);

  final judul = TextEditingController();
  final deskripsi = TextEditingController();

  Uint8List? image;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      setState(() {
        image = bytes;
      });
    }
  }

  void simpan() {
    data.pengalaman.add(
      PengalamanItem(
        gambar: image,
        judul: judul.text,
        deskripsi: deskripsi.text,
      ),
    );

    widget.onSaved?.call();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Upload Pengalaman',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.memory(
                    image!,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 50,
                      color: primary,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ketuk untuk pilih gambar',
                      style: TextStyle(color: primary),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: judul,
                    decoration: const InputDecoration(
                      labelText: 'Judul',
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: deskripsi,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: simpan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      child: const Text(
                        'Simpan Pengalaman',
                        style: TextStyle(color: Colors.white),
                      ),
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