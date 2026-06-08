'use client';

import dynamic from 'next/dynamic';

const DashboardGlassClient = dynamic(() => import('./DashboardGlassClient'), {
  ssr: false,
});

export default function DashboardGlassPage() {
  return <DashboardGlassClient />;
}

