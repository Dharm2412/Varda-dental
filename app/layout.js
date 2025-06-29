import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
});

export const metadata = {
  title: "Varda Dental Clinic - Professional Dental Care",
  description: "Varda Dental Clinic provides comprehensive dental care services with state-of-the-art technology and experienced professionals. Book your appointment today for a healthy, beautiful smile.",
  keywords: "dental clinic, dental care, dentist, oral health, dental services, Varda Dental",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={`${inter.variable} font-sans antialiased`}>
        {children}
      </body>
    </html>
  );
}
