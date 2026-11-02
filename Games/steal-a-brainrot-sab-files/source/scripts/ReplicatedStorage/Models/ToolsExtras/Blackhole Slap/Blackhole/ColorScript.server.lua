


local v_u_1 = script.Parent
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local v_u_4 = require(v2.Shared.RecolorPart)
local v_u_5 = script:WaitForChild("Reference").Value
v3.RenderStepped:Connect(function(_)
    v_u_4(v_u_1, v_u_5:GetAttribute("Color"))
end)