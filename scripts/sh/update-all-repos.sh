#!/bin/bash

# Update all git repositories in the current directory
# Logic:
# 1. If on main branch → git pull
# 2. If not on main but no pending changes → switch to main and git pull
# 3. If not on main and has pending changes → warn and skip

set -e

for dir in */; do
  # Remove trailing slash
  repo="${dir%/}"
  
  # Skip if not a git repository
  if [ ! -d "$repo/.git" ]; then
    continue
  fi
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Processing: $repo"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  
  cd "$repo"
  
  # Check if HEAD exists (repo has commits)
  if ! git rev-parse HEAD >/dev/null 2>&1; then
    echo "⚠ Empty repository (no commits) - skipping"
    cd ..
    echo ""
    continue
  fi
  
  # Get current branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  
  # Check for uncommitted changes
  if [ -n "$(git status --porcelain)" ]; then
    has_uncommitted=true
  else
    has_uncommitted=false
  fi
  
  # Check for unpushed commits
  has_unpushed=false
  if git rev-parse @{u} >/dev/null 2>&1; then
    if [ -n "$(git rev-list @{u}..HEAD 2>/dev/null)" ]; then
      has_unpushed=true
    fi
  fi
  
  if [ "$current_branch" = "main" ]; then
    echo "✓ On main branch"
    echo "  Running: git pull"
    git pull
    echo "  ✓ Updated successfully"
  elif [ "$has_uncommitted" = false ] && [ "$has_unpushed" = false ]; then
    echo "⊘ Not on main branch (on: $current_branch)"
    echo "  No pending changes detected"
    echo "  Running: git checkout main && git pull"
    git checkout main
    git pull
    echo "  ✓ Switched to main and updated successfully"
  else
    echo "⚠ Not on main branch (on: $current_branch)"
    echo "  Pending changes detected - skipping"
    if [ "$has_uncommitted" = true ]; then
      echo "    • Uncommitted changes"
    fi
    if [ "$has_unpushed" = true ]; then
      echo "    • Unpushed commits"
    fi
  fi
  
  cd ..
  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "All repositories processed!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
