# GNU screenrc Manual

## Always enable scrollwhell in GNU screen

When using mouse whell in GNU screen, screen interprets it as a up/down arrow key, not a scrollwheel.

### Archived:

From the [reference](https://stackoverflow.com/questions/359109/using-the-scrollwheel-in-gnu-screen):

- [Pistos](https://stackoverflow.com/users/28558/pistos)
- [Lekensteyn](https://stackoverflow.com/users/427545/lekensteyn)

I believe you can just add a line like this to your ~/.screenrc:

termcapinfo xterm* ti@:te@

Where "xterm*" is a glob match of your current TERM. To confirm it works, ^A^D to detach from your screen, then screen -d -r to reattach, then ls a few times, and try to scroll back. It works for me.

What is this magic? Well, let's consult the manual pages.

screen(1) says:

termcapinfo term terminal-tweaks [window-tweaks]
  [..]
  The first argument specifies which terminal(s) should be affected by this
  definition. You can specify multiple terminal names by separating them with
  `|'s. Use `*' to match all terminals and `vt*' to match all terminals that
  begin with "vt".
  [..]
  Some examples:

      termcap xterm*  LP:hs@

  Informs screen that all terminals that begin with `xterm' have firm
  auto-margins that allow the last position on the screen to be updated (LP),
  but they don't really have a status line (no 'hs' -  append  `@'  to turn
  entries off).  Note that we assume `LP' for all terminal names that start
  with "vt", but only if you don't specify a termcap command for that terminal.

From termcap(5):

String capabilities
    [..]
    te   End program that uses cursor motion
    ti   Begin program that uses cursor motion



## Prevent GNU screen from resizing terminal to 80 columns in some terminal emulators

In some SSH client and terminal emulators, such as SecureCRT, GNU screen always resizes terminal to the 80 columns.

Putting archived answers prevents this problem.

### Archived:

From the [reference](https://superuser.com/questions/217066/prevent-gnu-screen-from-resizing-display-size):

#### [Dennis Williamson](https://superuser.com/users/310/dennis-williamson)

Try adding this (from /etc/screenrc) to your ~/.screenrc:

```
# Change the xterm initialization string from is2=\E[!p\E[?3;4l\E[4l\E>
# (This fixes the "Aborted because of window size change" konsole symptoms found
#  in bug #134198)
termcapinfo xterm* 'is=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;4;6l'
```

You may need to change the "xterm" to match your $TERM.

The termcapinfo line sets is (ininitialization string) for any terminal with a name starting with "xterm" to a sequence of escape codes. \E represents escape and the codes are as follows:

```
\E[r       - set scrolling region to default (full size of window)
\E[m       - reset all resources (keyboard) to their initial values
\E[2J      - Erase in Display (ED). 2 -> Erase All.
\E[H       - set cursor position to default (1, 1)
\E[?7h     - DEC Private Mode Set. 7 -> Wraparound Mode
\E[?1;4;6l - DEC Private Mode Reset. 1 -> Normal Cursor Keys; 4  -> Jump (Fast) Scroll; 6 -> Normal Cursor Mode
```

The replaced line had these codes:

```
\E[!p      - Soft terminal reset
\E[?3;4l   - DEC Private Mode Reset. 3 -> 80 Column Mode; 4 -> Jump (Fast) Scroll
\E[4l      - Reset Mode. 4 -> Replace Mode
\E>        - Normal keypad
```

#### [Thomas Dickey](https://superuser.com/users/441480/thomas-dickey)

The explanation (and suggested equivalents) for the xterm initialization string aren't completely accurate.

Starting with the string from xterm's terminal description:

```
is2=\E[!p\E[?3;4l\E[4l\E>
```

we have

```
CSI ! p   Soft terminal reset (DECSTR).
CSI ? Pm l
      DEC Private Mode Reset (DECRST).
...
        Ps = 3  -> 80 Column Mode (DECCOLM).
        Ps = 4  -> Jump (Fast) Scroll (DECSCLM).
CSI Pm l  Reset Mode (RM).
...
        Ps = 4  -> Replace Mode (IRM).
ESC >     Normal Keypad (DECKPNM).
```

But DECSTR resets several things not found in the replacement:

- the cursor shape and appearance
- character sets
- other keyboard modes related to application/normal modes (DECCKM, KAM, DECKPAM)
- wraparound (and reverse wraparound)
- origin mode

Also, it doesn't clear the screen.

The reason for using DECSTR (since 1997) is to keep termcap sizes small enough to fit in termcap's 1024-byte limit.

The setting for screen is from the Debian package; the bug report mentioned in the comment is Debian #134198 — screen: has some sort of odd emulation problem most noticable with irssi and konsole, from 2002. screen does not recognize that sequence, and incidentally, KDE konsole does not implement that sequence, as seen in KDE #134892, while at the same time its developers state in KDE #145977 that they prefer to not use a different TERM value than xterm. Since some users might want a terminal description which does match konsole's capabilities, that's in ncurses as konsole, e.g.,

```
is2=\E[m\E[?7h\E[4l\E>\E7\E[r\E[?1;3;4;6l\E8
```

versus

```
is2=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;4;6l
```

Removing the spurious clear-screen, the relevant portion of screen's customization is

```
is2=\E[r\E[m\E[?7h\E[?1;4;6l
```

so what was left out was (aside from DECCOLM) \E[4l.

The \E7 and \E8 in the initialization string save/restore the cursor position when adjusting the scrolling margins. Just like the insert-mode, some users would notice the absence of the feature.

The point of the customization is to suppress the DECCOLM (80/132 column) switching, and working from screen's cut-down and rather old customization might not work as well as adapting from a terminal description written for the terminal.

Further reading:

- XTerm Control Sequences
- VT220 Programmer Reference Manual

