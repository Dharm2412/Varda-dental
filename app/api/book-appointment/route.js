function validateAppointmentData(data) {
  const requiredFields = ["firstName", "lastName", "email", "phone", "service", "message"];
  for (const field of requiredFields) {
    if (!data[field] || typeof data[field] !== "string" || !data[field].trim()) {
      return `Missing or invalid field: ${field}`;
    }
  }
  return null;
}

export async function POST(req) {
  try {
    const data = await req.json();
    console.log("Received appointment data:", data);
    
    const validationError = validateAppointmentData(data);
    if (validationError) {
      console.log("Validation error:", validationError);
      return new Response(JSON.stringify({ success: false, error: validationError }), { 
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    // Data is already stored in Supabase from the frontend
    // This API route now just validates the data
    return new Response(JSON.stringify({ 
      success: true, 
      message: "Appointment booked successfully! We'll contact you soon." 
    }), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
    
  } catch (error) {
    console.error("Book Appointment API Error:", error);
    return new Response(JSON.stringify({ 
      success: false, 
      error: "Internal server error. Please try again." 
    }), { 
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
} 