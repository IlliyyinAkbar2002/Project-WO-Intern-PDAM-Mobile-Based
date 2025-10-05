import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseConfig {
  // PostgreSQL connection configuration
  static String get host => dotenv.env['DB_HOST'] ?? 'localhost';
  static String get database => dotenv.env['DB_NAME'] ?? 'work_order_database';
  static String get username => dotenv.env['DB_USERNAME'] ?? 'postgres';
  static String get password => dotenv.env['DB_PASSWORD'] ?? 'your_password';
  static int get port => int.tryParse(dotenv.env['DB_PORT'] ?? '5432') ?? 5432;

  static void logConfig() {
    print('🔌 Database Config:');
    print('   Host: $host');
    print('   Database: $database');
    print('   Username: $username');
    print('   Port: $port');
  }
}
