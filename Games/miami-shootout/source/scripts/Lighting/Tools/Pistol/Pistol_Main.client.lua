--> CUSTOMISATION
local Damage = 20
local MaxAmmo = 9
local ReloadTime = 2.5
local FireCooldown = .3
local FireAnimSpeed = 3.5
local ReloadAnimSpeed = 2
local MouseIconImageID = 8363742711
local GunFireSpeeds = {.9, .95, 1, 1.05, 1.1}

--> LOCAL VARIABLES & SERVICES
local Pistol = script.Parent
local PistolHandle = Pistol:WaitForChild("Handle")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Input = game:GetService("UserInputService")
local FireAnimation = Pistol:WaitForChild("FireAnimation")
local ReloadAnimation = Pistol:WaitForChild("ReloadAnimation") 
local OriginalMouseIcon = Player:GetMouse().Icon
local CurrentAmmoValue = Pistol:WaitForChild("BulletHoles"):WaitForChild("CurrentAmmo")
local CurrentAmmo = MaxAmmo
local Reloading = false
local TextDisplay = Pistol:WaitForChild("PistolGui"):WaitForChild("AmmoText")
TextDisplay.Text = CurrentAmmo.." / "..MaxAmmo
CurrentAmmoValue.Value = CurrentAmmo

--> FUNCTIONS
function UpdateUI()
	TextDisplay.Text = CurrentAmmo.." / "..MaxAmmo
	PlayerGui:WaitForChild("PistolGui"):WaitForChild("AmmoText").Text = CurrentAmmo.." / "..MaxAmmo
end

function Reload()
	Reloading = true
	local Humanoid = Player.Character:WaitForChild("Humanoid")
	Humanoid:LoadAnimation(ReloadAnimation):Play(.1, 1, ReloadAnimSpeed)
	PistolHandle.GunReload:Play()
	wait(ReloadTime)
	CurrentAmmo = MaxAmmo
	CurrentAmmoValue.Value = CurrentAmmo
	UpdateUI()
	Reloading = false
end

Pistol.Equipped:Connect(function()
	PistolHandle.GunEquip:Play()
	Pistol:WaitForChild("PistolGui"):Clone().Parent = PlayerGui
	UpdateUI()
	local Mouse = Player:GetMouse()
	Mouse.Icon = "rbxassetid://"..MouseIconImageID
	Input.InputBegan:Connect(function(Key)
		if Key.KeyCode == Enum.KeyCode.R and Reloading == false and CurrentAmmo ~= MaxAmmo then
			Reload()
		end
	end)
end)

Pistol.Unequipped:Connect(function()
	if PlayerGui:FindFirstChild("PistolGui") then
		PlayerGui:WaitForChild("PistolGui"):Destroy()
	else end
	local Mouse = Player:GetMouse()
	Mouse.Icon = OriginalMouseIcon
end)

Pistol.Activated:Connect(function()
	local Mouse = Player:GetMouse()
	if CurrentAmmo > 0 and not Reloading then
		local Humanoid = Player.Character:WaitForChild("Humanoid")
		Humanoid:LoadAnimation(FireAnimation):Play(.1, 1, FireAnimSpeed)
		CurrentAmmo = CurrentAmmo - 1
		UpdateUI()
		CurrentAmmoValue.Value = CurrentAmmo
		PistolHandle.GunFire.PlaybackSpeed = GunFireSpeeds[math.random(#GunFireSpeeds)]
		PistolHandle.GunFire:Play()
		if Mouse.Target.Parent:FindFirstChild("Humanoid") then
			local Victim = Mouse.Target.Parent
			if game.Players:FindFirstChild(Victim.Name) then
				if game.Players[Victim.Name].TeamColor ~= Player.TeamColor then
					Pistol.DealDamage:FireServer(Victim, Damage)
				else end
			else
				Pistol.DealDamage:FireServer(Victim, Damage)
			end
		elseif Mouse.Target.Parent.Parent:FindFirstChild("Humanoid") then
			local Victim = Mouse.Target.Parent.Parent
			if game.Players:FindFirstChild(Victim.Name) then
				if game.Players[Victim.Name].TeamColor ~= Player.TeamColor then
					Pistol.DealDamage:FireServer(Victim, Damage)
				else end
			else
				Pistol.DealDamage:FireServer(Victim, Damage)
			end
		else end
		wait(FireCooldown)
	elseif Reloading == false then
		Reload()
	end
end)