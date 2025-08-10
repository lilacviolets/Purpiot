# Purpiot: Null Movement & Rapid Trigger Script for AutoHotkey v2

Purpiot is an AutoHotkey v2 script designed to enhance in-game movement and control. It combines two core functions: **null movement** to prevent conflicting directional inputs and a **customizable rapid-fire function** for a specified key.

## Contents

* [Features](https://github.com/lilacviolets/Purpiot/tree/main%23features)

* [Installation and Usage]([https://www.google.com/search?q=](https://github.com/lilacviolets/Purpiot/tree/main%23installation-and-usage)

* [Customization]([https://www.google.com/search?q=](https://github.com/lilacviolets/Purpiot/tree/main%23customization)

* [Note]([https://www.google.com/search?q=](https://github.com/lilacviolets/Purpiot/tree/main%23note)

## Features

* **Null Movement:** This feature ensures that when you hold down two opposing directional keys (e.g., 'A' and 'D' or 'W' and 'S'), the script only sends the input for the last key pressed. This prevents a common issue in some games where holding both keys cancels all movement.

* **Rapid Trigger:** When you hold down the designated rapid-trigger key (by default, the 'X' key), the script will repeatedly send a key press at a customizable speed. This is useful for actions that require rapid tapping.

## Installation and Usage

1. **Install AutoHotkey v2:** If you don't already have it, download and install the latest version of AutoHotkey v2 from the official website.

2. **Save the Script:** Copy the script code and save it as an `.ahk` file (e.g., `Purpiot.ahk`).

3. **Run the Script:** Double-click the `.ahk` file to run the script. It will run in the background.

## Customization

You can easily modify the script to suit your needs.

* **Changing the Rapid Trigger Key:** To change the rapid-trigger key from 'X' to another key (e.g., 'C'), simply find the `X::` and `X Up::` lines in the script and replace `X` with your desired key.

* **Adjusting the Rapid Trigger Speed:** The rapid trigger speed is controlled by the number in the `SetTimer` function. By default, it is set to `10` milliseconds.

  ```
  SetTimer () => SendInput("{Blind}{x}"), 10
  
  ```

  A smaller number will make the rapid trigger faster, and a larger number will make it slower.

## Note

This script is intended for use in games where it is permitted. Please ensure you are not violating any terms of service by using this script.
