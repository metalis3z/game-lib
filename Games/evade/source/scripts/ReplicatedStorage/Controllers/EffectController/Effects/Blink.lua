-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("TweenService")
require(script:FindFirstAncestor("Effects").Parent.Types)
local v3 = {}
local _ = script.Name
local v_u_4 = Instance.new("ColorCorrectionEffect")
v_u_4.Brightness = 0
v_u_4.TintColor = Color3.fromRGB(255, 255, 255)
v_u_4.Parent = workspace.CurrentCamera
local v_u_5 = v2:Create(v_u_4, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
    ["Brightness"] = 0
})
function v3.Activate(_)
    -- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_5
    v_u_4.Brightness = v_u_1:GetAttribute("WaterEvent") and 2 or 1
    v_u_5:Cancel()
    v_u_5:Play()
end
return v3