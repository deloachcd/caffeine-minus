# caffeine-minus
## Port of 'Caffeine' from Windows/macOS as a KDE plasmoid

This is a button that allows the user to keep the screen unlocked 
temporarily while active from the taskbar. It's a really simple,
but useful application.

### Why yet another port of Caffeine for Linux?
Because every other port of Caffeine is too complicated for my taste.
This is the caveman version of the software, it just fakes pressing
the "Pause/Break" key at a user-defined interval defaulting to just
under a minute.  No Python, no CMake, no integration with other
applications, it just keeps the screen alive when you click it in the
taskbar, and stops when you click it again.

### Dependencies
There is a single dependency, depending on the display server utilized:
- `xdotool` for X11
- `wtype` for wayland
It is automatically installed with the provided `setup.sh` script.

### Installation
```
./setup.sh install
```

If you decide this thing actually sucks, it's no problem:
```
./setup.sh uninstall
```
Install this plasmoid using `plasmapkg2 --install .` in the plasmoid directory.

### Credits
  - https://github.com/pmarki/plasmoid-button
  - https://github.com/neicker/on-off-switch
  - https://github.com/MakG10/plasma-applet-server-status
 
This is a repurposed fork of Piotr Markiewicz's 'Configurable Button' plasmoid,
whom I am greatly thankful for in saving me from having to actually learn much
qt/plasma to make this.
