<div align="center">

# 🤖 Robot Skills Library

<img src="assets/cover.png" alt="ABB industrial robot" width="720">

**Robot-Skills makes your AI better at writing RAPID.**

![RAPID](https://img.shields.io/badge/RAPID-10%E4%BE%8B%E7%A8%8B-blue)
![RobotStudio](https://img.shields.io/badge/RobotStudio-green)
![Skill](https://img.shields.io/badge/Skill-Robot--RAPID-orange)
![Language](https://img.shields.io/badge/%E8%AF%AD%E8%A8%80-%E4%B8%AD%E6%96%87-red)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-Standard-green)](https://agentskills.io)
[![skills.sh](https://img.shields.io/badge/skills.sh-Compatible-blue)](https://skills.sh/linxie654-netizen/Robot-Skills/robot-rapid)
[![Runtime](https://img.shields.io/badge/Runtime-All%20AI%20Agents-blueviolet)](#install-in-3-steps)

[🚀 Install in 3 steps](#install-in-3-steps) · [📖 Beginner roadmap](docs/beginner-roadmap.md) · [⚡ Cheat sheet](docs/cheatsheet.md) · [🔍 Comparison](docs/comparison.md)

</div>

> 中文版见 [README.md](README.md) (Chinese version).

| Write code | Simulate | Smart Components | Keep learning |
|---|---|---|---|
| RAPID, correct and fast, 10 routines to practice with | Run it in a virtual controller first, check collisions | Build a station in 6 stages, modeling and components included | Every question is recorded, the skills grow with each question |

Chinese, step by step, complete runnable code with each important part explained. Goal: Python + PLC + ABB robots working together for industrial automation.

> A beginner asks: "I'm a beginner, where do I start learning ABB?" — the assistant starts you on `rapid/01_move_basics.mod`: run it in a RobotStudio virtual controller first, then verify again with a different position. Simulate first, never run a program that hasn't been simulated.

## 🗺️ Capability map: what you want to do, where to look

| You want to | Open | You get |
|---|---|---|
| Write RAPID code | `skills/robot-rapid/references/rapid-patterns.md` + `rapid/` | 9 common patterns, copy and change the positions |
| Program errors / won't run | `skills/robot-rapid/references/troubleshooting.md` | Error lookup table, locate first, then fix |
| Build Smart Components | `skills/robot-rapid/references/smart-components.md` | Step by step, signals, logic, and actions explained |
| Simulate / check | `skills/robot-rapid/references/simulation-checklist.md` | Checklist, tick all boxes before running |
| Build a station from 0 to 1 | `docs/full-pipeline.md` | Full 6-stage flow, click through it |
| Where a beginner starts | `docs/beginner-roadmap.md` | 15-lesson roadmap + 6 common mistakes |
| Control the robot with Python | `python/01_move_joints.py` | Print the RAPID first, check it, then run it |
| Write Python code | `python/README.md` | How to use Python with the robot: setup, two examples, the safe workflow |
| Questions asked before | `skills/robot-rapid/references/learned.md` | Question → answer → why, ready to use |

---

## ✨ What the skill does

One skill lives in this repo: **Robot-RAPID** (folder `robot-rapid`).

Install it, and your assistant teaches you the ABB way:

1. **Write RAPID code**: MoveJ / MoveL / MoveAbsJ, IO, loops, coordinate systems, arcs, error handling, 10 routines to practice with.
2. **Build a station from 0 to 1**: station → robot → teach pendant → modeling → Smart Components → programming, 6 stages step by step.
3. **Simulate first**: every program runs in a RobotStudio virtual controller and passes a collision check before low-speed manual validation.
4. **Python can drive the robot too**: send commands with `abb_motion_program_exec`, print the RAPID first, check it, then run it.
5. **It keeps learning**: every question you ask is recorded and the skill grows a little, so the library and the skill grow together.

> Not an official ABB tutorial. A teaching version rewritten from official syntax and the consensus of several beginner tutorials. Positions are teaching values; reteach them in simulation.

---

## 🚀 Install in 3 steps

**Step 1: one command to install a skill (recommended, same as other skills)**

```bash
npx skills add linxie654-netizen/Robot-Skills
```

Requires Node.js 22.20 or newer. The command finds the skills in the repo and asks which assistant to install to (Claude Code, Cursor, Codex, Windsurf, OpenClaw, Trae, Copilot, or any assistant that supports the Agent Skills standard). Install was tested 2026-11-20 under the previous repo name; re-tested 2026-11-22 with the new name and works.

**Step 2: prefer manual install?**

Clone the repo:

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
```

No git? Open the link above, click the green `Code` → `Download ZIP`, and unzip. Then copy the skill into your assistant. Supports all AI model agents: any AI coding assistant that supports the Agent Skills standard can use it.

| Your assistant | Copy command |
|---|---|
| Muse | `cp -r Robot-Skills/skills/robot-rapid ~/workspace/custom-skills/robot-rapid` |
| Claude Code | `cp -r Robot-Skills/skills/robot-rapid ~/.claude/skills/robot-rapid` |
| Other assistants (Cursor, Codex, Windsurf, OpenClaw, Trae, Copilot, etc.) | Send the full text of `skills/robot-rapid/SKILL.md` to it, or save it in a skill directory it supports |

**Step 3: ask your first question**

Ask in your assistant, for example:

> I'm a beginner, where do I start learning ABB?

It will follow the skill and start you on `rapid/01_move_basics.mod`.

**To run simulations you also need RobotStudio**: free download from [ABB's website](https://new.abb.com/products/robotics/robotstudio/downloads). Build a station with `robotstudio/tutorial.md`. No robot model decided yet? Practice with IRB 120 first.

---

## 🌐 Community and listings

### Published

| Channel | Link |
|---|---|
| GitHub repo | https://github.com/linxie654-netizen/Robot-Skills |
| Release v2.1.0 | https://github.com/linxie654-netizen/Robot-Skills/releases/tag/v2.1.0 |

### Submitted / pending

| Channel | Status | Note |
|---|---|---|
| Skill Harbor | Submitted, under review | Free listing, published after review, up to 72 hours |

---

## 📂 Directory

- `rapid/` — RAPID teaching routines (rewritten from official syntax, not copied)
  - `01_move_basics.mod` — MoveJ / MoveL / MoveAbsJ basics
  - `02_pick_place.mod` — Pick and place, gripper IO
  - `03_io_signals.mod` — Digital IO, waiting for signals, SetDO / WaitDI
  - `04_loops_conditions.mod` — IF, FOR, WHILE, counting
  - `05_coordinates.mod` — Tool tooldata, work object wobjdata, frames
  - `06_joint_move.mod` — J1–J6 joint motion, jointtarget
  - `07_move_circle.mod` — MoveC arcs
  - `08_test_case_functions.mod` — TEST/CASE + FUNC return values
  - `09_error_handling.mod` — ERROR handling, RAISE
  - `10_analog_io_wait.mod` — Analog IO, WaitUntil
- `python/` — Python-to-robot examples (using `abb_motion_program_exec`)
  - `01_move_joints.py` — Python sends MoveAbsJ
  - `02_pick_place.py` — Python sends MoveJ/MoveL pick and place
  - `03_pybullet_arm.py` — PyBullet six-axis demo (KUKA iiwa built-in model, joint error 0.0 degrees)
  - `requirements.txt` — All versions pinned (abb-motion-program-exec 0.7.4, numpy 1.26.4, pybullet 3.2.7)
  - `README.md` — How to use Python with the robot
- `robotstudio/` — RobotStudio tutorial
  - `tutorial.md` — Build a station, pick a robot, virtual controller, teaching, simulation, step by step
- `docs/` — Cheat sheets and comparisons
  - `beginner-roadmap.md` — 15-lesson beginner roadmap (consensus of online tutorials)
  - `cheatsheet.md` — RAPID cheat sheet
  - `comparison.md` — Comparison table of online apps and libraries
  - `full-pipeline.md` — 0-to-1 pipeline in 6 stages (Skill version)
  - `advanced-topics.md` — Advanced lessons: EGM, multitasking, external axes (plain language)
  - `teaching-guide.md` — How the eight teaching modes work
  - `exam-practice.md` — 35 practice questions
  - `progress-tracker.md` — Learning progress table
  - `3d-simulation-research.md` — Three.js, PyBullet, URDF research
  - `threejs-arm-demo.html` — Browser six-axis demo (single file)
  - `evals.md` — Same prompt, with skill vs without skill
  - `spray-painting.md` — Spray painting: PaintL, SetBrush, brush tables
  - `promotion/` — Promotion copy for each channel (Reddit/X in English, Zhihu/Juejin in Chinese, Bilibili script)
- `skills/robot-rapid/` — ABB skill Robot-RAPID
  - `SKILL.md` — Skill text (RAPID, 0-to-1 pipeline)
  - `INSTALL.md` — Install guide (Muse / Claude Code / other assistants)
  - `skill.yaml` — Skill metadata
  - `references/` — Learned lessons, error handbook, common patterns, Smart Components, simulation checklist
    - `beginner-lessons.md` — 30 plain-language lessons, each ending with "what counts as learned"
    - `learned.md` — Lessons learned (question → answer → why) + sealed quiz questions
    - `rapid-patterns.md` — 9 common RAPID patterns
    - `troubleshooting.md` — Error lookup table + anti-patterns
    - `smart-components.md` — How to build Smart Components
    - `simulation-checklist.md` — Pre-simulation checklist + evidence rules
    - `glossary.md` — Glossary, one line per term
- `learning-log.md` — Record of every question asked, kept up to date
- `vendor/` — Reference sources pulled in for study (other people's projects, original repos and licenses kept)
  - `abb_motion_program_exec/` — rpiRobotics, Apache-2.0
  - `ABB_EGM_Python/` — rparak, MIT
  - `Hershey-ABB-Robot-Handwriting/` — FLo-ABB, MIT

## ✅ First steps to get running

1. Install RobotStudio (free download from ABB).
2. Build a station with `robotstudio/tutorial.md`, pick a robot (no model decided yet? practice with IRB 120).
3. Run `rapid/01_move_basics.mod` on a virtual controller.
4. Run `python/01_move_joints.py` to see how Python sends commands.
5. Run everything in simulation and check speed, zones, and tools.

## ⚠️ Safety notes

- EGM control needs the options from the ABB manual. Never try an un-simulated program.
- Positions and speeds in this library are teaching values. Reteach them for your own workpieces and grippers.

## Known limitations (cross one off when fixed)

- The welding, conveyor-tracking, and multi-robot projects are skeletons; their special instructions are still to be added from the manuals.
