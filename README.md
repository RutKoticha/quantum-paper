# 🪞 quantum-paper

> **A rigorously structured, minimalist configuration system.**  
> Where precise system architecture meets a high-contrast, expressive aesthetic.

`quantum-paper` is the foundational blueprint for my Linux environment. It bridges the gap between raw functional performance and clean, Swiss Design-inspired minimalism. It is built to be portable, highly responsive, and strictly organized.

## 📐 The Philosophy

*   **Expressive Minimalism:** Interfaces should be clean, high-contrast, and leverage glassmorphism and Material 3 principles without sacrificing terminal speed.
*   **System Agnostic:** Built to seamlessly transition across environments, whether spinning up a lightweight Ubuntu container, configuring a Fedora workstation, or pushing frames on Arch/CachyOS.
*   **Modular Architecture:** Configurations are compartmentalized. If a service isn't needed, its blueprint stays out of the way.

## 🛠️ The Stack

This repository governs the core tools of the environment:

*   **OS/Core:** Arch (CachyOS) / Fedora / Ubuntu
*   **Editor:** Neovim (Custom configuration optimized for syntax clarity and speed)
*   **Shell:** Zsh (with aliases mapped to core workflows)
*   **System Management:** systemd timers and Flatpak configurations
*   **Infrastructure:** Docker, Caddy, Tailscale (Self-hosted routing and reverse-proxy setups)
*   **Theming:** A custom "Golden Eclipse" high-contrast palette

## 📂 Repository Structure

The architecture of `quantum-paper` is kept intentionally flat and readable:

```text
quantum-paper/
├── .gitconfig       # Global Git aliases and identity
├── .profile         # Environment variables and path extensions
├── .zshrc           # Shell configuration, prompt styling, and aliases
├── nvim/            # Neovim lua configuration and plugin manifests
└── scripts/         # Automated deployment and system initialization scripts
