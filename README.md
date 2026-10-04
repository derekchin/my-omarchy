# Omarchy, with macOS habits

Personal config for an [Omarchy](https://omarchy.org/) install that keeps macOS keyboard habits and [AeroSpace](https://github.com/nikitabobko/AeroSpace) window management.

Tested on Omarchy 4.0.4, Hyprland 0.56.2, and keyd 2.6.0. The keyboard is a Foostan Corne v4. The thumb key in the Command position sends Super/Meta, and keyd turns that into Control chords.

No license is set yet. Add one before treating this as reusable.

## What it does

### The thumb key is Control

`leftmeta` and `rightmeta` enter a keyd `cmd` layer. Holding that key and pressing A, C, V, X, Z, S, F, W, T, or Q sends the Ctrl chord Linux apps expect. Caps Lock is the same key. Command+Left and Command+Right go to the start and end of the line.

In a terminal, Command+C and Command+V become Ctrl+Shift+C and Ctrl+Shift+V. Ghostty also gets Command+T, Command+W, and the brace keys as tab switching.

### Super is Ctrl+Alt+Shift

Meta never reaches Hyprland, because keyd owns it. Hold Ctrl+Alt+Shift, then the key you would have pressed with Super. keyd also emits Meta for that chord, and Hyprland binds the chord itself so the action still runs when the translation does not.

Close the focused window with Ctrl+Alt+Shift+W. The same chord opens a terminal (Return), the Omarchy menu (Space or `/`), a workspace (1–9), and the usual focus, fullscreen, float, scratchpad, and layout keys.

Super+Shift shortcuts cannot be typed this way. Shift is already part of the stand-in.

### Window management follows AeroSpace

Alt runs the window actions. Omarchy's Super workspace and arrow-focus bindings stay. Super move and resize bindings are removed.

| Keys | Action |
| --- | --- |
| Alt+H / J / K / L | Focus left / down / up / right |
| Alt+Shift+H / J / K / L | Swap in that direction |
| Alt+1–9 | Switch workspace |
| Alt+Shift+1–9 | Move the window there without following |
| Alt+Tab | Previous workspace |
| Alt+- / Alt+= | Shrink or grow width. Same direction on the left and the right. |
| Alt+, | Maximize. The bar and gaps stay. |
| Alt+/ | Restore the tiled layout |
| Alt+; | [OmaKeys](https://github.com/maietta/omakeys) click hints |
| Alt+Shift+; | OmaKeys grid |

`bin/hypr-resize-smart` exists because a Hyprland resize delta grows a window on one side of a split and shrinks it on the other. The bindings force the width axis. The script can also do `smart`, `height`, and `smart-opposite`.

Hyprland has no AeroSpace accordion layout. Maximize fills the work area and hides the other tiled windows until restore.

## Layout

```
keyd/default.conf     # /etc/keyd/default.conf
keyd/app.conf         # ~/.config/keyd/app.conf
hypr/bindings.lua     # ~/.config/hypr/bindings.lua
hypr/autostart.lua    # ~/.config/hypr/autostart.lua
bin/hypr-resize-smart # ~/.local/bin/hypr-resize-smart
archive/bindings.conf # old app-launcher map, not loaded
```

Paths in the Lua files use `$HOME/.local/bin`.

## Install

On a fresh Omarchy system these user files are still the stock templates, so copying them over is enough. Merge them if you already have your own bindings or autostart lines.

```bash
sudo pacman -S --needed keyd jq
sudo cp keyd/default.conf /etc/keyd/default.conf
mkdir -p ~/.config/keyd ~/.local/bin
cp keyd/app.conf ~/.config/keyd/app.conf
install -m 755 bin/hypr-resize-smart ~/.local/bin/hypr-resize-smart
cp hypr/bindings.lua ~/.config/hypr/bindings.lua
cp hypr/autostart.lua ~/.config/hypr/autostart.lua
sudo systemctl enable --now keyd
sudo keyd reload
hyprctl reload
```

OmaKeys is separate. Build [maietta/omakeys](https://github.com/maietta/omakeys) and install the release binary as `~/.local/bin/omakeys`. The autostart line starts `omakeys daemon` with Hyprland. Skip that line, and the Alt+; binds, if you do not want it.

`hyprctl configerrors` should print nothing after the reload.

## Left out on purpose

These are on this machine and are not part of the macOS-style setup:

- Monitor scale. `~/.config/hypr/monitors.lua` sets GDK scale and compositor scale to 2 for a TV used as the display.
- Ghostty font, padding, and scroll settings.
- OpenDeck profiles for a Stream Deck.

## Archive

`archive/bindings.conf` is the pre-Lua launcher map. It bound Terminal, browser, files, mail, and chat to Ctrl and Ctrl+Shift so the thumb key could launch them. Omarchy 4 loads `hyprland.lua` and does not read that file. Those launchers are not active. The file lists personal apps and sites. Remove it if you publish this repo and do not want that list public.
