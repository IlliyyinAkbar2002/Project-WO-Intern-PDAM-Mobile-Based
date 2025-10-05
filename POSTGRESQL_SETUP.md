# PostgreSQL Setup Guide

This application now uses PostgreSQL instead of SQLite for local data storage.

## Prerequisites

1. Install PostgreSQL on your system
   - **Windows**: Download from [postgresql.org](https://www.postgresql.org/download/windows/)
   - **macOS**: `brew install postgresql`
   - **Linux**: `sudo apt-get install postgresql postgresql-contrib`

2. Start PostgreSQL service
   - **Windows**: Service starts automatically after installation
   - **macOS**: `brew services start postgresql`
   - **Linux**: `sudo systemctl start postgresql`

## Database Setup

1. Create a new database:
```sql
CREATE DATABASE work_order_database;
```

2. Create a user (optional, if not using default postgres user):
```sql
CREATE USER your_username WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE work_order_database TO your_username;
```

## Configuration

Add the following environment variables to your `.env` file:

```env
# PostgreSQL Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=work_order_database
DB_USERNAME=postgres
DB_PASSWORD=your_password
```

### Configuration Options:

- `DB_HOST`: PostgreSQL server host (default: `localhost`)
- `DB_PORT`: PostgreSQL server port (default: `5432`)
- `DB_NAME`: Database name (default: `work_order_database`)
- `DB_USERNAME`: Database username (default: `postgres`)
- `DB_PASSWORD`: Database password (default: `your_password`)

## What Changed?

### Files Modified:

1. **`lib/feature/work_order/data/data_source/local/work_order_local_data_source.dart`**
   - Replaced `sqflite` package with `postgres`
   - Updated all CRUD operations to use PostgreSQL syntax
   - Changed from `Database` to `Connection` type

2. **`lib/service_locator.dart`**
   - Removed SQLite initialization
   - Added PostgreSQL connection setup
   - Auto-creates `work_orders` table on startup
   - Changed dependency injection from `Database` to `Connection`

3. **`lib/config/database_config.dart`** (NEW)
   - Centralized database configuration
   - Loads credentials from `.env` file
   - Provides default values for development

## Testing the Connection

1. Update your `.env` file with correct credentials
2. Run the application: `flutter run`
3. Check the console output for:
   ```
   🔌 Database Config:
      Host: localhost
      Database: work_order_database
      Username: postgres
      Port: 5432
   ✅ Work Orders table created/verified
   ✅ PostgreSQL Database terdaftar
   ```

## Production Considerations

For production deployment:

1. **Enable SSL**: Change `SslMode.disable` to `SslMode.require` in `service_locator.dart`
2. **Use environment variables**: Never commit `.env` with real credentials
3. **Connection pooling**: Consider using connection pooling for better performance
4. **Remote database**: Update `DB_HOST` to your production database server

## Troubleshooting

### Connection Failed
- Check if PostgreSQL service is running
- Verify database credentials in `.env`
- Ensure the database exists
- Check firewall settings

### Table Creation Errors
- The app automatically creates the `work_orders` table
- If you see warnings about table already existing, that's normal
- To reset the database, drop and recreate it:
  ```sql
  DROP DATABASE work_order_database;
  CREATE DATABASE work_order_database;
  ```

### Migration from SQLite
If you had data in SQLite and want to migrate:
1. Export your SQLite data
2. Transform the data format if needed
3. Import into PostgreSQL using SQL INSERT statements or pg_dump

## Additional Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [postgres Dart Package](https://pub.dev/packages/postgres)
- [Flutter + PostgreSQL Tutorial](https://flutter.dev)
