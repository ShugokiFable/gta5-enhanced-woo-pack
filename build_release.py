#!/usr/bin/env python3
"""Build the Woo Pack release volumes (7z, split ~1900MB for GitHub's 2GiB cap).

Exclusions (never ship):
  - game binaries (Rockstar's own files)
  - _DLSS5_Backup (restore stash of pre-mod originals)
  - logs / pdb debug symbols

Everything else in the pack ships: NVE, DLSS5/Streamline, ReShade, SHV, SHVDN, scripts, DLC packs.
Usage: python build_release.py [pack_dir] [out_dir]
"""
import os
import shutil
import subprocess
import sys
from pathlib import Path

SZ = shutil.which("7z") or r"C:\Program Files\7-Zip\7z.exe"
PACK = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(r"Z:\Backup\GTA 5\Enchanced\Grand Theft Auto V Enhanced Woo Pack")
OUT = Path(sys.argv[2]) if len(sys.argv) > 2 else Path(r"Z:\Backup\GTA 5\Enchanced\publish")
VOL = OUT / "WooPack-Core.7z"

# Game binaries (Rockstar) — never redistribute.
GAME_DLLS = (
    "amd_ags_x64.dll", "amd_fidelityfx_dx12.dll", "bink2w64.dll",
    "dstorage.dll", "dstoragecore.dll", "fvad.dll",
    "GFSDK_Aftermath_Lib.x64.dll", "libcurl.dll", "libtox.dll",
    "oo2core_5_win64.dll", "opus.dll", "opusenc.dll",
    "steam_api64.dll", "XCurl.dll", "zlib1.dll",
)
# License-restricted mods (authors forbid redistribution) — never ship even if re-synced.
NO_REDIST = ("StoreRobberyEnhanced", "modern_wood_house_1a", "BennysMotorworksRevamped", "BennysMapLoader")
EXCL = ["-xr!*_DLSS5_Backup*", "-xr!*.log", "-xr!*.pdb"] + [f"-xr!*{d}" for d in GAME_DLLS] + [f"-xr!*{n}*" for n in NO_REDIST]

def main() -> None:
    for vol in OUT.glob("WooPack-Core.7z.*"):
        vol.unlink()
    print(f"pack: {PACK}  ->  {VOL}.001 ...")
    r = subprocess.run([SZ, "a", "-t7z", "-mx=5", "-v1900m", str(VOL), str(PACK), *EXCL])
    if r.returncode:
        sys.exit(r.returncode)
    sizes = [f"{p.name}: {p.stat().st_size / 1e6:.1f} MB" for p in sorted(OUT.glob("WooPack-Core.7z.*"))]
    print("\n".join(sizes))

if __name__ == "__main__":
    main()
