--made by tristan_62

local HttpService = game:GetService("HttpService")

----------------------------------------------variables---------------------------------------
local gunRemote = game:GetService("ReplicatedStorage").GunRemote

local PlaySound = gunRemote:WaitForChild("Sound")
local Fire = gunRemote:WaitForChild("Fire") 
local Tag = gunRemote:WaitForChild("Tag") 
local StopSound = gunRemote:WaitForChild("StopSound")
local Tag2 = gunRemote:WaitForChild("Tag2")
local FireLaser = gunRemote:WaitForChild("FireLaser")
local UnFireLaser = gunRemote:WaitForChild("UnFireLaser")
local ARemote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
----------------------------------------------create bullets----------------------------------
local Bullet=Instance.new("Part")
Bullet.Name="Bullet"
Bullet.BrickColor=BrickColor.Yellow()
Bullet.Anchored=true
Bullet.CanCollide=false
Bullet.Locked=true
Bullet.Transparency = 0.5
Bullet.FormFactor = Enum.FormFactor.Custom
Bullet.Size=Vector3.new(0.2, 0.2, 0.2)
Bullet.formFactor=0
Bullet.TopSurface=0
Bullet.BottomSurface=0
Bullet.Material = Enum.Material.Neon

local Mesh = Instance.new("BlockMesh")
Mesh.Parent = Bullet
Mesh.Name="Mesh"
Mesh.Scale=Vector3.new(0.5, 0.5, 1)
-------------------------------------------functions------------------------------------------


local _Table = {

	["Sound"] = "",
	["Fire"] = "",
	["Tag"] = "",
	["StopSound"] = "",
	["Tag2"] = "",
	["FireLaser"] = "",
	["GunRemote"] = "",
}

local Whitelist_Allowed_Type = {

	["true"] = {
		[1] = "Whitelist",
		[2] = true,
	},

	["false"] = {
		[1] = "Whitelist",
		[2] = false,
	}

}


function Get(CurlyBraces)

	if Whitelist_Allowed_Type[CurlyBraces] then
		if Whitelist_Allowed_Type[CurlyBraces][1] == "Whitelist" then
			CurlyBraces = Whitelist_Allowed_Type[CurlyBraces][2]
		else
			CurlyBraces = true
		end
	else
		CurlyBraces = true
	end

	local _Sound = HttpService:GenerateGUID(CurlyBraces)
	local _Fire = HttpService:GenerateGUID(CurlyBraces)
	local _Tag = HttpService:GenerateGUID(CurlyBraces)
	local _StopSound = HttpService:GenerateGUID(CurlyBraces)
	local _Tag2 = HttpService:GenerateGUID(CurlyBraces)
	local _FireLaser = HttpService:GenerateGUID(CurlyBraces)
	local _GunRemote = HttpService:GenerateGUID(CurlyBraces)
	
	_Table["Sound"] = _Sound or "Sound"
	_Table["Fire"] = _Fire or "Fire"
	_Table["Tag"] = _Tag or "Tag"
	_Table["StopSound"] = _StopSound or "StopSound"
	_Table["Tag2"] = _Tag2 or "Tag2"
	_Table["FireLaser"] = _FireLaser or "FireLaser"
	_Table["GunRemote"] = _GunRemote --"GunRemote"
	
	return _Table
end


PlaySound.OnServerEvent:Connect(function(player, sound, value, handle)
	if value == true then
		spawn(function()
			local double = sound:Clone()
			double.Parent = handle
			double:Play()
			wait(double.TimeLength)

			double:Destroy()
		end)
	else
		sound:Play()
	end
end)

Fire.OnServerEvent:Connect(function(player, distance, position, start, handle)
	spawn(function()
		handle.PointLight.Enabled = true 

		local newbullet = Bullet:Clone()

		newbullet.Parent = game.Workspace
		newbullet.Name = player.Name.."Bullet"

		newbullet.CFrame=CFrame.new(start, position) * CFrame.new(0, 0, -distance/ 2)

		newbullet.Size=Vector3.new(0.2, 0.2, distance)

		wait(0.01)

		handle.PointLight.Enabled = false
		newbullet:Destroy()	
	end)

end)


