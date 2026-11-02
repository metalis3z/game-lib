-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = {
    Fired = function(v2, v3) -- Fired | line 6
        return v3
    end
}
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local v4 = ReplicatedStorage:WaitForChild("Network"):WaitForChild("AdminShowMessage", 5)

if v4 then
    v4.OnClientEvent:Connect(function(v5, v6) -- line 12 | captures: Message
        Message.Top({
            ShowShadow = true,
            Message = v5,
            Time = v6,
            Color = Color3.new(1, 1, 1)
        })
    end)
end
