/** @type {import('next').NextConfig} */
const nextConfig = {
  // Disable React StrictMode to prevent double-mount in development.
  // The dashboard is an imperative SPA initialized via useEffect and is NOT
  // idempotent — double-mounting causes duplicate event listeners and broken state.
  reactStrictMode: false,

  async rewrites() {
    const backendUrl = process.env.NEXT_PUBLIC_API_URL || 'http://127.0.0.1:8000';
    return [
      {
        source: '/api/:path*',
        destination: `${backendUrl}/api/:path*`,
      },
    ];
  },
};

export default nextConfig;
