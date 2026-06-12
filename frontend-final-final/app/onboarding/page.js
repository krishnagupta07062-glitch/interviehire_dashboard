'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';

const STEPS = ['Organisation', 'Details', 'Done'];

export default function OnboardingPage() {
  const router = useRouter();
  const [step, setStep] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [formData, setFormData] = useState({
    org_name: '',
    domain: '',
    contact_email: '',
    website_link: '',
    location: '',
    description: '',
  });
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return <div className="onboard-page" style={{ background: '#0a0a0a' }} />;
  }

  async function handleSubmit(e) {
    e.preventDefault();
    if (step < 1) {
      setStep(s => s + 1);
      return;
    }
    setError('');
    setLoading(true);
    try {
      const baseUrl = (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') ? `http://${window.location.hostname}:8000` : '';
      const res = await fetch(`${baseUrl}/api/auth/onboarding`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify(formData),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.detail || 'Setup failed. Please try again.');
        return;
      }
      setStep(2);
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

        .onboard-page {
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
          filter: blur(160px);
          pointer-events: none;
          z-index: 0;
        }
        .orb-1 { width: 600px; height: 600px; background: rgba(45, 212, 191, 0.08); top: -200px; right: -200px; animation: orb1 12s ease-in-out infinite; }
        .orb-2 { width: 500px; height: 500px; background: rgba(100, 160, 220, 0.08); bottom: -150px; left: -150px; animation: orb2 10s ease-in-out infinite; }

        @keyframes orb1 { 0%,100%{transform:translate(0,0)} 50%{transform:translate(-40px,50px)} }
        @keyframes orb2 { 0%,100%{transform:translate(0,0)} 50%{transform:translate(40px,-30px)} }

        .auth-grid {
          position: fixed;
          inset: 0;
          background-image: linear-gradient(rgba(255,255,255,0.012) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,0.012) 1px,transparent 1px);
          background-size: 60px 60px;
          pointer-events: none;
          z-index: 0;
        }

        .onboard-wrap {
          position: relative;
          z-index: 10;
          width: 100%;
          max-width: 520px;
          padding: 20px;
        }

        /* Progress steps */
        .progress-steps {
          display: flex;
          align-items: center;
          justify-content: center;
          gap: 0;
          margin-bottom: 28px;
        }
        .step-item {
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 6px;
          position: relative;
        }
        .step-circle {
          width: 32px; height: 32px;
          border-radius: 50%;
          border: 2px solid rgba(255,255,255,0.1);
          display: flex; align-items: center; justify-content: center;
          font-family: 'Outfit', sans-serif;
          font-weight: 700;
          font-size: 0.8rem;
          color: #4a4a46;
          background: rgba(255,255,255,0.02);
          transition: all 0.4s ease;
          position: relative;
          z-index: 2;
        }
        .step-circle.active {
          border-color: #2dd4bf;
          background: rgba(45,212,191,0.12);
          color: #2dd4bf;
          box-shadow: 0 0 20px rgba(45,212,191,0.3);
        }
        .step-circle.done {
          border-color: #34d399;
          background: rgba(52,211,153,0.12);
          color: #34d399;
        }
        .step-label {
          font-size: 0.7rem;
          font-weight: 600;
          color: #4a4a46;
          text-transform: uppercase;
          letter-spacing: 0.05em;
          white-space: nowrap;
        }
        .step-label.active { color: #2dd4bf; }
        .step-label.done { color: #34d399; }
        .step-connector {
          width: 60px; height: 1px;
          background: rgba(255,255,255,0.08);
          margin-bottom: 22px;
          position: relative;
          z-index: 1;
          transition: background 0.4s ease;
        }
        .step-connector.done { background: rgba(52,211,153,0.4); }

        /* Card */
        .onboard-card {
          background: rgba(10, 10, 14, 0.78);
          backdrop-filter: blur(30px);
          -webkit-backdrop-filter: blur(30px);
          border: 1px solid rgba(45, 212, 191, 0.15);
          border-radius: 24px;
          padding: 44px 40px 40px;
          box-shadow: 0 0 0 1px rgba(255,255,255,0.03) inset, 0 30px 60px -20px rgba(0,0,0,0.8);
        }

        .logo-row {
          display: flex;
          align-items: center;
          gap: 10px;
          margin-bottom: 32px;
        }
        .logo-dot {
          width: 10px; height: 10px;
          border-radius: 50%;
          background: linear-gradient(135deg, #2dd4bf, #64a0dc);
          box-shadow: 0 0 12px rgba(45, 212, 191, 0.6);
        }
        .logo-text {
          font-family: 'Outfit', sans-serif;
          font-weight: 800;
          font-size: 1.2rem;
          background: linear-gradient(135deg, #ffffff 30%, #2dd4bf 100%);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
          letter-spacing: -0.02em;
        }

        .onboard-heading {
          font-family: 'Outfit', sans-serif;
          font-size: 1.75rem;
          font-weight: 800;
          color: #fafaf7;
          letter-spacing: -0.03em;
          margin-bottom: 6px;
          line-height: 1.2;
        }
        .onboard-subtext {
          font-size: 0.88rem;
          color: #6b6b66;
          margin-bottom: 28px;
          font-weight: 500;
          line-height: 1.5;
        }

        .onboard-form { display: flex; flex-direction: column; gap: 16px; }

        .form-row {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 12px;
        }

        .form-field { display: flex; flex-direction: column; gap: 7px; }

        .form-label {
          font-size: 0.8rem;
          font-weight: 600;
          color: #a3a39e;
          letter-spacing: 0.04em;
          text-transform: uppercase;
          display: flex;
          align-items: center;
          gap: 6px;
        }
        .label-optional {
          font-size: 0.68rem;
          color: #4a4a46;
          font-weight: 400;
          text-transform: none;
          letter-spacing: 0;
        }

        .form-input, .form-textarea {
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
        .form-textarea {
          resize: vertical;
          min-height: 90px;
          line-height: 1.5;
        }
        .form-input::placeholder, .form-textarea::placeholder { color: #4a4a46; }
        .form-input:focus, .form-textarea:focus {
          border-color: rgba(45, 212, 191, 0.5);
          background: rgba(45, 212, 191, 0.04);
          box-shadow: 0 0 0 3px rgba(45, 212, 191, 0.08);
        }
        .form-input:hover:not(:focus), .form-textarea:hover:not(:focus) {
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
          display: flex; align-items: center; gap: 8px;
        }
        .auth-error::before { content: '⚠'; font-size: 0.9rem; flex-shrink: 0; }

        .btn-row {
          display: flex;
          gap: 12px;
          margin-top: 8px;
        }

        .btn-back {
          flex: 0;
          background: rgba(255, 255, 255, 0.04);
          border: 1px solid rgba(255,255,255,0.08);
          border-radius: 12px;
          padding: 14px 20px;
          font-family: 'Outfit', sans-serif;
          font-weight: 700;
          font-size: 0.95rem;
          color: #a3a39e;
          cursor: pointer;
          transition: background 0.2s ease, border-color 0.2s ease;
          white-space: nowrap;
        }
        .btn-back:hover { background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.15); color: #fafaf7; }

        .btn-next {
          flex: 1;
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
        }
        .btn-next:hover:not(:disabled) {
          transform: translateY(-1px);
          box-shadow: 0 8px 25px -5px rgba(45, 212, 191, 0.3), 0 0 30px -10px rgba(100, 160, 220, 0.3);
        }
        .btn-next:disabled { opacity: 0.6; cursor: not-allowed; }

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

        /* Success state */
        .success-wrap {
          text-align: center;
          padding: 20px 0;
        }
        .success-icon {
          width: 72px; height: 72px;
          border-radius: 50%;
          background: rgba(52, 211, 153, 0.1);
          border: 2px solid rgba(52, 211, 153, 0.3);
          display: flex; align-items: center; justify-content: center;
          margin: 0 auto 24px;
          font-size: 2rem;
          animation: successPop 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
        }
        @keyframes successPop {
          from { transform: scale(0.5); opacity: 0; }
          to { transform: scale(1); opacity: 1; }
        }
        .success-heading {
          font-family: 'Outfit', sans-serif;
          font-size: 1.75rem;
          font-weight: 800;
          color: #fafaf7;
          letter-spacing: -0.03em;
          margin-bottom: 10px;
        }
        .success-text {
          color: #6b6b66;
          font-size: 0.92rem;
          line-height: 1.6;
          margin-bottom: 28px;
        }
        .btn-dashboard {
          background: linear-gradient(135deg, #2dd4bf 0%, #64a0dc 100%);
          color: #0a0a0a;
          border: none;
          border-radius: 12px;
          padding: 15px 40px;
          font-family: 'Outfit', sans-serif;
          font-weight: 800;
          font-size: 1rem;
          cursor: pointer;
          transition: transform 0.2s ease, box-shadow 0.3s ease;
          display: inline-block;
          text-decoration: none;
        }
        .btn-dashboard:hover {
          transform: translateY(-1px);
          box-shadow: 0 8px 25px -5px rgba(45, 212, 191, 0.3), 0 0 30px -10px rgba(100, 160, 220, 0.3);
        }
      `}</style>

      <div className="onboard-page">
        <div className="auth-grid" />
        <div className="auth-orb orb-1" />
        <div className="auth-orb orb-2" />

        <div className="onboard-wrap">
          {/* Progress indicator */}
          <div className="progress-steps">
            {STEPS.map((label, i) => (
              <>
                <div className="step-item" key={label}>
                  <div className={`step-circle ${i < step ? 'done' : i === step ? 'active' : ''}`}>
                    {i < step ? '✓' : i + 1}
                  </div>
                  <span className={`step-label ${i < step ? 'done' : i === step ? 'active' : ''}`}>{label}</span>
                </div>
                {i < STEPS.length - 1 && (
                  <div className={`step-connector ${i < step ? 'done' : ''}`} key={`c-${i}`} />
                )}
              </>
            ))}
          </div>

          <div className="onboard-card">
            <div className="logo-row">
              <span className="logo-dot" />
              <span className="logo-text">intervieHire</span>
            </div>

            {step === 2 ? (
              // Success state
              <div className="success-wrap">
                <div className="success-icon">🎉</div>
                <h2 className="success-heading">You're all set!</h2>
                <p className="success-text">
                  Your organisation has been created successfully.<br />
                  Let's start finding great talent.
                </p>
                <a className="btn-dashboard" href="/dashboard">
                  Go to Dashboard →
                </a>
              </div>
            ) : step === 0 ? (
              // Step 1: Organisation basics
              <>
                <h2 className="onboard-heading">Set up your organisation</h2>
                <p className="onboard-subtext">
                  Tell us about your company — this will be your hiring hub.
                </p>
                <form className="onboard-form" onSubmit={handleSubmit}>
                  <div className="form-field">
                    <label className="form-label" htmlFor="org_name">Organisation name</label>
                    <input
                      id="org_name"
                      className="form-input"
                      type="text"
                      placeholder="Acme Corp"
                      value={formData.org_name}
                      onChange={e => setFormData(p => ({ ...p, org_name: e.target.value }))}
                      required
                    />
                  </div>
                  <div className="form-row">
                    <div className="form-field">
                      <label className="form-label" htmlFor="domain">
                        Domain <span className="label-optional">(optional)</span>
                      </label>
                      <input
                        id="domain"
                        className="form-input"
                        type="text"
                        placeholder="acme"
                        value={formData.domain}
                        onChange={e => setFormData(p => ({ ...p, domain: e.target.value }))}
                      />
                    </div>
                    <div className="form-field">
                      <label className="form-label" htmlFor="location">
                        Location <span className="label-optional">(optional)</span>
                      </label>
                      <input
                        id="location"
                        className="form-input"
                        type="text"
                        placeholder="Remote / New York"
                        value={formData.location}
                        onChange={e => setFormData(p => ({ ...p, location: e.target.value }))}
                      />
                    </div>
                  </div>
                  {error && <div className="auth-error">{error}</div>}
                  <div className="btn-row">
                    <button className="btn-next" type="submit">
                      Continue →
                    </button>
                  </div>
                </form>
              </>
            ) : (
              // Step 2: More details
              <>
                <h2 className="onboard-heading">A bit more about you</h2>
                <p className="onboard-subtext">
                  Help candidates and your team find you. All fields are optional.
                </p>
                <form className="onboard-form" onSubmit={handleSubmit}>
                  <div className="form-field">
                    <label className="form-label" htmlFor="contact_email">Contact email</label>
                    <input
                      id="contact_email"
                      className="form-input"
                      type="email"
                      placeholder="hr@acme.com"
                      value={formData.contact_email}
                      onChange={e => setFormData(p => ({ ...p, contact_email: e.target.value }))}
                    />
                  </div>
                  <div className="form-field">
                    <label className="form-label" htmlFor="website_link">Website</label>
                    <input
                      id="website_link"
                      className="form-input"
                      type="url"
                      placeholder="https://acme.com"
                      value={formData.website_link}
                      onChange={e => setFormData(p => ({ ...p, website_link: e.target.value }))}
                    />
                  </div>
                  <div className="form-field">
                    <label className="form-label" htmlFor="description">Description</label>
                    <textarea
                      id="description"
                      className="form-textarea"
                      placeholder="A short description of what your company does…"
                      value={formData.description}
                      onChange={e => setFormData(p => ({ ...p, description: e.target.value }))}
                    />
                  </div>
                  {error && <div className="auth-error">{error}</div>}
                  <div className="btn-row">
                    <button type="button" className="btn-back" onClick={() => setStep(0)}>
                      ← Back
                    </button>
                    <button className="btn-next" type="submit" disabled={loading}>
                      {loading && <span className="btn-spinner" />}
                      {loading ? 'Setting up…' : 'Complete setup'}
                    </button>
                  </div>
                </form>
              </>
            )}
          </div>
        </div>
      </div>
    </>
  );
}
