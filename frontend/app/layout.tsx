import type {Metadata} from 'next';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import './globals.css';
export const metadata:Metadata={title:'EVNIVO | Discover Moments. Book Experiences.',description:'Modern event discovery and ticket booking platform demo.'};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="en"><body><Navbar/><main className="min-h-[70vh]">{children}</main><Footer/></body></html>}
