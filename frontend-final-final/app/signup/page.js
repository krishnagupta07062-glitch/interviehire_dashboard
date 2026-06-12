'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

export default function SignupPage() {
  const router = useRouter();
  const [formData, setFormData] = useState({ name: '', email: '', password: '', confirm: '' });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return <div className="auth-page" style={{ background: '#0a0a0a' }} />;
  }

  async function handleSignup(e) {
    e.preventDefault();
    setError('');

    if (formData.password !== formData.confirm) {
      setError('Passwords do not match.');
      return;
    }
    if (formData.password.length < 8) {
      setError('Password must be at least 8 characters.');
      return;
    }

    setLoading(true);
    try {
      const baseUrl = (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') ? `http://${window.location.hostname}:8000` : '';
      const res = await fetch(`${baseUrl}/api/auth/signup`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({
          name: formData.name,
          email: formData.email,
          password: formData.password,
        }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.detail || 'Signup failed. Please try again.');
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
          padding: 24px 0;
        }

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
          top: -150px; left: -100px;
          animation: orbFloat1 9s ease-in-out infinite;
        }
        .auth-orb-2 {
          width: 400px; height: 400px;
          background: rgba(100, 160, 220, 0.08);
          bottom: -100px; right: -100px;
          animation: orbFloat2 11s ease-in-out infinite;
        }

        @keyframes orbFloat1 {
          0%, 100% { transform: translate(0,0) scale(1); }
          50% { transform: translate(30px, -40px) scale(1.06); }
        }
        @keyframes orbFloat2 {
          0%, 100% { transform: translate(0,0) scale(1); }
          50% { transform: translate(-25px, 35px) scale(1.08); }
        }

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

        .auth-card-wrap {
          position: relative;
          z-index: 10;
          width: 100%;
          max-width: 460px;
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
        }

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

        .auth-form { display: flex; flex-direction: column; gap: 16px; }

        .auth-row {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 12px;
        }

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
          box-shadow: 0 0 0 3px rgba(45, 212, 191, 0.08);
        }
        .auth-input:hover:not(:focus) {
          border-color: rgba(45, 212, 191, 0.25);
        }

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
        .auth-error::before { content: '⚠'; font-size: 0.9rem; flex-shrink: 0; }

        .auth-hint {
          font-size: 0.78rem;
          color: #4a4a46;
          margin-top: -8px;
          font-weight: 500;
        }

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
        }
        .auth-btn:hover:not(:disabled) {
          transform: translateY(-1px);
          box-shadow: 0 8px 25px -5px rgba(45, 212, 191, 0.3), 0 0 30px -10px rgba(100, 160, 220, 0.3);
        }
        .auth-btn:disabled { opacity: 0.6; cursor: not-allowed; }

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

        .auth-terms {
          font-size: 0.78rem;
          color: #4a4a46;
          text-align: center;
          line-height: 1.5;
        }

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

        /* Invite notice banner */
        .invite-banner {
          background: rgba(45, 212, 191, 0.06);
          border: 1px solid rgba(45, 212, 191, 0.2);
          border-radius: 10px;
          padding: 11px 14px;
          color: #2dd4bf;
          font-size: 0.84rem;
          font-weight: 500;
          margin-bottom: 8px;
          display: flex;
          align-items: center;
          gap: 8px;
        }
      `}</style>

      <div className="auth-page">
        <div className="auth-grid" />
        <div className="auth-orb auth-orb-1" />
        <div className="auth-orb auth-orb-2" />

        <div className="auth-card-wrap">
          <div className="auth-card">
            <Link href="/" className="auth-logo">
              <span className="auth-logo-dot" />
              <span className="auth-logo-text">intervieHire</span>
            </Link>

            <h1 className="auth-heading">Create your account</h1>
            <p className="auth-subtext">
              Set up your organisation — or accept an invite by entering your invited email.
            </p>

            <form className="auth-form" onSubmit={handleSignup}>
              <div className="auth-field">
                <label className="auth-label" htmlFor="name">Full name</label>
                <input
                  id="name"
                  className="auth-input"
                  type="text"
                  placeholder="Devasri Bali"
                  autoComplete="name"
                  value={formData.name}
                  onChange={e => setFormData(p => ({ ...p, name: e.target.value }))}
                  required
                  suppressHydrationWarning
                />
              </div>

              <div className="auth-field">
                <label className="auth-label" htmlFor="email">Work email</label>
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
                <span className="auth-hint">
                  If you were invited, use the same email address.
                </span>
              </div>

              <div className="auth-row">
                <div className="auth-field">
                  <label className="auth-label" htmlFor="password">Password</label>
                  <input
                    id="password"
                    className="auth-input"
                    type="password"
                    placeholder="Min 8 chars"
                    autoComplete="new-password"
                    value={formData.password}
                    onChange={e => setFormData(p => ({ ...p, password: e.target.value }))}
                    required
                    suppressHydrationWarning
                  />
                </div>
                <div className="auth-field">
                  <label className="auth-label" htmlFor="confirm">Confirm</label>
                  <input
                    id="confirm"
                    className="auth-input"
                    type="password"
                    placeholder="Repeat password"
                    autoComplete="new-password"
                    value={formData.confirm}
                    onChange={e => setFormData(p => ({ ...p, confirm: e.target.value }))}
                    required
                    suppressHydrationWarning
                  />
                </div>
              </div>

              {error && <div className="auth-error">{error}</div>}

              <button className="auth-btn" type="submit" disabled={loading} suppressHydrationWarning>
                {loading && <span className="btn-spinner" />}
                {loading ? 'Creating account…' : 'Create account'}
              </button>

              <p className="auth-terms">
                By signing up, you agree to our Terms of Service and Privacy Policy.
              </p>
            </form>

            <div className="auth-divider">or</div>

            <div className="auth-footer">
              Already have an account?{' '}
              <Link href="/login" className="auth-link">Sign in →</Link>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
