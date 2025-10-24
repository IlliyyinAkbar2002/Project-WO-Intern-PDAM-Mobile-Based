# API Employee/Pegawai Null Data - Debugging Guide

## Problem Summary
Users were showing as "null null" in the app because the `employee` data (name and nip) wasn't being parsed correctly.

## Root Causes Identified

1. **API Response Structure Mismatch**: The code expected one structure but the API might be returning another
2. **Key Name Mismatch**: The EmployeeModel expected specific key names ('nama', 'nip') but the API might use different ones
3. **Insufficient Error Logging**: Not enough debug information to identify the exact issue

## Changes Made

### 1. Enhanced `user_remote_data_source.dart`
- **Added comprehensive logging** to show:
  - Raw API response
  - Response type and structure
  - Each item's keys and values
  - Parsed results
- **Added flexible parsing logic** that handles:
  - User objects with nested 'pegawai' field (as Laravel comment suggests)
  - Direct pegawai objects that need to be wrapped
- **Better error handling** with detailed error messages

### 2. Improved `employee_model.dart`
- **Added support for multiple key name variations**:
  - Name: `nama`, `name`, `full_name`, `nama_lengkap`
  - NIP: `nip`, `employee_id`, `employee_number`
  - ID: `id`, `pegawai_id`
- **Added warning logs** when expected fields are missing
- **Added detailed logging** of extracted values

## Current Endpoint
The app correctly uses `/pegawai` endpoint (not `/employees` as mentioned).

From your Laravel routes:
```php
// Pegawai route - returns users with nested employee data
Route::get('pegawai', [PegawaiController::class, 'index']);
```

## Expected API Response Structure

### Option 1: User with Nested Pegawai (Recommended)
```json
[
  {
    "id": 1,
    "pegawai_id": 1,
    "email": "user@example.com",
    "role_id": 2,
    "pegawai": {
      "id": 1,
      "nama": "John Doe",
      "nip": "12345"
    }
  }
]
```

### Option 2: Direct Pegawai Objects
```json
[
  {
    "id": 1,
    "nama": "John Doe",
    "nip": "12345",
    "email": "user@example.com",
    "role_id": 2
  }
]
```

The Flutter code now handles both structures automatically.

## Next Steps to Debug

1. **Run the app again** and trigger the user list load
2. **Check the console logs** for these key indicators:

   ```
   📥 Raw response from /pegawai: [...]
   📥 Response type: List<dynamic>
   📥 First item keys: [id, nama, nip, ...]
   🔧 EmployeeModel.fromMap keys: [id, nama, nip, ...]
   🔧 Extracted values - id: 1, nama: John Doe, nip: 12345
   ```

3. **Identify the issue**:
   - If you see `⚠️ WARNING: Could not find name field`, the API is using different key names
   - If you see `❌ Error fetching pegawai`, there's a network or parsing error
   - If values are null, check if the API is returning empty/null data

4. **Fix the Laravel API** if needed:
   - Ensure the PegawaiController returns the correct structure
   - Verify database has the required fields ('nama', 'nip')
   - Check that relationships are loaded correctly

## Laravel Controller Verification

Check your `PegawaiController@index` method. It should return something like:

```php
public function index()
{
    // Option 1: Return users with nested pegawai
    return User::with('pegawai')->get();
    
    // Option 2: Return pegawai directly
    return Pegawai::all();
}
```

## Testing Checklist

- [ ] Run the app
- [ ] Check console logs for API response structure
- [ ] Verify the API returns data (not empty array)
- [ ] Confirm field names match ('nama', 'nip', or alternatives)
- [ ] Verify users are displayed correctly (not "null null")
- [ ] Test search functionality works

## If You Want to Use `/employees` Instead

If you want to use `/employees` endpoint:

1. **Add the route in Laravel** (`routes/api.php`):
```php
Route::get('employees', [PegawaiController::class, 'index']);
```

2. **Update Flutter code** (`user_remote_data_source.dart` line 12):
```dart
final response = await get(path: '/employees');
```

## Common Issues

1. **Database field names**: If your database uses English field names (like 'name' instead of 'nama'), the code now handles this automatically
2. **Missing relationships**: Ensure Laravel loads the 'pegawai' relationship if using nested structure
3. **Null values in database**: Check if the actual database records have values for nama and nip fields
4. **Authentication**: Ensure the token is valid and has permission to access /pegawai

## Contact Points for Further Help

Share the following from your logs:
1. `📥 First item keys: [...]` - Shows what the API actually returns
2. `🔧 Extracted values - ...` - Shows what was parsed
3. Any `⚠️ WARNING` or `❌ Error` messages

