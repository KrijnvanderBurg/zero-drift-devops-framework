# Zero-Drift DevOps Framework

A comprehensive DevOps framework providing enterprise-grade CI/CD capabilities with GitHub Actions workflows, DevContainer environments, and Azure DevOps pipeline templates. This repository demonstrates how to achieve perfect consistency between local development and CI/CD pipelines through shared configurations.

![Azure DevOps Pipeline Screenshot](./docs/azure_devops_pipeline_screenshot.png)

## 🚀 Why Use This Framework?

### Zero-Configuration Local Development with DevContainers
DevContainer environments provide instant setup with 20+ pre-configured development tools. Run the same linters, formatters, type checkers, and security scanners locally that run in your GitHub Actions workflows - using identical configurations from `.github/configs/`.

### Near-Zero Configuration CI/CD Pipelines
GitHub Actions workflows and Azure DevOps templates provide fully configured CI/CD pipelines with industry best practices built-in, ensuring consistent, secure, and reliable deployments across your entire organization.

### Comprehensive Tool Integration
This template collection includes 25+ carefully curated industry-standard development tools, primarily for Python, across multiple categories:

- **🎨 Code Formatters**: Ruff, Black, isort - Ensure consistent code style across teams
- **🔍 Linters & Analyzers**: Pylint, Flake8, Ruff Linter - Catch bugs and enforce best practices
- **🔒 Type Checkers**: Mypy, Pyright, Pyre - Prevent type-related errors before deployment
- **🛡️ Security Scanners**: Bandit, Semgrep, DevSkim - Identify vulnerabilities and security issues
- **🔐 Secret Detection**: Gitleaks, TruffleHog - Prevent credential leaks in repositories
- **📦 Dependency Analysis**: OWASP Dependency Check, OSSAudit - Monitor third-party package vulnerabilities
- **🧪 Testing & Coverage**: Pytest with Coverage.py - Ensure code reliability and test completeness
- **📚 Documentation**: Sphinx - Generate professional documentation automatically
- **🏗️ Infrastructure**: OpenTofu/Terraform - Infrastructure as Code deployment and validation

> **💡 Perfect Local-Remote Consistency:** DevContainer environments use `.github/configs/` as the source of truth, matching your GitHub Actions workflows exactly. When local checks pass, you're confident your GitHub Actions will pass. Azure DevOps pipelines use `.azuredevops/configs/` for teams using that platform.

### Modular Architecture Design

#### Primary: GitHub Actions + DevContainers
The recommended workflow uses:
- **DevContainers** - Local development with `.github/configs/` as source of truth
- **GitHub Actions** - CI/CD workflows using `.github/configs/` for consistency
- **Reusable Workflows** - Composable workflow patterns for common tasks

#### Alternative: Azure DevOps Templates
For teams using Azure DevOps, this repository includes:
- **Atomic Templates** - Single-purpose, focused templates for individual tools
- **Composite Templates** - Combine related atomic templates for common workflows
- **Configurations** - `.azuredevops/configs/` as source of truth for Azure pipelines

> **🚀 Local-First Development:** DevContainers let you run all quality checks locally before pushing. Same tools, same configs, same results as GitHub Actions.

## 🏁 Getting Started

### Recommended: GitHub Actions + DevContainers

This is the **primary workflow** for this repository:

1. **📥 Clone this repository**
   ```bash
   git clone https://github.com/KrijnvanderBurg/zero-drift-devops-framework.git
   cd zero-drift-devops-framework
   ```

2. **� Use DevContainers for local development**
   - Open in VS Code → `F1` → "Dev Containers: Rebuild and Reopen in Container"
   - DevContainers use `.github/configs/` as source of truth for tool configurations
   - Run linters, formatters, type checkers locally with same configs as GitHub Actions
   - Watch the Problems panel populate with real-time feedback
   - All quality checks pass? You're ready to push!

3. **🚀 Commit and Push** 
   ```bash
   git add .
   git commit -m "Your changes"
   git push
   ```

