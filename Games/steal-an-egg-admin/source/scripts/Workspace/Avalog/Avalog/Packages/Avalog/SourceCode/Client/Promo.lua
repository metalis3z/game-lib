-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Manifest = require(script.Parent.Parent.Parent.SourceCode.Shared.Manifest)
local v1 = {}

function v1.Start(v2) -- line 8 | captures: RunService, Manifest
    if not RunService:IsStudio() then
        print((("Running Avalog %* \240\159\155\160\239\184\143\n> https://devforum.roblox.com/t/3513102"):format(Manifest.Version)))
    end
end

return v1
