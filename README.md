# ramspeed

A simple application for calculating RAM speed and latency.

## How to use

Dead simple. Just open the app, fill in the data (with some help from the app if needed, just click on the button with the "i" icon), and voila!

## Building

Clone the repo

    git clone https://github.com/Hacker-Anirudh/ramspeed.git

---

Choose whether to build Material (Google) or Cupertino (Apple) style:

Cupertino

    flutter build [platform] -t lib/main_cupertino.dart --release

---

Material

    flutter build [platform] -t lib/main_material.dart --release

---

You will find the binary in the directory 'build'.

## Architecture
RAMspeed is built with a slightly unusual architecture. There is two main files for Material and Cupertino at the project root (lib/), both with very little code. Then, most of the code is located in:

- cupertino_ui: Contains the Cupertino app's UI code.
- material_ui: Contains the Material app's UI code.
- shared: Contains some shared logic and strings.

This permits two version of the app to be built without causing any bloat, but still permitting some code reuse.
