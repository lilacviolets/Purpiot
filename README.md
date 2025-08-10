# Purpiot: Null Movement Script for AutoHotkey v2

Purpiot is an AutoHotkey v2 script designed to improve in-game movement by preventing conflicting directional inputs. It ensures that only the last pressed key between opposing directions is registered, avoiding common movement cancellation issues in some games.

## Contents

- [Features](#features)  
- [Installation and Usage](#installation-and-usage)  
- [Customization](#customization)  
- [Note](#note)  

## Features

- **Null Movement:** When you hold two opposing directional keys (e.g., `A` and `D` or `W` and `S`), the script only sends input for the last key pressed. This avoids the problem where holding both cancels movement entirely.

## Installation and Usage

1. **Install AutoHotkey v2:** Download and install the latest AutoHotkey v2 from the official site if you haven’t already.

2. **Save the Script:** Copy the Purpiot script code and save it as a `.ahk` file (e.g., `Purpiot.ahk`).

3. **Run the Script:** Double-click the `.ahk` file to run it in the background.

## Customization

- **Modify Directional Keys:** The script uses standard WASD keys by default. You can edit the scan codes or keys inside the script to fit your setup or preferences.

- **Adjust Script Behavior:** For advanced users, you can tweak timing, input methods (`SendInput`), or extend functionality by editing the script directly.

## Note

Use this script responsibly and ensure it complies with the terms of service of the game or software where you apply it.
