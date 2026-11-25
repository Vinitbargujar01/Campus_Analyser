#!/usr/bin/env bash
# One-command launcher: sets up the environment on first run, then starts the dashboard.
set -e
cd "$(dirname "$0")"
if [ ! -d .venv ]; then
  python3 -m venv .venv
  .venv/bin/pip install --upgrade pip
  .venv/bin/pip install -r requirements.txt
  .venv/bin/pip install -e .
fi
if [ ! -f data/campus.db ]; then
  .venv/bin/python scripts/run_pipeline.py
fi
# Headless mode skips Streamlit's first-run email prompt; open the browser ourselves.
(sleep 4 && open "http://localhost:8501" 2>/dev/null || true) &
exec .venv/bin/streamlit run apps/Dashboard.py --server.headless true --browser.gatherUsageStats false "$@"
