# Kaffeine
## Port of 'Caffeine' from macOS to KDE

This is a button that allows to run script when toggled (on and off scripts)
and to monitor status by status script.

### Why yet another port of this?
Because the other port of this for KDE is too complicated for my taste.
This is the caveman version of that, because I don't need it to do anything
besides just keep the screen unlocked when I click on it.

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
