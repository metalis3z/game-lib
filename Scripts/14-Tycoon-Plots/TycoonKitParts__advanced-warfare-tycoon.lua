-- Reference copy for study. Game: advanced-warfare-tycoon
-- Original: several small scripts, bundled (each one is the whole file, unchanged):
--   Workspace/blue/CoreScript.server.lua
--   Workspace/blue/Bright blue/Gate/Touch to claim ownership!/GateControl.server.lua
--   Workspace/blue/Bright blue/Purchases/Prod1/DropperScript.server.lua
--   Workspace/blue/Bright blue/Purchases/Upgrader1/UpgraderScript.server.lua
--   Workspace/blue/Bright blue/Essentials/Conveyor/ConveyorScript.server.lua
-- What it does: The remaining pieces of the classic tycoon kit: CoreScript (backs up each tycoon and
--   regenerates it when the owner leaves), the claim gate, a dropper (spawns a Part with a Cash IntValue
--   every few seconds), an upgrader (adds value to drops that touch it) and the velocity conveyor.


-- ===================== Workspace/blue/CoreScript.server.lua =====================
--berezaa's Tycoon Kit

tycoonBackups = {}

for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("Model") then
		
		tycoonBackups[v.Name] = v:Clone() -- Clones a copy of the tycoon to later regen	
		
		local teamcolor = BrickColor.new(v.Name)
		if teamcolor ~= nil then
			local team = Instance.new("Team",game.Teams)
			team.Name = v.TeamName.Value
			team.AutoAssignable = false
			team.TeamColor = teamcolor
		end
	end
end

function getTycoonFromPlayer(player)
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Model") then
			if v.Owner.Value == player then
				return v
			end
		end
	end
	return nil
end

game.Players.PlayerRemoving:connect(function(player)
	local tycoon = getTycoonFromPlayer(player)
	if tycoon then
		local backup = tycoonBackups[tycoon.Name]:Clone()
		tycoon:Destroy()
		wait()
		backup.Parent=script.Parent
	end
end)

-- ===================== Workspace/blue/Bright blue/Gate/Touch to claim ownership!/GateControl.server.lua =====================
script.Parent.Head.Touched:connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player ~= nil then
		local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
		if cashmoney ~= nil then
			local ownstycoon = cashmoney:FindFirstChild("OwnsTycoon")
			if ownstycoon ~= nil then
				if ownstycoon.Value == false then
					if script.Parent.Parent.Parent.Owner.Value == nil then
						if hit.Parent:FindFirstChild("Humanoid") then
							if hit.Parent.Humanoid.Health > 0 then
								player.TeamColor = BrickColor.new(script.Parent.Parent.Parent.Name)
								script.Parent.Parent.Parent.Owner.Value = player
								script.Parent.Parent.Parent.Own2.Value = hit.Parent.Name
								ownstycoon.Value = true
								script.Parent.Name = player.Name.."'s Tycoon"
								script.Parent.Head.Transparency = 0.6
								script.Parent.Head.CanCollide = false
								
							end
						end
					end
				end
			end
		end
	end
end)

-- ===================== Workspace/blue/Bright blue/Purchases/Prod1/DropperScript.server.lua =====================
wait(2.5)
ps = script.Parent.Parent.Parent.PartStorage
DS = game.Lighting.Script:Clone()
while true do
	wait(4) -- How long in between drops
	local part = Instance.new("Part",ps)
	local cash = Instance.new("IntValue",part)
	cash.Name = "Cash"
	cash.Value = 11 -- How much the drops are worth
	part.CFrame = script.Parent.Drop3.CFrame - Vector3.new(0,1,0)
	part.FormFactor = "Custom"
	part.Size=Vector3.new(1.41,1,2.69) -- Size of the drops
		part.BrickColor = BrickColor.new("New Yeller")
		part.TopSurface = "Smooth"
		part.BottomSurface = "Smooth"
			part.Material = script.Parent.Parent.Parent.Material.Value
		DS.Parent = part
			part.Transparency = .4
	game.Debris:AddItem(part,20) -- How long until the drops expire
end

-- ===================== Workspace/blue/Bright blue/Purchases/Upgrader1/UpgraderScript.server.lua =====================
script.Parent.Upgrade.Touched:connect(function(hit)
	if hit:FindFirstChild("Cash") then
		hit.Cash.Value = hit.Cash.Value + 13 
		hit.Reflectance = hit.Reflectance + 0.1
	end
end)

-- ===================== Workspace/blue/Bright blue/Essentials/Conveyor/ConveyorScript.server.lua =====================
while 2 > 1 do
	script.Parent.Velocity = script.Parent.CFrame.lookVector*15
	wait(0.2)
end
