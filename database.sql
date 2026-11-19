CREATE DATABASE IF NOT EXISTS sekolah
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sekolah;

CREATE TABLE IF NOT EXISTS siswa (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nisn VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(150) NOT NULL,
    kelas VARCHAR(100) NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'aktif',
    tempat_tinggal VARCHAR(255) NULL,
    tanggal_lahir DATE NULL,
    foto_profile VARCHAR(255) NULL,
    INDEX idx_siswa_kelas (kelas)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    username_custom VARCHAR(30) NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'siswa',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS jadwal (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    minggu INT UNSIGNED NOT NULL,
    hari VARCHAR(10) NOT NULL,
    jam_ke INT UNSIGNED NULL,
    waktu VARCHAR(50) NOT NULL DEFAULT '',
    kelas VARCHAR(100) NOT NULL,
    mata_pelajaran VARCHAR(150) NOT NULL DEFAULT '',
    guru VARCHAR(150) NOT NULL DEFAULT '',
    kode_guru VARCHAR(50) NOT NULL DEFAULT '',
    INDEX idx_jadwal_kelas_minggu (kelas, minggu),
    INDEX idx_jadwal_guru (guru)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS wali_kelas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    kelas VARCHAR(100) NOT NULL UNIQUE,
    guru VARCHAR(150) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- Akun demo: username admin, password AdminDemo!123
INSERT INTO users (username, password, role)
SELECT
    'admin',
    '$2y$10$i7wBL.uUTQ.Y4vkMAyhY2eHWvLrJ6LxLvHtp8SiyhnAGiyYQeidXy',
    'admin'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE username = 'admin'
);

-- Data demo siswa; NISN contoh ini bukan NISN sungguhan.
INSERT INTO siswa (nisn, nama, kelas, status)
SELECT '0000000001', 'Siswa Contoh', 'X PPL 1', 'aktif'
WHERE NOT EXISTS (
    SELECT 1 FROM siswa WHERE nisn = '0000000001'
);

-- Akun demo siswa: username/NISN 0000000001, username alternatif siswa_demo,
-- password SiswaDemo!123. Hapus atau ganti akun demo sebelum produksi.
INSERT INTO users (username, username_custom, password, role)
SELECT
    '0000000001',
    'siswa_demo',
    '$2y$10$4BHritFaTR0l4Etu2Ec3XOpa1rpSItc8wbZAXOLzYNoQbPO9xGc6W',
    'siswa'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE username = '0000000001'
);
