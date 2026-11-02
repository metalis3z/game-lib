-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"))
--local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService")):GetCurrentEvent()
local v3 = script.Parent:WaitForChild("CoverPhoto")
local v4 = script.Parent:WaitForChild("EventPhoto")
local v5 = script.Parent:WaitForChild("BasePhoto")
--[[if v2 and v2.ShopCover then
    v4.Image = v2.ShopCover
    v4.Visible = true
    v5:Destroy()
    v3:Destroy()
    v4:WaitForChild("BuyItem").Activated:Connect(function()
        v_u_1:ToggleFrame("CurrentEvent")
    end)
    return
elseif v3.Visible then
    v4:Destroy()
    v5:Destroy()
    v3:WaitForChild("BuyItem").Activated:Connect(function()
        v_u_1:ToggleFrame(nil)
    end)
else
    v4:Destroy()
    v3:Destroy()
    v5.Visible = true
end]]