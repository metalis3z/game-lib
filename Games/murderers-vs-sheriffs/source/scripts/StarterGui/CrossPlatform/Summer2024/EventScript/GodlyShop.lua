-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 3 ]]
	local BuyItemNew = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop"):WaitForChild("BuyItemNew")
	local Container = script.Parent.Parent:WaitForChild("Container"):WaitForChild("EventFrames"):WaitForChild("MainRewards"):WaitForChild("Content_Shop"):WaitForChild("GodlyShop"):WaitForChild("Container")

	Container.Knife.Confirm.Activated:Connect(function() --[[ Line: 6 | Upvalues: BuyItemNew (copy) ]]
		BuyItemNew:InvokeServer("Pearl_K", "Robux")
	end)
	Container.Gun.Confirm.Activated:Connect(function() --[[ Line: 9 | Upvalues: BuyItemNew (copy) ]]
		BuyItemNew:InvokeServer("Pearl_G", "Robux")
	end)
	Container.Bundle.Confirm.Activated:Connect(function() --[[ Line: 12 | Upvalues: BuyItemNew (copy) ]]
		BuyItemNew:InvokeServer("PearlBundleEffect", "Robux")
	end)
end