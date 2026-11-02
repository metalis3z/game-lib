-- SERVICES --

local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')


-- MODULES --

local ServerModules = SvSt.Modules

local PlayerClass = require(ServerModules.PlayerClass)


-- BINDABLES --

local Bindables = SvSt.Bindables

local CosmBind = Bindables.Cosmetics


-- REMOTES --

local Remotes = RS.Remotes
local CosmeticsRems = Remotes.Cosmetics

local CosmSet = CosmeticsRems.Set
local CosmGet = CosmeticsRems.Get


-- ASSETS --

local Assets = SvSt.Assets
local Models = Assets.Models
local Cosmetics = Models.Cosmetics

local Accesories = Cosmetics.Accesories
local Titles = Cosmetics.Titles


-- FUNCTIONS --

local function Cosmetic(Player: Player, Params: {any})
	local Character = Player.Character
	local PlayerCosmetics = PlayerClass:GetClass(Player.UserId).Cosmetics

	if not Character then return end

	if Params.Type == 'Accessories' then
		if Params.State == true then
			if Character:FindFirstChild(Params.Name) then return end

			local Accessory = Accesories:FindFirstChild(Params.Name)
			if Accessory then
				Accessory = Accessory:Clone()
				Accessory.Parent = Character

				for _,v: MeshPart in Accessory:GetChildren() do
					local Weld: Weld = v.Weld
					Weld.Part0 = Character[v.Name]
				end

				PlayerCosmetics.Accessories[Accessory.Name] = Accessory.Name

				local Value = Instance.new('StringValue')
				Value.Name = Accessory.Name
				Value.Parent = Player.Cosmetics.Accessories
			end
		else
			local Accessory = Character:FindFirstChild(Params.Name)
			if Accessory then
				Player.Cosmetics.Accessories[Accessory.Name]:Destroy()
				PlayerCosmetics.Accessories[Accessory.Name] = nil
				Accessory:Destroy()
			end
		end
	elseif Params.Type == 'Auras' then
		print('Aura')
	elseif Params.Type == 'Titles' then
		if Params.State == true then
			if Character.HumanoidRootPart:FindFirstChild(Params.Name) or (Titles[Params.Name]:GetAttribute('GroupRank') and Player:GetRankInGroup(15054919) ~= Titles[Params.Name]:GetAttribute('GroupRank')) then return end

			for _,v in Character.HumanoidRootPart:GetChildren() do
				if v:IsA('BillboardGui') then 
					v:Destroy()
				end
			end

			local Title = Titles[Params.Name]:Clone()
			Title.Parent = Character.HumanoidRootPart

			PlayerCosmetics.Titles[Title.Name] = Title.Name

			local Value = Instance.new('StringValue')
			Value.Name = Title.Name
			Value.Parent = Player.Cosmetics.Titles
		else
			local Title = Character.HumanoidRootPart:FindFirstChild(Params.Name)
			if Title then
				Player.Cosmetics.Titles[Title.Name]:Destroy()
				PlayerCosmetics.Titles[Title.Name] = nil
				Title:Destroy()
			end
		end
	end
end


-- EVENTS --

CosmSet.OnServerEvent:Connect(Cosmetic)
CosmBind.Event:Connect(Cosmetic)
