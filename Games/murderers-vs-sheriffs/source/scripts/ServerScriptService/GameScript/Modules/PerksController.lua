--!nocheck	

export type PerkInfoType = {
	Name: string,
	Image: string,
	UnlockLevel: number, 
	Price: number, 
	Description: string, 
	Type: string, 
	Active: boolean, 
	Cooldown: number, 
	ActiveTime: number
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Trove = require(ServerStorage.Trove)
local PerkDatabase = require(ReplicatedStorage.Database.Sync.Perks)

local PerksManager = {}
PerksManager.__index = PerksManager

function PerksManager.new(player: Player, PerkOwned: string)
	if (not player) or player.Character == nil then return end
	if (not PerkOwned) or not PerkDatabase[PerkOwned] then return end

	for i, PerkFolder: Folder in pairs(script:GetChildren()) do
		if (PerkFolder) and PerkFolder:IsA("Folder") then
			if player.PlayerGui:FindFirstChild(PerkFolder.Name) then
				player.PlayerGui:FindFirstChild(PerkFolder.Name):Destroy()
			end
		end
	end

	local EquippedPerkData = PerkDatabase[PerkOwned] :: PerkInfoType

	local PerkObject: Folder = (script:FindFirstChild(PerkOwned) and script:FindFirstChild(PerkOwned):IsA("Folder")) and script:FindFirstChild(PerkOwned):Clone() 
	PerkObject.Name = PerkOwned
	PerkObject:SetAttribute("LastUse", 0)
	PerkObject:SetAttribute("Cooldown", EquippedPerkData.Cooldown)
	PerkObject:SetAttribute("ActiveTime", EquippedPerkData.ActiveTime)
	PerkObject:SetAttribute("Charges", EquippedPerkData.Charges)
	PerkObject:AddTag("Perk")

	local self = {
		Trove = Trove.new(),
		PerkObject = PerkObject,
		PerkData = EquippedPerkData :: PerkInfoType,
		PerkOwned = PerkOwned,
		Player = player,
		Character = player.Character,
	}

	setmetatable(self, PerksManager)
	self:Init()
	return self
end

function PerksManager:Init()
	self.Player:SetAttribute("EquippedPerk", self.PerkOwned)
	self.PerkObject.Parent = self.Player.PlayerGui
	self.Trove:Connect(self.Player.CharacterAdded, function(character: Model) 
		self:Destroy()
	end)
	self.Trove:Connect(self.Player.CharacterRemoving, function() 
		self:Destroy()
	end)
	self.Trove:Add(self.PerkObject, "Destroy")
end

function PerksManager:Destroy()
	self.Trove:Destroy()
	table.clear(self)
end


return PerksManager