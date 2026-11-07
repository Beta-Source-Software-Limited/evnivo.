import {Suspense} from 'react';
import AuthForm from '@/components/AuthForm';
export default function Register(){return <Suspense fallback={<div className="container-main py-20">Loading...</div>}><AuthForm mode="register"/></Suspense>}