4. **✅ GitHub Actions Workflows (Automatic)**
   - Workflows automatically run on push using `.github/configs/` configurations
   - Same tools, same configs, same results as your local DevContainer
   - Check workflow runs - if local checks passed, remote checks will pass too
   
   Example workflow files in `.github/workflows/`:
   - `python-ci.yml` - Code quality, testing, security scanning
   - `opentofu-deployment-all.yml` - Infrastructure deployment
   - `ansible-deployment-all.yml` - Application deployment

### Alternative: Azure DevOps Pipelines

For teams using Azure DevOps:

<details>
<summary>Click to expand Azure DevOps setup instructions</summary>

**Pipeline Configuration** (`azure-pipelines.yml` in repository root):
```yaml
trigger:
  - main

extends:
  template: /.azuredevops/pipelines/python.yaml
  parameters:
    pythonVersion: 3.11
    pythonSrcDirectory: $(Build.Repository.LocalPath)/src
    pythonTestsDirectory: $(Build.Repository.LocalPath)/tests
```

**Key Points:**
- Uses `.azuredevops/configs/` as source of truth for Azure pipelines
- Automatically runs on push with 25+ quality checks
- Templates available for atomic, composite, and complete workflows

</details>

### Advanced: Git Submodule Setup

> **Note:** This repository uses a monorepo structure, but the **git submodule approach is equally valid** for sharing workflows/templates across multiple repositories.

<details>
<summary>Click to expand submodule setup instructions</summary>

**For GitHub Actions:**
```bash
git submodule add https://github.com/YourOrg/workflows.git .github
```

**For Azure DevOps:**
```bash
git submodule add https://github.com/YourOrg/.azuredevops.git .azuredevops
git submodule update --init
```

Then reference templates using external repository syntax in your pipeline configuration.

</details>

### 🔍 Workflow Patterns

#### Primary: GitHub Actions with Reusable Workflows

Local development using DevContainers matches GitHub Actions exactly:

```yaml
# .github/workflows/ci.yml
jobs:
  quality:
    uses: ./.github/workflows/python-quality.yml
  tests:
    uses: ./.github/workflows/python-tests.yml
```

**Benefits:**
- **Perfect Local-Remote Match**: DevContainers use `.github/configs/`, GitHub Actions use `.github/configs/`
- **Fast Feedback**: All checks run locally before pushing
- **Simple Setup**: Single repository, no external dependencies
- **Modern Tooling**: GitHub's ecosystem and marketplace

#### Alternative: Azure DevOps Templates

<details>
<summary>Click to expand Azure DevOps pattern details</summary>

For Azure DevOps pipelines:

```yaml
extends:
  template: /.azuredevops/pipelines/python.yaml
```

**Benefits:**
- **Enterprise Features**: Advanced security and compliance
- **Template Composition**: Atomic → Composite → Solution patterns
- **Separate Configs**: `.azuredevops/configs/` for Azure-specific settings

</details>


## 📁 Repository Structure

