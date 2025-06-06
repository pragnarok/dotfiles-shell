# 🐧 Dotfiles Shell – DevOps & Terminal Setup by @pragnarok

Automated bootstrap to provision a complete DevOps environment and custom terminal with ZSH, Powerlevel10k, and essential infrastructure tools.

---

## 📁 Project Structure

```
.
├── google/
│   └── googleSDK.sh              # Setup for Google tools (e.g. Google Cloud SDK)
├── init.sh                       # Main orchestration script
├── LICENSE
├── README.md
├── scripts/                      # Modular scripts by purpose
│   ├── install_basic.sh
│   ├── install_clouds.sh
│   ├── install_devops.sh
│   ├── install_vim.sh
│   ├── install_zsh.sh
│   ├── update_git.sh
│   └── update_system.sh
└── terminal/
    └── MesloLGS_NF_Regular.ttf   # Nerd Font for terminal (Powerlevel10k compatible)
```

---

## 🚀 How to Use

1. Clone this repository:

```bash
git clone https://github.com/pragnarok/dotfiles-shell.git
cd dotfiles-shell
```

2. Make the main script executable:

```bash
chmod +x init.sh
```

3. Run:

```bash
./init.sh
```

> ⚠️ **Note**: You’ll need `sudo` privileges to install packages and update system configs.

---

## 🔧 What’s Included

### 🎨 Terminal

- ZSH with OhMyZsh
- Powerlevel10k theme
- Plugins:
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
- Nerd Font: MesloLGS NF
- Tilix terminal

### ⚙️ DevOps Tools

- [VSCode](https://code.visualstudio.com/)
- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)
- [Helm](https://helm.sh/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [ArgoCD CLI](https://argo-cd.readthedocs.io/)
- [Podman](https://podman.io/)
- [Slack](https://slack.com/)
- [Flameshot](https://flameshot.org/)

### 🛠️ Utilities & Configuration

- Git with interactive user.name and user.email setup
- Vim set as default editor (`$EDITOR`, Git, system)
- Clean modular structure for maintenance

---

## 🧱 Modular Architecture

The `init.sh` script orchestrates all functionality by sourcing scripts inside the `scripts/` folder, allowing:

- Easy maintenance per tool category
- Reusability across systems
- Smooth future expansion

---

## 💡 Future Customizations (Ideas)

- Auto-install recommended VSCode extensions
- SSH/GPG key automation
- Support for WSL/macOS
- ZSH aliases & function presets
- Backstage/TechDocs setup

---

## 📄 License

Distributed under the [MIT License](LICENSE).

---

## 🤝 Contributing

Contributions are welcome!

- Fork the project
- Create a branch with your feature
- Submit a Pull Request or open an Issue with ideas

---

Built with 💻 + ☕ by [@pragnarok](https://github.com/pragnarok)