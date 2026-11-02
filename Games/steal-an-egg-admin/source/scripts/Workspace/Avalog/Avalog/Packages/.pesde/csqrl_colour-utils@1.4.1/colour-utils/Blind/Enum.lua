-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Blind = {
        Trichromacy = 0,
        Protanopia = 1,
        Protanomaly = 2,
        Deuteranopia = 3,
        Deuteranomaly = 4,
        Tritanopia = 5,
        Tritanomaly = 6,
        Achromatopsia = 7,
        Achromatomaly = 8
    },
    Group = {
        Trichroma = 0,
        Protan = 1,
        Deutan = 2,
        Tritan = 3,
        Achroma = 4
    }
}

v1.Blind.None = v1.Blind.Trichromacy
v1.Blind.LowRed = v1.Blind.Protanomaly
v1.Blind.LowGreen = v1.Blind.Deuteranomaly
v1.Blind.LowBlue = v1.Blind.Tritanomaly
v1.Blind.LowColor = v1.Blind.Achromatomaly
v1.Blind.NoRed = v1.Blind.Protanopia
v1.Blind.NoGreen = v1.Blind.Deuteranopia
v1.Blind.NoBlue = v1.Blind.Tritanopia
v1.Blind.NoColor = v1.Blind.Achromatopsia
return v1