Tag.OnServerEvent:Connect(function(player, humanoid, damage)
	local atag = humanoid:FindFirstChild("creator")
	
	if atag then
		atag:Destroy()
	end
	
	local NewTag = Instance.new("ObjectValue")
	NewTag.Value = player
	NewTag.Name = "creator"
	NewTag.Parent = humanoid
	
	
	
	--print("ok")
	
	delay(2, function() --0.5
		if NewTag ~= nil then
			NewTag.Parent = nil
		end
	end)

	humanoid:TakeDamage(damage)

	--if humanoid.Health < 1 then
	--humanoid.Parent.Head:Destroy()
	--	end
end)

StopSound.OnServerEvent:Connect(function(player, sound)
	sound:Stop()
end)

Tag2.OnServerEvent:Connect(function(player, humanoid)
	local plr = game.Players:GetPlayerFromCharacter(humanoid.Parent)
	local char = humanoid.Parent

	local q= char:GetChildren()

	for i=1,#q do
		if q[i].ClassName=="Tool" and q[i]:FindFirstChild("FakeHandle") and q[i].FakeHandle:FindFirstChild("BodyVelocity") then
			q[i].FakeHandle.BodyVelocity:remove()
		end
	end
	humanoid.PlatformStand=true
	humanoid.JumpPower=0
	humanoid:UnequipTools()
	for i,v in pairs(plr.Backpack:GetDescendants()) do
		if v.ClassName == "Tool" and v.Parent then
			v.Parent = game.Lighting
		end
	end

	game:GetService("RunService"):BindToRenderStep(char.Name .. "Tased", 301, function()
		humanoid:UnequipTools()
	end)
	spawn(function()
		wait(5)
		humanoid.PlatformStand=false
		humanoid.JumpPower=50
		for i, e in pairs(game.Lighting:GetDescendants()) do
			if e.ClassName == "Tool" and e.Parent then
				e.Parent = plr.Backpack 
			end
		end
		char.Torso.Effect:Destroy()
		game:GetService("RunService"):UnbindFromRenderStep(char.Name .. "Tased")
	end)
end)


function Draw(p1,p2, parent)	
	local dist = (p2.Position - p1.Position).Magnitude
	local Part = Bullet:Clone()
	Part.BrickColor = BrickColor.new("Really red")
	Part.Parent = parent
	--Part.Position = p1.Position

	Part.Size = Vector3.new(0.2,0.2,dist)
	Part.CFrame = CFrame.new(p1.Position, p2.Position) * CFrame.new(0,0,-dist/2)
end

FireLaser.OnServerEvent:Connect(function(player, distance, position, start, handle)
	spawn(function()
		local bulletnew = Instance.new("Model")
		bulletnew.Name = player.Name.."Bullet"

		local points = {}

		for i = 0,10 do
			local Offset = Vector3.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))

			if i == 0 or i == 10 then
				Offset = Vector3.new(0,0,0)
			end

			local Part = Instance.new("Part", bulletnew)
			Part.Anchored = true
			Part.CanCollide = false
			Part.Size = Vector3.new(.5,.5,.5)
			Part.Material = Enum.Material.Neon
			Part.BrickColor = BrickColor.new("Medium blue")
			Part.Transparency = 1

			Part.Position = start + (position - start).Unit * i * distance/10 + Offset

			points[#points+1] = Part
		end

		UnFireLaser:FireClient(player, points)

		for i = 1,#points do
			if points[i+1] ~= nil then					
				Draw(points[i],points[i+1], bulletnew)
			end
		end

		bulletnew.Parent = game.Workspace

		handle.PointLight.Enabled = true

		wait(0.01)

		bulletnew:Destroy()	

		handle.PointLight.Enabled = false
	end)
end)


coroutine.resume(coroutine.create(function()
	while wait(0.5) do

		

		
		local newTables = {
			sound = PlaySound,
			fire = Fire,
			tag = Tag,
			tag2 = Tag2,
			stopsound = StopSound,
			fireLaser = FireLaser,
			UnFireLaser = UnFireLaser,
		}

		ARemote:FireAllClients(newTables, gunRemote)
	end
end))