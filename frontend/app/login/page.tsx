import {Suspense} from 'react';
import AuthForm from '@/components/AuthForm';
export default function Login(){return <Suspense fallback={<div className="container-main py-20">Loading...</div>}><AuthForm mode="login"/></Suspense>}
