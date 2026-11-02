-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent

if not Parent:IsA("BasePart") then
    return
end
local v1 = math.random()
RunService.Heartbeat:Connect(function(v2) -- line 10 | captures: v1, Parent
    v1 = (v1 + v2 * 0.12) % 1
    Parent.Color = Color3.fromHSV(v1, 0.78, 1)
end)
