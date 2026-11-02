-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Parent = script.Parent
local v1 = 0
RunService.RenderStepped:Connect(function(v2) -- line 9 | captures: v1, Parent
    v1 += 20 * v2
    Parent.Rotation = v1 % 360
end)
