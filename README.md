Below is a **sample README** you can include in your repository. It showcases the project’s purpose, how to build locally, how the GitHub Actions workflow works, and includes your build status badge.

```markdown
# Ubuntu Hardened

[![Build and Push to GHCR](https://github.com/kelleyblackmore/ubuntu-hardened/actions/workflows/build-push-ghcr.yml/badge.svg)](https://github.com/kelleyblackmore/ubuntu-hardened/actions/workflows/build-push-ghcr.yml)

A minimal and **hardened Ubuntu** container image. This repository demonstrates various security and best-practice configurations:

- **Non-root** user
- **Minimal** package installation
- **Automated** build & push to GitHub Container Registry (GHCR)
- **Security scanning** with Trivy (optional)

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/kelleyblackmore/ubuntu-hardened.git
cd ubuntu-hardened
```

### 2. Build the Image Locally

```bash
docker build -t ubuntu-hardened:local .
```

### 3. Run the Container

```bash
docker run --rm -it ubuntu-hardened:local
```

- You should be dropped into a shell running **as a non-root user** inside a minimal Ubuntu environment.

### 4. Security Scan (Optional)

If you have [Trivy](https://aquasecurity.github.io/trivy/) installed locally, you can scan your built image:

```bash
trivy image ubuntu-hardened:local
```

---

## GitHub Actions Workflow

This repository uses a **GitHub Actions** workflow to automatically:

1. **Build** the container image using the `Dockerfile`.
2. **Push** the image to **GHCR** (`ghcr.io/kelleyblackmore/ubuntu-hardened:latest`).
3. (Optionally) **Scan** the image with **Trivy** for vulnerabilities.
