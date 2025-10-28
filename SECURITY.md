# Security Policy

## 🔒 Reporting a Vulnerability

The security of Voice-to-Tasks Automation is a top priority. If you discover a security vulnerability, we appreciate your help in disclosing it to us responsibly.

### Please DO:

✅ **Email us directly** - Send details to: [security@yourdomain.com](mailto:security@yourdomain.com)  
✅ **Provide detailed information** - Include steps to reproduce, impact assessment, and any suggested fixes  
✅ **Give us reasonable time** - Allow us time to investigate and address the issue before public disclosure  
✅ **Be respectful** - We're all working to make this project better and safer

### Please DON'T:

❌ **Create public GitHub issues** for security vulnerabilities  
❌ **Disclose the vulnerability publicly** before we've had a chance to address it  
❌ **Exploit the vulnerability** beyond what's necessary to demonstrate it  
❌ **Access, modify, or delete data** that doesn't belong to you

---

## 🛡️ What We Consider a Security Vulnerability

### High Priority

- **Authentication bypass** - Ability to access system without proper credentials
- **SQL injection** - Database manipulation through user input
- **Remote code execution** - Ability to run arbitrary code on servers
- **Privilege escalation** - Unauthorized access to elevated permissions
- **API key exposure** - Credentials visible in logs, errors, or public repositories
- **Cross-site scripting (XSS)** - Injection of malicious scripts
- **Server-side request forgery (SSRF)** - Unauthorized requests to internal resources

### Medium Priority

- **Information disclosure** - Exposure of sensitive data
- **Cross-site request forgery (CSRF)** - Unauthorized state-changing requests
- **Open redirect** - Redirection to malicious external sites
- **Denial of service (DoS)** - Service disruption attacks
- **Insecure dependencies** - Known vulnerabilities in third-party packages

### Lower Priority (but still important!)

- **Insecure configuration** - Default or weak security settings
- **Missing security headers** - HTTP headers that improve security
- **Information leakage** - Verbose error messages or debug information
- **Weak cryptography** - Use of outdated or weak encryption methods

---

## 🔐 Security Best Practices

### For Users

1. **Protect Your Credentials**
   - Never commit API keys, passwords, or tokens to version control
   - Use environment variables for all sensitive data
   - Rotate credentials regularly

2. **Keep Software Updated**
   - Update Docker images regularly
   - Monitor security advisories for n8n, Open WebUI, and dependencies
   - Apply security patches promptly

3. **Network Security**
   - Use HTTPS/TLS for all communications
   - Implement firewall rules to restrict access
   - Use VPN or private networks when possible

4. **Access Control**
   - Use strong, unique passwords
   - Enable two-factor authentication where available
   - Follow the principle of least privilege

5. **Data Protection**
   - Encrypt sensitive data at rest
   - Use secure email protocols (TLS/SSL)
   - Regularly backup data

### For Developers

1. **Code Security**
   - Validate and sanitize all user input
   - Use parameterized queries to prevent SQL injection
   - Implement proper error handling without exposing sensitive information
   - Follow secure coding guidelines

2. **Dependency Management**
   - Regularly update dependencies
   - Use `npm audit` or similar tools to check for vulnerabilities
   - Pin dependency versions to avoid unexpected updates

3. **API Security**
   - Use API authentication tokens
   - Implement rate limiting
   - Validate all API inputs
   - Use HTTPS for all API endpoints

4. **Testing**
   - Include security testing in CI/CD pipeline
   - Test for common vulnerabilities (OWASP Top 10)
   - Perform regular security audits

---

## 📋 Vulnerability Disclosure Process

When you report a vulnerability, here's what happens:

### 1. **Acknowledgment** (Within 48 hours)
We'll confirm receipt of your report and provide a tracking ID for follow-up.

### 2. **Initial Assessment** (Within 1 week)
We'll assess the severity and validity of the reported vulnerability.

### 3. **Investigation** (1-4 weeks)
We'll investigate the issue, determine the root cause, and develop a fix.

### 4. **Fix Development** (Timeline varies)
We'll implement and test a security patch or workaround.

### 5. **Disclosure** (After fix is deployed)
We'll:
- Deploy the fix to all affected systems
- Notify affected users if necessary
- Credit you for the discovery (if you wish)
- Publish a security advisory

---

## 🏅 Responsible Disclosure

We believe in responsible disclosure and will:

- **Acknowledge** your contribution publicly (if you want)
- **Keep you informed** throughout the process
- **Work quickly** to address the issue
- **Credit researchers** who follow responsible disclosure

---

## 🔍 Security Audit History

| Date | Type | Findings | Status |
|------|------|----------|--------|
| TBD | Internal Review | - | Planned |

*Last updated: October 2025*

---

## 📞 Contact

**Security Email:** [security@yourdomain.com](mailto:security@yourdomain.com)  
**PGP Key:** Available upon request

For non-security-related issues, please use [GitHub Issues](https://github.com/yourusername/vikunja-voice-automation/issues).

---

## 🙏 Thank You

We appreciate the security community's efforts to responsibly disclose vulnerabilities. Your contributions help keep Voice-to-Tasks Automation safe for everyone.

---

*This security policy is subject to change. Please check back regularly for updates.*

