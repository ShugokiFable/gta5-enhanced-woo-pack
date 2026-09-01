# GTA V Enhanced — Woo Pack

A curated single-player modpack for **GTA V Enhanced** (Steam, build `1.0.1158.13`).

Everything is drag-and-drop: download **all** archive volumes, run `Install.bat`, done.
The pack mirrors the game folder structure, so you can also just extract and drop the contents
into `steamapps\common\Grand Theft Auto V Enhanced` manually.

> **Note:** this pack is **not** a full game. You need a legitimately owned copy of GTA V Enhanced.

---

## What's inside

- **Script mods** (ScriptHookVDotNet / SHV scripts) — single-player features, online-quality vehicles,
  interiors, jobs, quality-of-life tweaks. Full list with authors in [CREDITS.md](CREDITS.md).
- **Add-on maps & interiors** (26 DLC packs mounted via `onigiri`) — mansions, garages, farms, MLOs,
  character overhauls, plus NVE's 12 environment packs. All mounted through the
  [Onigiri](https://www.nexusmods.com/gta5enhanced/mods/688) overlay
  (`onigiri\common\data\dlclist.xml` is pre-configured).
- **Framework/quality ASIs** — heap & packfile limit adjusters, DirectStorage fix, decal patch,
  proper steering fix, blinker, Menyoo 2.3.1, SwapMainRide.
- **Graphics** — **NVE (NaturalVision Evolved)** with its ReShade preset, plus the **DLSS 5
  neural-rendering add-on** (RenoDX, latest NVIDIA Streamline runtimes). All included.

### NOT included (install separately)
- **Mods whose authors forbid redistribution** (StoreRobberyEnhanced, Modern Wood House,
  Bennys Motorworks Revamped) — install those from their original pages; see CREDITS.md.

---

## Installation

### Requirements
- GTA V Enhanced (Steam), updated to at least build `1.0.1158.13`
- [7-Zip](https://www.7-zip.org/) (to extract the volumes)

### Steps
1. Download **all** files from the release: every `WooPack-Core.7z.00x` volume plus `Install.bat`
   — keep them in the **same folder**.
2. Double-click `Install.bat`. It will:
   - find your game folder automatically (or let you point it there),
   - extract the archive,
   - copy the mods into the game folder (merge — never deletes game files).
3. Launch the game. The mods load with the game; check `ScriptHookVDotNet.log` for errors.

### Uninstall
Remove the files that `Install.bat` copied (or restore from Steam's "Verify integrity of game files" —
it will not touch mods, so delete them first). A backup of your clean install is recommended.

---

## Compatibility

- Target: **GTA V Enhanced** `1.0.1158.13` (July 2026 patch).
- Bundled: ScriptHookV `3889.0`, ScriptHookVDotNet Enhanced `1.1.0.6`, NVE (June 2026 "NEXT GEN
  UPDATE" build) and the DLSS 5 add-on.
- All 26 add-on packs are OPEN RPF7 archives, byte-identical to their source releases; they mount
  cleanly with the DirectStorage fix and limit adjusters included in this pack.

## Troubleshooting

| Symptom | Fix |
|---|---|
| Game loads forever into online/MP | Usually a broken DLC pack — disable packs one at a time in `onigiri\common\data\dlclist.xml` (comment out `<Item>` lines) |
| Scripts not loading | ScriptHookV missing or outdated — check `ScriptHookV.log`; the pack bundles SHV `3889.0`, so if this shows a build mismatch the game updated past `1.0.1158.13` |
| Black/blank web UI in Online Vehicles Shops | Install the mod's `scaleform_web.rpf` files into `onigiri\update\x64\patch\data\cdimages\scaleform_web.rpf\` |

---

## License & credits

This is a **modpack**: a curated collection of independently-authored mods. All mods remain the
property of their original authors — see [CREDITS.md](CREDITS.md) for the full list.
This pack is not affiliated with Rockstar Games, Take-Two, or any mod author.

If you are an author of an included mod and want it removed or credited differently,
open an issue or PR and it will be handled promptly.
