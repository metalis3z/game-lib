-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

game:GetService("StarterPlayer")
game:GetService("CollectionService")
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local v2 = v_u_1:WaitForChild("Packages")
local v_u_3 = require(v2.Net)
script.Parent.Activated:Connect(function()
    -- upvalues: (copy) v_u_1, (copy) v_u_3
    local v4 = require(v_u_1.Packages.PlayerMouse)
    v_u_3:RemoteEvent("UseItem"):FireServer(v4.Hit.Position)
end)