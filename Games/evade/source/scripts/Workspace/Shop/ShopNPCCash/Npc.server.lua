-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Controllers")
local u2 = require(v1.InterfaceController)
local v3 = script.Parent
local v4 = v3.AnimationController.Animator
local v5 = Instance.new("Animation")
v5.AnimationId = "rbxassetid://86639595342842"
local v6 = v4:LoadAnimation(v5)
v6:Play()
v6.Looped = true
v3.OpenInterface.Triggered:Connect(function() --[[Anonymous function at line 23]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2:Toggle("CoinsShop")
end)