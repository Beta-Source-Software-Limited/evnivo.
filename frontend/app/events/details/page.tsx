import { Suspense } from 'react';
import EventDetails from './EventDetails';

export default function EventDetailsPage() {
  return <Suspense fallback={<div className="container-main py-20 text-muted">Loading event...</div>}><EventDetails /></Suspense>;
}
