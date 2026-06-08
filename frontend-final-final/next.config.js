/** @type {import('next').NextConfig} */
const nextConfig = {
  // Disable React StrictMode to prevent double-mount in development.
  // The dashboard is an imperative SPA initialized via useEffect and is NOT
  // idempotent — double-mounting causes duplicate event listeners and broken state.
  reactStrictMode: false,

  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'http://127.0.0.1:8000/api/:path*',
      },
      {
        source: '/ws',
        destination: 'http://127.0.0.1:8000/ws',
      },
    ];
  },
};

export default nextConfig;
