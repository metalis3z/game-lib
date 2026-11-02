-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Enum = require(script.Parent.Parent.Enum)
local v1 = {}

v1[Enum.Blind.Protanomaly] = true
v1[Enum.Blind.Deuteranomaly] = true
v1[Enum.Blind.Tritanomaly] = true
v1[Enum.Blind.Achromatomaly] = true

local v2 = {}

v2[Enum.Blind.Trichromacy] = Enum.Group.Trichroma
v2[Enum.Blind.Protanopia] = Enum.Group.Protan
v2[Enum.Blind.Protanomaly] = Enum.Group.Protan
v2[Enum.Blind.Deuteranopia] = Enum.Group.Deutan
v2[Enum.Blind.Deuteranomaly] = Enum.Group.Deutan
v2[Enum.Blind.Tritanopia] = Enum.Group.Tritan
v2[Enum.Blind.Tritanomaly] = Enum.Group.Tritan
v2[Enum.Blind.Achromatopsia] = Enum.Group.Achroma
v2[Enum.Blind.Achromatomaly] = Enum.Group.Achroma

local v3 = {
    3.241,
    -0.969,
    0.056,
    -1.537,
    1.876,
    -0.204,
    -0.499,
    0.042,
    1.057
}
local v4 = {
    0.412,
    0.213,
    0.019,
    0.358,
    0.715,
    0.119,
    0.18,
    0.072,
    0.95
}
local v5 = {}

v5[Enum.Group.Protan] = {
    X = 0.747,
    Y = 0.254,
    M = 1.273,
    YI = -0.074
}
v5[Enum.Group.Deutan] = {
    X = 1.4,
    Y = -0.4,
    M = 0.968,
    YI = 0.003
}
v5[Enum.Group.Tritan] = {
    X = 0.175,
    Y = 0,
    M = 0.063,
    YI = 0.292
}

return {
    Gamma_Correct = 2.2,
    Anomalised = v1,
    Groups = v2,
    Matrix = {
        XYZ_RGB = v3,
        RGB_XYZ = v4
    },
    Blinder = v5
}
