# Python Standards (Practicum Code)

## Environment
- **Package Manager:** UV only (not pip, conda, or virtualenv)
- **Config:** `pyproject.toml`

## Quick Reference
```bash
uv init my-analysis && cd my-analysis
uv add numpy pandas mne
uv run python analysis.py
uv run pytest
```

## Style
- Formatter: `ruff format`
- Linter: `ruff check --fix`
- Type hints on all public functions

## Never Do This
- Never `pip install`; use `uv add`
- Never use `os.path`; use `pathlib.Path`
- Never bare `except:` or silent `pass`
- Never commit `.env` or hardcoded credentials

---
*UV for everything. Ruff for style. Real data for tests.*
