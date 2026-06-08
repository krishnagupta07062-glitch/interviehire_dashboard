'use client';

import dynamic from 'next/dynamic';

const DashboardCrystalClient = dynamic(() => import('./DashboardCrystalClient'), {
  ssr: false,
});

export default function DashboardCrystalPage() {
  return <DashboardCrystalClient />;
}

