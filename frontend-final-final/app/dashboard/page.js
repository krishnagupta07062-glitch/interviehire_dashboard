'use client';

import { useEffect } from 'react';
import { initDashboardPage } from '../../src/dashboard';
import { html } from '../../src/html/dashboard-crystal';

export default function DashboardPage() {
  useEffect(() => {
    const cleanup = initDashboardPage();
    return () => {
      if (cleanup) cleanup();
    };
  }, []);

  return <div dangerouslySetInnerHTML={{ __html: html }} />;
}
