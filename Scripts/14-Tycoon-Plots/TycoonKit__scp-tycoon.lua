-- Reference copy for study. Game: scp-tycoon
-- Original: several small scripts, bundled (each one is the whole file, unchanged):
--   ServerScriptService/EventsHandler.server.lua
--   Workspace/Tycoons/1/BuyPads/1/BuyHandler.server.lua
--   Workspace/Tycoons/1/Droppers/1/DropHandler.server.lua
--   Workspace/Tycoons/1/Upgrades/1/UpgradePart/Script.server.lua
--   Workspace/Tycoons/1/CollectionPart/CollectionHandler.server.lua
--   Workspace/Tycoons/1/Door/LazerHandler.server.lua
--   Workspace/Tycoons/1/ResetHandler.server.lua
-- What it does: A small hand-made tycoon: claim via RemoteEvent, buy pads that reveal a dropper/upgrade and
--   enable it, droppers that clone a Drop on a cooldown, an upgrader that doubles each drop once, a collector
--   that pays the owner, an owner-only kill laser door, and a reset script that hides everything at start.


-- ===================== ServerScriptService/EventsHandler.server.lua =====================
local Events = game.ReplicatedStorage.Events

local function CreateChatMessage(Message,Color,font)
	for i,Player in pairs(game.Players:GetPlayers()) do
		Events.CreateChatMessage:FireClient(Player,"Server: ".. Message,Color,font)
	end
end

Events.ClaimTycoon.OnServerEvent:Connect(function(Player,Tycoon)
	if game.Workspace.Tycoons:FindFirstChild(Tycoon) then
		Tycoon = game.Workspace.Tycoons:FindFirstChild(Tycoon)
	else
		return
	end
	if Player.Data.TycoonOwned.Value == 0 then
		if Tycoon.Data.Owner.Value == "" then
			Tycoon.Data.Owner.Value = Player.Name
			Player.Data.TycoonOwned.Value = tonumber(Tycoon.Name)
			CreateChatMessage(Player.DisplayName.. " has claimed a tycoon!",Color3.fromRGB(99, 198, 0),Enum.Font.FredokaOne)
			
			Tycoon.Door.GUipart.BillboardGui.TextLabel.Text = "Owner: ".. Player.DisplayName
			for i,v in pairs(Tycoon.Droppers:FindFirstChild("1").Parts:GetChildren()) do
				v.Transparency = 0
				v.CanCollide = true
			end
		end
	end
end)

Events.ReadyUpForEvent.OnServerEvent:Connect(function(Player)
	Player.Data.ReadyForEvent.Value = true
end)

Events.BuyWeapon.OnServerEvent:Connect(function(Player,GunName)
	if Player.Data.Cash.Value >= game.ReplicatedStorage.GunShopWeaponData:FindFirstChild(GunName).Value then
		Player.Data.Cash.Value -= game.ReplicatedStorage.GunShopWeaponData:FindFirstChild(GunName).Value
		local Weapon = game.ReplicatedStorage.Weapons:FindFirstChild(GunName):Clone()
		Weapon.Parent = Player.Backpack
	end
end)

