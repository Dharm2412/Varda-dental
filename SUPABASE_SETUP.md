# Supabase Setup Guide for Varda Dental Clinic

## Step 1: Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign up/login
2. Click "New Project"
3. Choose your organization
4. Enter project details:
   - Name: `varda-dental-clinic`
   - Database Password: (create a strong password)
   - Region: Choose closest to your users
5. Click "Create new project"

## Step 2: Get Environment Variables

1. In your Supabase dashboard, go to **Settings** → **API**
2. Copy the following values:
   - **Project URL** (starts with `https://`)
   - **anon public** key (starts with `eyJ`)

## Step 3: Create Environment File

Create a `.env.local` file in your project root with:

```env
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=your_project_url_here
NEXT_PUBLIC_ANON_KEY=your_anon_key_here
```

## Step 4: Set Up Database Table

1. In Supabase dashboard, go to **SQL Editor**
2. Copy and paste the contents of `supabase-setup.sql`
3. Click "Run" to execute the SQL

## Step 5: Configure Row Level Security (RLS)

The SQL script automatically sets up RLS policies. For public access (no authentication required), you can modify the policies:

```sql
-- Allow public inserts (no authentication required)
DROP POLICY IF EXISTS "Allow authenticated users to insert appointments" ON appointments;
CREATE POLICY "Allow public to insert appointments" ON appointments
  FOR INSERT WITH CHECK (true);

-- Allow public to view appointments (optional, for admin access)
DROP POLICY IF EXISTS "Allow authenticated users to view appointments" ON appointments;
CREATE POLICY "Allow public to view appointments" ON appointments
  FOR SELECT USING (true);
```

## Step 6: Test the Integration

1. Start your development server: `npm run dev`
2. Fill out the contact form and submit
3. Check your Supabase dashboard → **Table Editor** → **appointments** to see the data

## Database Schema

The `appointments` table has the following structure:

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key, auto-generated |
| first_name | TEXT | Customer's first name |
| last_name | TEXT | Customer's last name |
| email | TEXT | Customer's email address |
| phone | TEXT | Customer's phone number |
| service | TEXT | Requested dental service |
| message | TEXT | Additional message (optional) |
| created_at | TIMESTAMP | When the appointment was created |
| updated_at | TIMESTAMP | When the appointment was last updated |

## Features

✅ **Database Storage**: All form submissions are stored in Supabase database  
✅ **Error Handling**: Graceful fallback if Supabase is not configured  
✅ **Security**: Row Level Security enabled with proper policies  
✅ **Performance**: Indexed columns for better query performance  
✅ **Validation**: Form validation before submission  
✅ **Real-time**: Data appears immediately in Supabase dashboard  

## Troubleshooting

### "Supabase environment variables not found"
- Check that your `.env.local` file exists and has correct values
- Restart your development server after adding environment variables

### "Database error. Please try again."
- Check Supabase dashboard for any RLS policy issues
- Verify the `appointments` table exists
- Check browser console for detailed error messages

### "Permission denied"
- Ensure RLS policies allow public inserts
- Check if you're using the correct API keys

### "Database not configured"
- Make sure Supabase environment variables are set correctly
- Verify the Supabase client is properly initialized 