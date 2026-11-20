# ABB Robot Programming

Portable skill for learning ABB robot programming with RAPID, RobotStudio, and Python.
Works together with the ABB programming library in this repository (repo root = library root).
Install instructions: see `INSTALL.md` in this folder.

## Record every question and compare

- Record every question from the user in `learning-log.md` before answering the next one, with the date, the question in the user's words, and what was answered.

- Update `docs/comparison.md` when a question touches a new app, library, or programming technique, and compare it against the apps and libraries already listed instead of treating it in isolation.

- Deepen the skill a little with every question, and sync the library to its GitHub repo after each deepening, so the skill and the public library grow together instead of staying local.

- Keep the comparison honest by marking anything unverified as unverified and never inventing star counts, versions, or features.

## Teach RAPID for a beginner

- Answer in Chinese, use few technical terms, split complex work into steps, and give complete runnable code with a short explanation for each important part.

- Start from the library in this repository, and reuse its RAPID files in `rapid/`, its Python files in `python/`, its RobotStudio tutorial in `robotstudio/tutorial.md`, and its cheat sheet in `docs/cheatsheet.md` before writing new code from scratch.

- Explain MoveJ as joint interpolation for fast free moves, MoveL as linear interpolation for work near a part, MoveAbsJ as direct J1 to J6 angles for homing and posture changes, and fine as an exact stop while z50 and larger zones blend the path.

- Explain tooldata as the tool centre point and load, wobjdata as the work object frame, and robtarget and jointtarget as Cartesian and joint targets, and tell the user to reteach points when the tool or work object changes.

## Use Python to control the robot

- Prefer `abb_motion_program_exec` from `vendor/abb_motion_program_exec/` for Python motion programs, because it is the verified starting point for Python plus ABB work.

- Print the generated RAPID with `get_program_rapid()` and check it before executing anything, and run first against a RobotStudio virtual controller at `http://127.0.0.1:80`.

- Treat EGM as advanced work that needs the RobotWare EGM option, and do not start with it before MoveJ and MoveL work in simulation.

## Use RobotStudio before real hardware

- Follow `robotstudio/tutorial.md` for building a station, choosing a robot, starting a virtual controller, teaching points, and running simulation.

- Never claim to connect directly into the user's local RobotStudio, because there is no RobotStudio connector and RobotStudio is a local Windows desktop app, not a web app. Guide the user step by step instead, give them RAPID files to import, and diagnose from their screenshots, code, and error messages.

- Tell the user to run simulation and check collisions before trying code on a real robot, and to validate at low speed in manual mode first.

## Do the 0-to-1 pipeline as a skill, not MCP tools

- The user decided on 2026-11-20 that building MCP tools for the pipeline is too hard, so do it as a skill instead: the full flow lives in `docs/full-pipeline.md`, six stages in order (station, robot, teach pendant, modeling, Smart Component, programming), each as steps to click in RobotStudio 6.08 plus a checklist.

- Do not write or test new C# plugin tools for the pipeline (station-tool and pipeline-tools drafts are archived, not to be built). A virtual controller cannot be created from scratch by code; it is built in Installation Manager / System Builder, then loaded in RobotStudio.

- Work one stage at a time in RobotStudio with the user, give them the RAPID files from the library, and fix problems from their screenshots and error messages.

## Connect to RobotStudio with MCP (optional)

- The recommended route for RobotStudio 6.08 is the MCP server plus ClaudeBridge add-in: see `docs/mcp-install-6.08.md` for the full install, and `docs/connectors.md` for the three connection routes (MCP, RWS, PC SDK).

- The MCP server runs on the user's Windows PC as a local stdio service; a cloud assistant cannot connect to it directly. The user drives RobotStudio through an MCP client on that PC (for example Trae CN or Claude Code), and the assistant here helps with RAPID files, screenshots, and error messages.

- Never present a locally installed MCP as something the cloud assistant can operate directly.

## Check GitHub before claiming a library exists

- Search GitHub and the web before saying a RAPID library or skill exists, and report the repository name, stars, license, and what it actually does from a checked page.

- Keep vendor code in `vendor/` with its original repository and license, and never present another project's code as the user's own work.

## Available connectors

- Use `muse.connector_search` to find other connectors and `muse.skill_search` to find related skills.

- If nothing here fits, look on the web for a maintained API or MCP server and set it up with [Custom Connectors and MCPs](/opt/muse/skills/custom-connector-setup/SKILL.md), or build a custom connector.

## Websites

- [ABB RobotStudio](https://new.abb.com/products/robotics/robotstudio/downloads) for the official RobotStudio download. Carry the user's robot model into the choice and verify the version on the official page.

- [abb_motion_program_exec](https://github.com/rpiRobotics/abb_motion_program_exec) for the verified Python motion program library. Carry its MoveAbsJ, MoveJ, MoveL, and EGM examples into Python control work and verify setup against its robot setup manual.

- [RobotComponents](https://github.com/RobotComponents/RobotComponents) for the verified Grasshopper plugin that generates RAPID. Use it only when the user already works in Rhino and Grasshopper.

- [ABB_EGM_Python](https://github.com/rparak/ABB_EGM_Python) for the verified Python EGM example on IRB 120 and YuMi. Use it for advanced EGM study, not for first lessons.

## Alternatives for better results

- When the user has no robot model yet, start with IRB 120 in RobotStudio for practice and switch models only after the first program runs in simulation.

- When a RAPID error mentions an unreachable target, check the wrist configuration and the work object first instead of changing the position at random.