```bash
.azuredevops/
├── configs/                         # Shared tool configurations (source of truth)
│   ├── python/                        # Python tool configs + execution scripts
│   │   ├── .banditrc                    # Bandit security scanner config
│   │   ├── .flake8                      # Flake8 linter config
│   │   ├── .pylintrc                    # Pylint linter config
│   │   ├── mypy.ini                     # Mypy type checker config
│   │   ├── pyproject.toml               # Ruff, Black, isort configs
│   │   └── scripts/                     # Shell scripts to execute tools
│   └── git/                           # Git security tool configs
│       ├── .gitleaks.toml               # Gitleaks secret scanner config
│       └── scripts/                     # Shell scripts to execute tools
├── pipelines/                       # Complete end-to-end pipeline definitions
│   ├── python.yaml                    # Python project CI/CD pipeline
│   └── opentofu.yaml                  # Infrastructure deployment pipeline
├── templates/                       # Reusable pipeline templates
│   ├── atomic/                        # Single-purpose atomic templates
│   │   ├── python/                      # Python tooling (25+ tools)
│   │   ├── opentofu/                    # OpenTofu/Terraform operations
│   │   ├── azuredevops/                 # Azure DevOps utilities
│   │   └── git/                         # Git operations
│   └── composite/                     # Multi-tool workflow templates
│       ├── python/                      # Python quality gates & workflows
│       └── opentofu/                    # Infrastructure deployment workflows
├── scripts/                         # Helper scripts and utilities
│   ├── python/                        # Python automation scripts
│   ├── powershell/                    # PowerShell utilities
│   └── shell/                         # Shell script utilities
└── variables/                       # Centralized variable management
    ├── shared.yml                     # Cross-project shared variables
    └── environments/                  # Environment-specific configurations
        ├── dev.yml                      # Development environment
        └── prod.yml                     # Production environment
```



## 🛠️ Complete Template Reference

### 🐍 Python Development Templates

#### Atomic Templates (Single-Purpose)