-- ===================== Workspace/Tycoons/1/BuyPads/1/BuyHandler.server.lua =====================
script.Parent.BillboardGui.NameLabel.Text = script.Parent.Data.ObjectName.Value
script.Parent.BillboardGui.PriceLabel.Text = "$".. script.Parent.Data.Price.Value
local db = false
script.Parent.Touched:Connect(function(Hit)
	if game.Players:FindFirstChild(script.Parent.Parent.Parent.Data.Owner.Value) then
		if Hit.Parent.Name == script.Parent.Parent.Parent.Data.Owner.Value then
			if game.Players:FindFirstChild(script.Parent.Parent.Parent.Data.Owner.Value).Data.Cash.Value >= script.Parent.Data.Price.Value then
				if db == false then
					db = true
					game.Players:FindFirstChild(script.Parent.Parent.Parent.Data.Owner.Value).Data.Cash.Value -= script.Parent.Data.Price.Value
					for i,v in pairs(script.Parent.Data.Object.Value.Parts:GetChildren()) do
						v.Transparency = 0
						v.CanCollide = true
					end
					script.Parent.Data.Object.Value.Data.Enabled.Value = true
					script.Parent.BillboardGui.Enabled = false
					local Time = 0.8

					local tweenService = game:GetService("TweenService")
					local Properties = {
						Transparency = 1 --in the bracket : EndPosition of the Part
					}
					local TweenInfoo = TweenInfo.new(Time,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
					local tween = tweenService:Create(script.Parent,TweenInfoo,Properties)

					tween:Play()
					wait(Time)
					script.Parent.CanCollide = false
				end
			end
		end
	end
end)

-- ===================== Workspace/Tycoons/1/Droppers/1/DropHandler.server.lua =====================
local Tycoon = script.Parent.Parent.Parent

while wait(0.1) do 
	if game.Players:FindFirstChild(Tycoon.Data.Owner.Value) then
		if script.Parent.Data.Enabled.Value == true then
			local Drop = script.Drop:Clone()
			Drop.Transparency = 0
			Drop.CanCollide = true
			Drop.Anchored = false
			Drop.Parent = Tycoon.Drops
			Drop.Position = script.Parent.DropSpot.Position
			wait(script.Parent.Data.Cooldown.Value)
		end
	end
end

-- ===================== Workspace/Tycoons/1/Upgrades/1/UpgradePart/Script.server.lua =====================
local DropsThatGotUpgraded = {}

script.Parent.Touched:Connect(function(Hit)
	if Hit.Parent == script.Parent.Parent.Parent.Parent.Drops then
		if game.Players:FindFirstChild(script.Parent.Parent.Parent.Parent.Data.Owner.Value) then
			if not table.find(DropsThatGotUpgraded,Hit) then
				if script.Parent.Parent.Data.Enabled.Value == true then
								table.insert(DropsThatGotUpgraded,Hit)
			Hit.CashReward.Value = Hit.CashReward.Value*2
				end

		end
		end
		
	end
end)

-- ===================== Workspace/Tycoons/1/CollectionPart/CollectionHandler.server.lua =====================
local Tycoon = script.Parent.Parent

script.Parent.Touched:Connect(function(Hit)
	pcall(function()
		if Hit.Name == "Drop" then
			if Hit:FindFirstChild("Collected").Value == false then
				Hit.Collected.Value = true
				local Cash = Hit.CashReward.Value
				Hit:Destroy()
				if game.Players:FindFirstChild(Tycoon.Data.Owner.Value) then
					game.Players:FindFirstChild(Tycoon.Data.Owner.Value).Data.Cash.Value += Cash
				end
			end
		end
	end)
end)

-- ===================== Workspace/Tycoons/1/Door/LazerHandler.server.lua =====================
script.Parent.Touched:Connect(function(Hit)
	if game.Players:FindFirstChild(Hit.Parent.Name) then
		if Hit.Parent.Name ~= script.Parent.Parent.Data.Owner.Value then
			if script.Parent.Parent.Data.LazersEnabled.Value == true then
				if Hit.Parent:FindFirstChild("Humanoid") then
					Hit.Parent:FindFirstChild("Humanoid").Health = 0
				end
			end
		end
	end
end)

-- ===================== Workspace/Tycoons/1/ResetHandler.server.lua =====================
for i,v in pairs(script.Parent.Droppers:GetChildren()) do
	for i,Part in pairs(v.Parts:GetChildren()) do
		Part.Transparency = 1
		Part.CanCollide = false
	end
end
for i,v in pairs(script.Parent.Upgrades:GetChildren()) do
	for i,Part in pairs(v.Parts:GetChildren()) do
		Part.Transparency = 1
		Part.CanCollide = false
	end
	v.UpgradePart.Transparency = 1
end

for i,v in pairs(script.Parent.Walls:GetChildren()) do
	
		v.Transparency = 1
		v.CanCollide = false
end

script.Parent.Extras.DoorLazer.Btn.Transparency = 1
script.Parent.Extras.DoorLazer.Btn.CanCollide = false

for i,Stair in pairs(script.Parent.Stairs1:GetChildren()) do
	Stair.CanCollide = false
	Stair.Transparency = 1
end

for i,floor in pairs(script.Parent.Floors:GetChildren()) do
	floor.CanCollide = false
	floor.Transparency = 1
	for i,v in pairs(floor:GetChildren()) do
		if v.Name == "Texture" then
			v.Transparency = 1
		end
	end
end
