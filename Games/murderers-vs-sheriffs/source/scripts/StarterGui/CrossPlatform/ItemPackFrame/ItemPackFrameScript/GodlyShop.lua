-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService")):GetCurrentItemPack()
if v2 then
    local v3 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"))
    local v4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ItemPackService"))
    local v5 = script.Parent.Parent:WaitForChild("Container"):WaitForChild("ItemPack"):WaitForChild("Main")
    local v6 = v2.ItemPackItems.Knife.ItemID
    local v7 = v2.ItemPackItems.Gun.ItemID
    local v8 = v2.ItemPackItems.Bundle.EffectItemID
    local v9 = v3:GetItemInfo("Weapons", v6)
    v5.Knife.Center.Item.IconContainer.Icon.Image = v3:GetItemImage(v9)
    v5.Knife.Center.Item.ItemName.NameLabel.Text = v3:GetDisplayName(v9)
    v5.Knife.Center.Item.ItemName.Shadow.Text = v3:GetDisplayName(v9)
    local v10 = v3:GetItemInfo("Weapons", v7)
    v5.Gun.Center.Item.IconContainer.Icon.Image = v3:GetItemImage(v10)
    v5.Gun.Center.Item.ItemName.NameLabel.Text = v3:GetDisplayName(v10)
    v5.Gun.Center.Item.ItemName.Shadow.Text = v3:GetDisplayName(v10)
    local v11 = v3:GetItemInfo("Effects", v8)
    v5.Bundle.Center.Item.IconContainer.KnifeIcon.Image = v3:GetItemImage(v9)
    v5.Bundle.Center.Item.IconContainer.GunIcon.Image = v3:GetItemImage(v10)
    v5.Bundle.Center.Item.IconContainer.EffectIcon.Image = v3:GetItemImage(v11)
    v5.Knife.Center.Confirm.Activated:Connect(v4.PromptBuyKnife)
    v5.Gun.Center.Confirm.Activated:Connect(v4.PromptBuyGun)
    v5.Bundle.Center.Confirm.Activated:Connect(v4.PromptBuyBundle)
    return v1
end