**Formatters**
- **Ruff Formatter** <sup>[Docs](https://docs.astral.sh/ruff/) | [Template](v1/templates/atomic/python/ruff-formatter.yaml)</sup> - Lightning-fast Python formatter written in Rust. **Primary recommendation** for modern Python development.
- **Black** <sup>[Docs](https://black.readthedocs.io/) | [Template](v1/templates/atomic/python/black.yaml)</sup> - The uncompromising Python code formatter.
- **isort** <sup>[Docs](https://pycqa.github.io/isort/) | [Template](v1/templates/atomic/python/isort.yaml)</sup> - Sorts Python imports alphabetically and separates them into sections.

**Linters & Code Quality**
- **Ruff Linter** <sup>[Docs](https://docs.astral.sh/ruff/) | [Template](v1/templates/atomic/python/ruff-linter.yaml)</sup> - Extremely fast linter with 800+ rules. **Primary recommendation** for comprehensive code quality checks.
- **Pylint** <sup>[Docs](https://pylint.org/) | [Template](v1/templates/atomic/python/pylint.yaml)</sup> - Comprehensive static code analyzer that checks for errors and enforces coding standards.
- **Flake8** <sup>[Docs](https://flake8.pycqa.org/) | [Template](v1/templates/atomic/python/flake8.yaml)</sup> - Combines pycodestyle, pyflakes, and mccabe to check code style and quality.
- **Vulture** <sup>[Docs](https://github.com/jendrikseipp/vulture) | [Template](v1/templates/atomic/python/vulture.yaml)</sup> - Finds unused code in Python programs.

**Type Checkers**
- **Mypy** <sup>[Docs](https://mypy-lang.org/) | [Template](v1/templates/atomic/python/mypy.yaml)</sup> - Optional static type checker for Python.
- **Pyright** <sup>[Docs](https://microsoft.github.io/pyright) | [Template](v1/templates/atomic/python/pyright.yaml)</sup> - Fast, standards-based static type checker.
- **Pyre** <sup>[Docs](https://pyre-check.org/) | [Template](v1/templates/atomic/python/pyre.yaml)</sup> - Facebook's performant type checker for large codebases.

**Security & Vulnerability Scanners**
- **Bandit** <sup>[Docs](https://bandit.readthedocs.io) | [Template](v1/templates/atomic/python/bandit.yaml)</sup> - Scans Python code for common security issues.
- **Semgrep** <sup>[Docs](https://semgrep.dev/p/python) | [Template](v1/templates/atomic/python/semgrep.yaml)</sup> - Fast static analysis for finding bugs and security vulnerabilities.
- **DevSkim** <sup>[Docs](https://github.com/microsoft/DevSkim) | [Template](v1/templates/atomic/python/devskim.yaml)</sup> - Microsoft's security analysis framework.
- **Graudit** <sup>[Github](https://github.com/wireghoul/graudit) | [Template](v1/templates/atomic/python/graudit.yaml)</sup> - Grep-based source code auditing tool.

**Secrets & Credentials Detection**
- **TruffleHog** <sup>[Github](https://github.com/trufflesecurity/trufflehog) | [Template](v1/templates/atomic/python/trufflehog.yaml)</sup> - Searches repositories for high-entropy strings and secrets.
- **Gitleaks** <sup>[Github](https://github.com/gitleaks/gitleaks) | [Template](v1/templates/atomic/python/gitleaks.yaml)</sup> - SAST tool for detecting hardcoded secrets.

**Dependency Analysis**
- **OSSAudit** <sup>[Github](https://github.com/illikainen/ossaudit) | [Template](v1/templates/atomic/python/ossaudit.yaml)</sup> - Uses Sonatype OSS Index to audit Python packages for vulnerabilities.
- **OWASP Dependency Check** <sup>[Docs](https://owasp.org/www-project-dependency-check/) | [Template](v1/templates/atomic/python/owasp.yaml)</sup> - Software Composition Analysis tool for detecting vulnerabilities in dependencies.

**Testing & Coverage**
- **Pytest** <sup>[Docs](https://docs.pytest.org) | [Template](v1/templates/atomic/python/pytest.yaml)</sup> - The pytest framework with coverage reporting.
- **Pytest Split** <sup>[Template](v1/templates/atomic/python/pytest-split.yaml)</sup> - Run tests in parallel across multiple agents for faster execution.
- **Pytest Diff** <sup>[Template](v1/templates/atomic/python/pytest-diff.yaml)</sup> - Run only tests affected by code changes.

**Dependency Management & Packaging**
- **Poetry Install** <sup>[Docs](https://python-poetry.org/) | [Template](v1/templates/atomic/python/poetry-install-pyproject.yaml)</sup> - Install dependencies using Poetry and pyproject.toml.
- **Pip Install Requirements** <sup>[Template](v1/templates/atomic/python/pip-install-requirements.yaml)</sup> - Install dependencies from requirements.txt.
- **Pip Install Editable** <sup>[Template](v1/templates/atomic/python/pip-install-editable.yml)</sup> - Install package in editable/development mode.
- **Python Build Wheel** <sup>[Docs](https://build.pypa.io) | [Template](v1/templates/atomic/python/build-wheel-bdist.yaml)</sup> - Build Python packages using the build frontend.
- **Twine Upload** <sup>[Docs](https://twine.readthedocs.io) | [Template](v1/templates/atomic/python/twine-upload.yml)</sup> - Upload Python packages to PyPI.

**Documentation**
- **Sphinx** <sup>[Docs](https://www.sphinx-doc.org/) | [Template](v1/templates/atomic/python/sphinx.yaml)</sup> - Generate professional documentation.

**Metadata Extraction**
- **PyProject Extract Metadata** <sup>[Template](v1/templates/atomic/python/pyproject-extract-metadata.yaml)</sup> - Extract version, name, and metadata from pyproject.toml.

#### Composite Templates (Multi-Tool Workflows)

- **Formatter Workflow** <sup>[Template](v1/templates/composite/python/formatter.yaml)</sup> - Combines Ruff Formatter, Black, and isort for complete code formatting.
- **Linter Workflow** <sup>[Template](v1/templates/composite/python/linter.yaml)</sup> - Runs Ruff Linter, Pylint, and Flake8 for comprehensive code quality analysis.
- **Type Checking Workflow** <sup>[Template](v1/templates/composite/python/typechecking.yaml)</sup> - Executes Mypy, Pyright, and Pyre for complete type validation.
- **1st Party Vulnerability Scanning** <sup>[Template](v1/templates/composite/python/scanning_1st_vulnerabilities.yaml)</sup> - Scans your source code with Bandit, Semgrep, DevSkim, and Graudit.
- **3rd Party Vulnerability Scanning** <sup>[Template](v1/templates/composite/python/scanning_3rd_vulnerabilities.yaml)</sup> - Analyzes dependencies with OSSAudit and OWASP Dependency Check.
- **Documentation Generation** <sup>[Template](v1/templates/composite/python/documentation.yaml)</sup> - Complete documentation workflow with Sphinx.

#### Solution Templates (Complete CI/CD)

- **Python CI Pipeline** <sup>[Template](v1/templates/solution/python/python-ci.yaml)</sup> - Complete CI/CD pipeline including:
  - Quality Assurance stage (formatters, linters, type checkers)
  - Testing stage (pytest with coverage)
  - Vulnerability Scanning stage (security analysis)

### 🛠️ Infrastructure (OpenTofu/Terraform) Templates

#### Atomic Templates

- **OpenTofu Install** <sup>[Template](v1/templates/atomic/opentofu/opentofu-install.yaml)</sup> - Install OpenTofu binary for pipeline execution.
- **OpenTofu Init** <sup>[Template](v1/templates/atomic/opentofu/opentofu-init.yaml)</sup> - Initialize OpenTofu working directory.
- **OpenTofu Validate** <sup>[Template](v1/templates/atomic/opentofu/opentofu-validate.yaml)</sup> - Validate OpenTofu configuration files.
- **OpenTofu Plan** <sup>[Template](v1/templates/atomic/opentofu/opentofu-plan.yaml)</sup> - Create OpenTofu execution plan.
- **OpenTofu Apply** <sup>[Template](v1/templates/atomic/opentofu/opentofu-apply.yaml)</sup> - Apply OpenTofu configuration changes.

#### Composite Templates

- **Validate & Plan** <sup>[Template](v1/templates/composite/opentofu/validate_and_plan.yml)</sup> - Complete validation and planning workflow.
- **Apply Infrastructure** <sup>[Template](v1/templates/composite/opentofu/apply.yml)</sup> - Full infrastructure deployment workflow.

### 🔄 Azure DevOps Utilities

- **Promote Artifact** <sup>[Template](v1/templates/atomic/azuredevops/promote-artifact.yaml)</sup> - Promote artifacts between environments or feeds.
- **PR Comment** <sup>[Template](v1/templates/atomic/azuredevops/pr-comment.yaml)</sup> - Add automated comments to pull requests.

### 📂 Git Operations

- **Checkout** <sup>[Template](v1/templates/atomic/git/checkout.yaml)</sup> - Standard git checkout with optimizations.
- **Checkout with Submodules** <sup>[Template](v1/templates/atomic/git/checkout-with-submodules.yaml)</sup> - Git checkout with recursive submodule initialization.



## 🏗️ Architecture: Local-First Development with Configuration Consistency

This repository demonstrates **perfect local-remote consistency** through a configuration-as-source-of-truth approach:

### Primary: DevContainers + GitHub Actions

**`.github/configs/`** - Single source of truth for local development AND GitHub Actions:
- **Configuration files** for all development tools (linters, formatters, type checkers, security scanners)
- **Shell scripts** that execute each tool with consistent parameters
- **Used by both** DevContainers (local) and GitHub Actions (remote)

**Workflow:**
1. **Local**: DevContainer runs tools using `.github/configs/`
2. **Remote**: GitHub Actions runs same tools using `.github/configs/`
3. **Result**: Perfect consistency - local pass = remote pass

### Alternative: Azure DevOps Pipelines

**`.azuredevops/configs/`** - Source of truth for Azure DevOps pipelines:
- Pipeline templates reference configs in their own directory
- Azure-specific optimizations and settings
- Separate from GitHub configs for provider-specific customization

### Benefits of This Architecture

🎯 **Perfect Local-Remote Match**: DevContainers and GitHub Actions use identical `.github/configs/`
🔒 **Confidence in Pushing**: If local checks pass, remote checks will pass  
🚀 **Fast Feedback Loop**: Catch issues in seconds locally, not minutes in CI/CD  
⚡ **No Environment Drift**: Same script, same config, same results  
🛠️ **Zero-Configuration Setup**: DevContainer launches with everything pre-configured

### How It Works: Pylint Example

When you run Pylint locally in DevContainer:
```jsonc
// VS Code Task (in DevContainer)
{
   "label": "pylint",
   "command": "${workspaceFolder}/.github/configs/python/scripts/pylint.sh",
   "args": [
      "${workspaceFolder}/src",
      "--config ${workspaceFolder}/.github/configs/python/.pylintrc"
   ]
}
```

When GitHub Actions runs Pylint remotely:
```yaml
# .github/workflows/python-ci.yml
steps:
- name: Run Pylint
  run: |
    .github/configs/python/scripts/pylint.sh \
      src \
      --config .github/configs/python/.pylintrc
```

**Same script. Same config. Same results.** This is the power of local-first development.

<details>
<summary>Azure DevOps Example (Alternative)</summary>

For teams using Azure DevOps, pipelines use `.azuredevops/configs/`:
```yaml
# Azure DevOps pipeline step
steps:
- script: |
    sh $(Build.Repository.LocalPath)/.azuredevops/configs/python/scripts/pylint.sh \
      $(Build.Repository.LocalPath)/src \
      --config $(Build.Repository.LocalPath)/.azuredevops/configs/python/.pylintrc
  displayName: Pylint (linter)
```

</details>

### Alternative: Git Submodule Approach

> **Note:** While this repository uses a monorepo structure, many teams successfully use **git submodules** to share a single `.dotfiles` submodule across:
> - `.azuredevops/.dotfiles/` - Nested submodule for Azure pipelines
> - `.github/.dotfiles/` - Nested submodule for GitHub workflows  
> - `.devcontainer/.dotfiles/` - Nested submodule for local development
>
> **Both approaches are valid.** Submodules provide true single-source-of-truth (one config shared everywhere), while the monorepo approach offers simpler management with per-provider flexibility.



## 📞 Support & Troubleshooting

**"DevContainer won't start"**
- Ensure Docker Desktop is running
- Try "Dev Containers: Rebuild Container" from VS Code command palette
- Check `.devcontainer/devcontainer.json` for syntax errors

**"GitHub Actions workflow failing but local checks pass"**
- Verify you're using the same Python/Node version locally and in workflows
- Check that `.github/configs/` is committed to your repository
- Review workflow logs for specific error messages

**"Configuration file not found in workflows"**
```
Error: Configuration file not found: .github/configs/python/.pylintrc
```
- Ensure `.github/configs/` directory is committed and pushed
- Verify file paths in workflow YAML match actual file locations
- Check repository checkout step includes `fetch-depth: 0` if needed

<details>
<summary>Azure DevOps Troubleshooting</summary>

**"Configuration file not found"**
```
Error: Configuration file not found: .azuredevops/configs/python/.pylintrc
```
- Ensure `.azuredevops/configs/` directory is committed
- Verify checkout step includes submodules if using submodule setup

**"Template reference not found"**
- Use relative paths like `/.azuredevops/templates/...` for monorepo
- Use `@templates` repository reference for submodule setups

</details>

---

## 🚀 Ready to Experience Local-First Development?

**Start Local:** Open this repository in VS Code, launch a DevContainer, and experience 20+ quality tools running instantly with zero configuration. Watch the Problems panel populate with real-time feedback.

**Push with Confidence:** When all local checks pass, push your code knowing that GitHub Actions will produce identical results. No more "works on my machine" - it works everywhere.

**Study the Patterns:** Explore `.github/workflows/` for GitHub Actions patterns, `.devcontainer/` for local development setup, and `.github/configs/` for the shared configurations that make it all work.

**Alternative Platforms:** Teams using Azure DevOps can leverage `.azuredevops/` templates and configs. The same principles apply - configuration consistency between local and remote.

