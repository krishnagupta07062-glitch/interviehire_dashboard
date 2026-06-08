'use client';

import { useEffect } from 'react';
import { initDashboardPage } from '../../../src/dashboard';
import { html } from '../../../src/html/dashboard-crystal';

export default function DashboardClient() {
  useEffect(() => {
    // Pass null — URL is updated via window.history.pushState directly,
    // so Next.js router is not needed and should NOT be a dependency
    // (router object reference changes on every render which would re-initialize the whole dashboard)
    const cleanup = initDashboardPage(null);
    return () => {
      if (cleanup) cleanup();
    };
  }, []); // Empty dep array: run once on mount, cleanup on unmount

  return <div dangerouslySetInnerHTML={{ __html: html }} />;
}
