local M = {}

-- Weights
local REGULAR = "Regular"
-- Stretch
local EXPANDED = "Expanded"
-- Ligatures features
local HARFBUZZ_FEATURES = {
    "calt",
    "liga",
    "dlig",
    "ss01",
    "ss02",
    "ss03",
    "ss04",
    "ss05",
    "ss06",
    "ss07",
    "ss08",
}

local CASCADIA_CODE = "Cascadia Code"
local FIRA_CODE = "Fira Code"
local GEIST_MONO = "Geist Mono"
local HERMIT = "Hermit"
local JETBRAINS_MONO = "JetBrains Mono"
local LEAGUE_MONO = "League Mono"
local MONASPACE_ARGON = "Monaspace Argon"
local MONASPACE_KRYPTON = "Monaspace Krypton"
local MONASPACE_NEON = "Monaspace Neon"
local MONASPACE_RADON = "Monaspace Radon"
local MONASPACE_XENON = "Monaspace Xenon"
local SF_MONO = "SFMono"
local VICTOR_MONO = "Victor Mono"

M = {
    cascadia_code = {
        family = CASCADIA_CODE,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    fira_code = {
        family = FIRA_CODE,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    geist_mono = {
        family = GEIST_MONO,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    hermit = {
        family = HERMIT,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    jetbrains_mono = {
        family = JETBRAINS_MONO,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    league_mono = {
        family = LEAGUE_MONO,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_neon = {
        family = MONASPACE_NEON,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_argon = {
        family = MONASPACE_ARGON,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_krypton = {
        family = MONASPACE_KRYPTON,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_xenon = {
        family = MONASPACE_XENON,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_radon = {
        family = MONASPACE_RADON,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    sf_mono = {
        family = SF_MONO,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    victor_mono = {
        family = VICTOR_MONO,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
}

return M
