'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { initDashboardPage } from '../../../src/dashboard';
import { html } from '../../../src/html/dashboard-crystal';

export default function DashboardCrystalClient() {
  const router = useRouter();

  useEffect(() => {
    const cleanup = initDashboardPage(router);
    return () => {
      if (cleanup) cleanup();
    };
  }, [router]);

  return <div dangerouslySetInnerHTML={{ __html: html }} />;
}
