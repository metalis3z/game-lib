local Event = script.Parent
local UnequipEvent = script.Parent.Parent.Unequip
local RS = game:GetService("ReplicatedStorage")
local AF = RS.Assets.CosmeticsAssets.Auras
local Aura
local Weld

Event.OnServerEvent:Connect(function(plr)
	local Character = plr.Character
	local Humanoid = Character:FindFirstChild("Humanoid")
	Aura = AF.CorruptionAura.AuraPart:Clone()
	Weld = Instance.new("Weld")
	Aura.Parent = Character.HumanoidRootPart
	Weld.Parent = Character
	Weld.Part0 = Character.HumanoidRootPart
	Weld.Part1 = Aura
end)

UnequipEvent.OnServerEvent:Connect(function()
	Aura:Destroy()
	Weld:Destroy()
end)