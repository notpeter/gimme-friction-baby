# gimme-friction-baby

Disassembled Source code for Gimme Friction Baby,
a shockwave flash game by Wouter Visser.

## What is Gimme Friction Baby

Originally created for Jay is Games Casual Gameplay Design Competition 3 (CGDC3)
in July 2007 Gimme Friction was the First Place Winner and recipient of the Audience Award.

## Source

The source for this repo is the [gimmefriction.swf](gimmefriction.swf) branded as gimmefivegames.com.
I'm not sure this was an authorized rip, but it lacked the the anti-copy/
multi-file dependencies present on JayIsGames which meant it was widely distributed.
The resulting swf was playable by embedding the swf object or with the stand alone nativeflash player.

## Dissassembly

Process: I ran gimmefriction.swf run through FFDec, the
[JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler),
version [15.1.0](https://github.com/jindrapetrik/jpexs-decompiler/releases/tag/version15.1.0)
although [latest](https://github.com/jindrapetrik/jpexs-decompiler/releases/latest) should work.


## Results

All of the Game code is within [scripts/frame_10/DoAction.as](scripts/frame_10/DoAction.as).

## Play Online Today

With the advent of [Ruffle](https://github.com/ruffle-rs/ruffle) the game is again
playable on the web leveraging webassembly without requiring the legacy flash player
on a number of sites:

* https://archive.org/details/gimmefrictionbaby_flash
* http://www.addictinggames.com/gimmefrictionbaby.html
* https://www.engineering.com/GamesPuzzles/GimmeFrictionBaby/tabid/4711/Default.aspx
