local t = {}
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local ProfileData = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
local ItemPopupService = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService"))
local v1 = script.Parent.Parent
local PurchaseCurrency = v1:WaitForChild("Container"):WaitForChild("EventFrames"):WaitForChild("PurchaseCurrency")
local ExtraRewards = v1:WaitForChild("Container"):WaitForChild("EventFrames"):WaitForChild("ExtraRewards")
local Button = require(script.Parent.Button)
local v2 = PurchaseCurrency.Container["150"]
local v3 = PurchaseCurrency.Container["360"]
local v4 = Button.createButton(PurchaseCurrency:WaitForChild("Info"):WaitForChild("Back"))

local function v12() --[[ v12 | Line: 14 | Upvalues: PurchaseCurrency (copy), ProfileData (copy) ]]
	PurchaseCurrency.Info.Currency.Container.Amount.Text = ProfileData.Materials.Owned.BeachBalls2024_Box or 0
	PurchaseCurrency.Info.Keys.Container.Amount.Text = ProfileData.Materials.Owned.SummerKey2024 or 0
end

function t.Initialize(p1, p2) --[[ Line: 18 | Upvalues: Button (copy), v2 (copy), v3 (copy), PurchaseCurrency (copy), ItemPopupService (copy), v4 (copy), ExtraRewards (copy), ProfileData (copy), t (copy) ]]
	Button.createButton(v2.Swap, function() --[[ Line: 19 | Upvalues: v2 (ref), v3 (ref) ]]
		v2.Visible = false
		v3.Visible = true
	end)
	Button.createButton(v3.Swap, function() --[[ Line: 23 | Upvalues: v2 (ref), v3 (ref) ]]
		v2.Visible = true
		v3.Visible = false
	end)

	for k, v in pairs(PurchaseCurrency.Container:GetChildren()) do
		if v:IsA("Frame") then
			Button.createButton(v, function() --[[ Line: 29 | Upvalues: v (copy), ItemPopupService (ref), p2 (copy) ]]
				ItemPopupService:AddNewItem(p2 .. "_" .. v.Name, "Materials")
			end)
		end
	end

	function v4.clickEnd() --[[ Line: 36 | Upvalues: PurchaseCurrency (ref), ExtraRewards (ref) ]]
		PurchaseCurrency.Visible = false
		ExtraRewards.Visible = true
	end
	PurchaseCurrency.Info.Currency.Container.Amount.Text = ProfileData.Materials.Owned.BeachBalls2024_Box or 0
	PurchaseCurrency.Info.Keys.Container.Amount.Text = ProfileData.Materials.Owned.SummerKey2024 or 0

	return t
end
Remotes:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(v12)

return t