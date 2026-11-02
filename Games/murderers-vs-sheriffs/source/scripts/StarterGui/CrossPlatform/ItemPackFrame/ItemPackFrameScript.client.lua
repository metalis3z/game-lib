-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script:WaitForChild("GodlyShop"))
local v_u_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button"))
local v_u_2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"))
local v_u_3 = script.Parent
local v_u_4 = v_u_3:WaitForChild("Container"):WaitForChild("ItemPack");
(function()
    v_u_2:RegisterFrame(v_u_3, "ItemPack")
    v_u_1.createButton(v_u_4:WaitForChild("Title"):WaitForChild("Close"), function()
        v_u_2:Back()
    end)
end)()