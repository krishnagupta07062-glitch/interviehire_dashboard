import { chromium } from 'playwright';

async function run() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  page.on('console', msg => console.log(`[Browser Console] ${msg.type()}: ${msg.text()}`));
  page.on('request', req => console.log(`[Req] ${req.method()} ${req.url()}`));
  page.on('response', res => console.log(`[Res] ${res.status()} ${res.url()}`));

  console.log("=== Step 1: Navigating to /login ===");
  await page.goto('http://localhost:3000/login');

  console.log("=== Step 2: Performing Login ===");
  await page.fill('#email', 'admin@interviehire.com');
  await page.fill('#password', 'adminpassword');
  await page.click('button[type="submit"]');

  console.log("=== Step 3: Waiting for redirect/dashboard load ===");
  try {
    await page.waitForURL('**/dashboard/**', { timeout: 10000 });
    console.log("Successfully navigated to:", page.url());
  } catch (err) {
    console.log("Login redirect failed or timed out:", err.message);
  }

  console.log("=== Step 4: Monitoring for 15 seconds ===");
  await new Promise(resolve => setTimeout(resolve, 15000));

  console.log("Final URL after monitoring:", page.url());
  await browser.close();
}

run().catch(console.error);
