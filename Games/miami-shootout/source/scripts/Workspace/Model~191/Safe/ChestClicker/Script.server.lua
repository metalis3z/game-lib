local remote = game:GetService("ReplicatedStorage"):WaitForChild("Inventory")

script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	remote:FireClient(plr, "OpenInv", script.Parent.Parent)
end)