# Changelog

All notable changes to this repo are recorded here. Dates are in the user's local time (Asia/Shanghai).

## [Unreleased]

### Added

- `python/README.md`: how to use Python with the robot — auxiliary only (Python generates RAPID and automates; RAPID is the main subject).
- `skill/robot-rapid/skill.yaml`: skill metadata for Robot-RAPID, matching its `SKILL.md` frontmatter.
- `README_EN.md`: full English version of the README.
- `CONTRIBUTING.md`: how to ask questions and suggest content.
- `SECURITY.md`: safety notes for teaching code and real hardware.
- MIT License (`LICENSE`).

### Changed

- Repo renamed `abb-robot-programming` → `Robot-Skills` (2026-11-22): easier to remember and install. New install command: `npx skills add linxie654-netizen/Robot-Skills`. The old address redirects automatically.

### Fixed

- Removed version-pinned wording from the README and the skills (no more pinned RobotStudio / RobotWare version numbers); content is written generically, not split by version.

## [1.0.0] — 2026-11-21

First release: https://github.com/linxie654-netizen/Robot-Skills/releases/tag/v1.0.0

### Added

- Robot-RAPID skill (`skill/robot-rapid/`): the ABB robot mentor — 30 plain-language beginner lessons, 10 RAPID routines, 0-to-1 station pipeline, error handbook, simulation checklist, Smart Component guide.
- One-command install: `npx skills add linxie654-netizen/Robot-Skills` (verified working with the skills.sh CLI).
- RAPID routines `rapid/01`–`rapid/10`, Python examples `python/01`–`python/02`, RobotStudio tutorial, beginner roadmap, cheat sheet, comparison table.

## [0.1.0] — 2026-11-20

- Repo created; skill and library built up question by question from the ABB learning window.
