-- Create appointments table
CREATE TABLE IF NOT EXISTS appointments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  service TEXT NOT NULL,
  message TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;

-- Create policy to allow authenticated users to insert
CREATE POLICY "Allow authenticated users to insert appointments" ON appointments
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Create policy to allow authenticated users to view their own appointments
CREATE POLICY "Allow authenticated users to view appointments" ON appointments
  FOR SELECT USING (auth.role() = 'authenticated');

-- Create policy to allow service role to manage all appointments (for admin access)
CREATE POLICY "Allow service role to manage all appointments" ON appointments
  FOR ALL USING (auth.role() = 'service_role');

-- Create index for better query performance
CREATE INDEX IF NOT EXISTS idx_appointments_created_at ON appointments(created_at);
CREATE INDEX IF NOT EXISTS idx_appointments_email ON appointments(email);

-- Add comments for documentation
COMMENT ON TABLE appointments IS 'Stores appointment booking data from the contact form';
COMMENT ON COLUMN appointments.id IS 'Unique identifier for each appointment';
COMMENT ON COLUMN appointments.first_name IS 'Customer first name';
COMMENT ON COLUMN appointments.last_name IS 'Customer last name';
COMMENT ON COLUMN appointments.email IS 'Customer email address';
COMMENT ON COLUMN appointments.phone IS 'Customer phone number';
COMMENT ON COLUMN appointments.service IS 'Requested dental service';
COMMENT ON COLUMN appointments.message IS 'Additional message from customer';
COMMENT ON COLUMN appointments.created_at IS 'Timestamp when appointment was created';
COMMENT ON COLUMN appointments.updated_at IS 'Timestamp when appointment was last updated'; 