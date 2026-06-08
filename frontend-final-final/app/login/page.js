'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

export default function LoginPage() {
  const router = useRouter();
  const [formData, setFormData] = useState({ email: '', password: '' });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function handleLogin(e) {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      const res = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify(formData),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.detail || 'Login failed. Please try again.');
        return;
      }
      if (data.onboarding_required) {
        router.push('/onboarding');
      } else {
        router.push('/dashboard');
      }
    } catch (err) {
      setError('Network error. Is the backend running?');
    } finally {
      setLoading(false);
    }
  }

  return (
    <>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Inter:wght@400;500;600&display=swap');

        * { box-sizing: border-box; margin: 0; padding: 0; }

        .auth-page {
          min-height: 100vh;
          background: #0a0a0a;
          display: flex;
          align-items: center;
          justify-content: center;
          font-family: 'Inter', sans-serif;
          position: relative;
          overflow: hidden;
        }

        /* Animated background orbs */
        .auth-orb {
          position: fixed;
          border-radius: 50%;
          filter: blur(140px);
          pointer-events: none;
          z-index: 0;
        }
        .auth-orb-1 {
          width: 500px; height: 500px;
          background: rgba(45, 212, 191, 0.12);
          top: -150px; right: -100px;
          animation: orbFloat1 8s ease-in-out infinite;
        }
        .auth-orb-2 {
          width: 400px; height: 400px;
          background: rgba(100, 160, 220, 0.08);
          bottom: -100px; left: -100px;
          animation: orbFloat2 10s ease-in-out infinite;
        }
        .auth-orb-3 {
          width: 300px; height: 300px;
          background: rgba(45, 212, 191, 0.05);
          top: 50%; left: 50%;
          transform: translate(-50%, -50%);
          animation: orbFloat3 12s ease-in-out infinite;
        }

        @keyframes orbFloat1 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          50% { transform: translate(-30px, 40px) scale(1.05); }
        }
        @keyframes orbFloat2 {
          0%, 100% { transform: translate(0, 0) scale(1); }
          50% { transform: translate(25px, -35px) scale(1.08); }
        }
        @keyframes orbFloat3 {
          0%, 100% { transform: translate(-50%, -50%) scale(1); }
          50% { transform: translate(-50%, -50%) scale(1.15); }
        }

        /* Grid overlay */
        .auth-grid {
          position: fixed;
          inset: 0;
          background-image:
            linear-gradient(rgba(255,255,255,0.012) 1px, transparent 1px),
            linear-gradient(90deg, rgba(255,255,255,0.012) 1px, transparent 1px);
          background-size: 60px 60px;
          pointer-events: none;
          z-index: 0;
        }

        /* Card */
        .auth-card-wrap {
          position: relative;
          z-index: 10;
          width: 100%;
          max-width: 440px;
          padding: 20px;
        }

        .auth-card {
          background: rgba(10, 10, 14, 0.78);
          backdrop-filter: blur(30px);
          -webkit-backdrop-filter: blur(30px);
          border: 1px solid rgba(45, 212, 191, 0.15);
          border-radius: 24px;
          padding: 44px 40px 40px;
          box-shadow:
            0 0 0 1px rgba(255,255,255,0.03) inset,
            0 30px 60px -20px rgba(0,0,0,0.8),
            0 0 80px -20px rgba(45, 212, 191, 0.08);
          transition: box-shadow 0.4s ease;
        }

        .auth-card:hover {
          box-shadow:
            0 0 0 1px rgba(255,255,255,0.05) inset,
            0 40px 80px -20px rgba(0,0,0,0.9),
            0 0 100px -20px rgba(100, 160, 220, 0.12);
        }

        /* Logo */
        .auth-logo {
          display: flex;
          align-items: center;
          gap: 10px;
          margin-bottom: 32px;
          text-decoration: none;
        }
        .auth-logo-dot {
          width: 10px; height: 10px;
          border-radius: 50%;
          background: linear-gradient(135deg, #2dd4bf, #64a0dc);
          box-shadow: 0 0 12px rgba(45, 212, 191, 0.6);
          flex-shrink: 0;
        }
        .auth-logo-text {
          font-family: 'Outfit', sans-serif;
          font-weight: 800;
          font-size: 1.3rem;
          background: linear-gradient(135deg, #ffffff 30%, #2dd4bf 100%);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
          letter-spacing: -0.02em;
        }

        /* Heading */
        .auth-heading {
          font-family: 'Outfit', sans-serif;
          font-size: 1.85rem;
          font-weight: 800;
          color: #fafaf7;
          letter-spacing: -0.03em;
          margin-bottom: 6px;
          line-height: 1.2;
        }
        .auth-subtext {
          font-size: 0.88rem;
          color: #6b6b66;
          margin-bottom: 32px;
          font-weight: 500;
        }

        /* Form */
        .auth-form { display: flex; flex-direction: column; gap: 16px; }

        .auth-field { display: flex; flex-direction: column; gap: 7px; }

        .auth-label {
          font-size: 0.8rem;
          font-weight: 600;
          color: #a3a39e;
          letter-spacing: 0.04em;
          text-transform: uppercase;
        }

        .auth-input {
          background: rgba(255, 255, 255, 0.04);
          border: 1px solid rgba(45, 212, 191, 0.15);
          border-radius: 12px;
          padding: 13px 16px;
          color: #fafaf7;
          font-size: 0.95rem;
          font-family: 'Inter', sans-serif;
          outline: none;
          transition: border-color 0.25s ease, background 0.25s ease, box-shadow 0.25s ease;
          width: 100%;
        }
        .auth-input::placeholder { color: #4a4a46; }
        .auth-input:focus {
          border-color: rgba(45, 212, 191, 0.5);
          background: rgba(45, 212, 191, 0.04);
          box-shadow: 0 0 0 3px rgba(45, 212, 191, 0.08), 0 0 20px -5px rgba(45, 212, 191, 0.15);
        }
        .auth-input:hover:not(:focus) {
          border-color: rgba(45, 212, 191, 0.25);
          background: rgba(255, 255, 255, 0.06);
        }

        /* Error */
        .auth-error {
          background: rgba(255, 13, 63, 0.08);
          border: 1px solid rgba(255, 13, 63, 0.25);
          border-radius: 10px;
          padding: 11px 14px;
          color: #ff6b8a;
          font-size: 0.85rem;
          font-weight: 500;
          display: flex;
          align-items: center;
          gap: 8px;
        }
        .auth-error::before {
          content: '⚠';
          font-size: 0.9rem;
          flex-shrink: 0;
        }

        /* Submit button */
        .auth-btn {
          background: linear-gradient(135deg, #2dd4bf 0%, #64a0dc 100%);
          color: #0a0a0a;
          border: none;
          border-radius: 12px;
          padding: 14px;
          font-family: 'Outfit', sans-serif;
          font-weight: 800;
          font-size: 1rem;
          cursor: pointer;
          transition: transform 0.2s ease, box-shadow 0.3s ease, opacity 0.2s ease;
          margin-top: 4px;
          position: relative;
          overflow: hidden;
          letter-spacing: 0.01em;
        }
        .auth-btn::before {
          content: '';
          position: absolute;
          inset: 0;
          background: linear-gradient(135deg, rgba(255,255,255,0.3) 0%, transparent 100%);
          opacity: 0;
          transition: opacity 0.3s ease;
        }
        .auth-btn:hover:not(:disabled) {
          transform: translateY(-1px);
          box-shadow: 0 8px 25px -5px rgba(45, 212, 191, 0.3), 0 0 30px -10px rgba(100, 160, 220, 0.3);
        }
        .auth-btn:hover::before { opacity: 1; }
        .auth-btn:active:not(:disabled) { transform: translateY(0); }
        .auth-btn:disabled { opacity: 0.6; cursor: not-allowed; }

        /* Loading spinner */
        .btn-spinner {
          display: inline-block;
          width: 16px; height: 16px;
          border: 2px solid rgba(0,0,0,0.3);
          border-top-color: #000;
          border-radius: 50%;
          animation: spin 0.7s linear infinite;
          margin-right: 8px;
          vertical-align: middle;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* Divider */
        .auth-divider {
          display: flex;
          align-items: center;
          gap: 12px;
          margin: 6px 0;
          color: #3a3a36;
          font-size: 0.8rem;
        }
        .auth-divider::before, .auth-divider::after {
          content: '';
          flex: 1;
          height: 1px;
          background: rgba(255,255,255,0.06);
        }

        /* Footer link */
        .auth-footer {
          text-align: center;
          margin-top: 24px;
          font-size: 0.875rem;
          color: #6b6b66;
        }
        .auth-link {
          color: #2dd4bf;
          text-decoration: none;
          font-weight: 600;
          transition: color 0.2s ease;
        }
        .auth-link:hover { color: #5eead4; }

        /* Demo credentials section */
        .demo-creds {
          margin-top: 20px;
          background: rgba(255, 255, 255, 0.02);
          border: 1px solid rgba(255, 255, 255, 0.05);
          border-radius: 12px;
          padding: 16px;
        }
        .demo-creds-title {
          font-size: 0.72rem;
          font-weight: 700;
          text-transform: uppercase;
          letter-spacing: 0.06em;
          color: #4a4a46;
          margin-bottom: 12px;
        }
        .demo-row {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 8px 0;
          border-bottom: 1px solid rgba(255,255,255,0.04);
          cursor: pointer;
          border-radius: 6px;
          transition: background 0.15s ease;
          padding: 7px 8px;
          margin: -7px -8px;
          margin-bottom: 2px;
        }
        .demo-row:last-child { border-bottom: none; margin-bottom: -7px; }
        .demo-row:hover { background: rgba(45, 212, 191, 0.08); }
        .demo-role {
          font-size: 0.78rem;
          font-weight: 700;
          color: #a3a39e;
        }
        .demo-email {
          font-size: 0.75rem;
          color: #64a0dc;
          font-family: monospace;
        }
        .demo-use-btn {
          font-size: 0.7rem;
          color: #4a4a46;
          font-weight: 600;
          background: none;
          border: none;
          cursor: pointer;
          padding: 2px 6px;
          border-radius: 4px;
          transition: color 0.15s ease;
        }
        .demo-row:hover .demo-use-btn { color: #2dd4bf; }
      `}</style>

      <div className="auth-page">
        <div className="auth-grid" />
        <div className="auth-orb auth-orb-1" />
        <div className="auth-orb auth-orb-2" />
        <div className="auth-orb auth-orb-3" />

        <div className="auth-card-wrap">
          <div className="auth-card">
            <Link href="/" className="auth-logo">
              <span className="auth-logo-dot" />
              <span className="auth-logo-text">intervieHire</span>
            </Link>

            <h1 className="auth-heading">Welcome back</h1>
            <p className="auth-subtext">Sign in to your organisation dashboard</p>

            <form className="auth-form" onSubmit={handleLogin}>
              <div className="auth-field">
                <label className="auth-label" htmlFor="email">Email address</label>
                <input
                  id="email"
                  className="auth-input"
                  type="email"
                  placeholder="you@company.com"
                  autoComplete="email"
                  value={formData.email}
                  onChange={e => setFormData(p => ({ ...p, email: e.target.value }))}
                  required
                  suppressHydrationWarning
                />
              </div>

              <div className="auth-field">
                <label className="auth-label" htmlFor="password">Password</label>
                <input
                  id="password"
                  className="auth-input"
                  type="password"
                  placeholder="••••••••"
                  autoComplete="current-password"
                  value={formData.password}
                  onChange={e => setFormData(p => ({ ...p, password: e.target.value }))}
                  required
                  suppressHydrationWarning
                />
              </div>

              {error && <div className="auth-error">{error}</div>}

              <button className="auth-btn" type="submit" disabled={loading}>
                {loading && <span className="btn-spinner" />}
                {loading ? 'Signing in…' : 'Sign in'}
              </button>
            </form>

            <div className="auth-divider">or</div>

            <div className="auth-footer">
              New organisation?{' '}
              <Link href="/signup" className="auth-link">Create an account →</Link>
            </div>

            {/* Demo credentials for testing */}
            <div className="demo-creds">
              <div className="demo-creds-title">🔑 Demo Credentials (click to use)</div>
              {[
                { role: 'Super Admin', email: 'admin@interviehire.com', password: 'adminpassword' },
                { role: 'Org Admin', email: 'devasri@zeko.ai', password: 'orgpassword' },
                { role: 'Member', email: 'aditya@zeko.ai', password: 'memberpassword' },
              ].map(cred => (
                <div
                  key={cred.role}
                  className="demo-row"
                  onClick={() => setFormData({ email: cred.email, password: cred.password })}
                >
                  <span className="demo-role">{cred.role}</span>
                  <span className="demo-email">{cred.email}</span>
                  <button className="demo-use-btn">Use →</button>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
