import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// = MODEL =

class Catatan {
  final String id; // butuh id unik buat update di list
  final String judul;
  final String isi;
  final String kategori;
  final String email; // field email pengirim
  final DateTime dibuatPada;

  Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });

  // helper copyWith agar mudah membuat salinan dengan perubahan
  Catatan copyWith({
    String? judul,
    String? isi,
    String? kategori,
    String? email,
  }) {
    return Catatan(
      id: id, // id tidak pernah berubah
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      kategori: kategori ?? this.kategori,
      email: email ?? this.email,
      dibuatPada: dibuatPada, // tanggal tidak berubah saat edit
    );
  }
}

// = APP =

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Mahasiswa',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
        // tambah sekarang menerima argumen opsional (Catatan?)
        //   kalau null  → mode Tambah
        //   kalau isi   → mode Edit
          case '/tambah':
            final catatanAwal = settings.arguments as Catatan?;
            return MaterialPageRoute(
              builder: (_) => TambahCatatanPage(catatanAwal: catatanAwal),
            );

          case '/detail':
            final catatan = settings.arguments as Catatan;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan),
            );
        }
        return null;
      },
    );
  }
}

// = HOME PAGE =

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Catatan> _catatan = [
    Catatan(
      id: '0',
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      email: 'mahasiswa@kampus.ac.id',
      dibuatPada: DateTime.now(),
    ),
  ];

  // TUGAS 2: state untuk filter kategori
  String _filterKategori = 'Semua';

  // ← TUGAS 2: getter yang mengembalikan list sudah difilter
  List<Catatan> get _catatanTerfilter {
    if (_filterKategori == 'Semua') return _catatan;
    return _catatan.where((c) => c.kategori == _filterKategori).toList();
  }

  // Navigasi ke halaman Tambah (tanpa argumen = mode Tambah)
  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');

    if (hasil is Catatan && mounted) {
      setState(() => _catatan.add(hasil));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" ditambahkan')),
      );
    }
  }

  // navigasi ke Detail, lalu tangkap hasil edit jika ada
  Future<void> _bukaDetailCatatan(Catatan c) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/detail',
      arguments: c,
    );

    // Detail mengembalikan Catatan yang sudah diedit
    if (hasil is Catatan && mounted) {
      setState(() {
        final idx = _catatan.indexWhere((item) => item.id == hasil.id);
        if (idx != -1) _catatan[idx] = hasil;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" diperbarui')),
      );
    }
  }

  void _hapusCatatan(Catatan c) {
    setState(() => _catatan.remove(c));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Catatan "${c.judul}" dihapus')),
    );
  }

  String _formatTanggal(DateTime t) => '${t.day}/${t.month}/${t.year}';

  @override
  Widget build(BuildContext context) {
    final terfilter = _catatanTerfilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),
        // dropdown filter di AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButton<String>(
              value: _filterKategori,
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(8),
              icon: const Icon(Icons.filter_list),
              items: const ['Semua', 'Kuliah', 'Tugas', 'Pribadi', 'Lainnya']
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _filterKategori = v!),
            ),
          ),
        ],
      ),
      body: terfilter.isEmpty
          ? _EmptyState(isFiltered: _filterKategori != 'Semua')
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: terfilter.length,
        itemBuilder: (context, i) {
          final c = terfilter[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                c.judul,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(c.kategori),
                  const SizedBox(height: 4),
                  Text(
                    _formatTanggal(c.dibuatPada),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _hapusCatatan(c),
              ),
              onTap: () => _bukaDetailCatatan(c),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// = EMPTY STATE =

class _EmptyState extends StatelessWidget {
  // bedakan pesan saat filter aktif vs memang kosong
  final bool isFiltered;
  const _EmptyState({this.isFiltered = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFiltered ? Icons.filter_list_off : Icons.note_alt_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            isFiltered
                ? 'Tidak ada catatan dengan kategori ini'
                : 'Belum ada catatan',
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// = EDIT DAN TAMBAH CATATAN PAGE =

class TambahCatatanPage extends StatefulWidget {
  // parameter opsional; null = Tambah, isi = Edit
  final Catatan? catatanAwal;

  const TambahCatatanPage({super.key, this.catatanAwal});

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _judulCtrl;
  late final TextEditingController _isiCtrl;
  late final TextEditingController _emailCtrl; // ← TUGAS 3
  late String _kategori;

  // helper untuk tahu apakah ini mode edit
  bool get _isEditMode => widget.catatanAwal != null;

  @override
  void initState() {
    super.initState();
    // kalau edit mode, isi controller dengan data lama
    _judulCtrl = TextEditingController(text: widget.catatanAwal?.judul ?? '');
    _isiCtrl   = TextEditingController(text: widget.catatanAwal?.isi ?? '');
    _emailCtrl = TextEditingController(text: widget.catatanAwal?.email ?? '');
    _kategori  = widget.catatanAwal?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose(); // jangan lupa dispose controller baru
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    late final Catatan hasil;

    if (_isEditMode) {
      // mode Edit unakan copyWith agar id & dibuatPada tetap sama
      hasil = widget.catatanAwal!.copyWith(
        judul: _judulCtrl.text.trim(),
        isi: _isiCtrl.text.trim(),
        kategori: _kategori,
        email: _emailCtrl.text.trim(),
      );
    } else {
      // Mode Tambah buat objek baru dengan id unik dari timestamp
      hasil = Catatan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        judul: _judulCtrl.text.trim(),
        isi: _isiCtrl.text.trim(),
        kategori: _kategori,
        email: _emailCtrl.text.trim(),
        dibuatPada: DateTime.now(),
      );
    }

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // judul berubah sesuai mode
        title: Text(_isEditMode ? 'Edit Catatan' : 'Tambah Catatan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- Field Judul ---
            TextFormField(
              controller: _judulCtrl,
              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // --- Dropdown Kategori ---
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya']
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),

            // --- Field Isi ---
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Isi wajib diisi';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Field Email dengan validasi regex
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Pengirim',
                hintText: 'contoh@email.com',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Email wajib diisi';
                }
                // Regex: local-part @ domain . ekstensi (min 2 huruf)
                final emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
                );
                if (!emailRegex.hasMatch(v.trim())) {
                  return 'Format email tidak valid (contoh: nama@gmail.com)';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // --- Tombol Simpan ---
            FilledButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save),
              // label tombol berubah sesuai mode
              label: Text(_isEditMode ? 'Simpan Perubahan' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// = DETAIL PAGE =

class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;

  const DetailCatatanPage({super.key, required this.catatan});

  String _formatTanggal(DateTime t) => '${t.day}/${t.month}/${t.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        // tombol Edit di AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Catatan',
            onPressed: () async {
              // Buka TambahCatatanPage dengan catatan ini sebagai argumen (mode Edit)
              final hasil = await Navigator.pushNamed(
                context,
                '/tambah',
                arguments: catatan,
              );

              // Kalau ada hasil edit, teruskan ke HomePage via pop
              if (hasil is Catatan && context.mounted) {
                Navigator.pop(context, hasil);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              catatan.judul,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Chip(label: Text(catatan.kategori)),
            const SizedBox(height: 8),
            // tampilkan email di detail
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  catatan.email,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Dibuat pada: ${_formatTanggal(catatan.dibuatPada)}',
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32),
            Text(
              catatan.isi,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}