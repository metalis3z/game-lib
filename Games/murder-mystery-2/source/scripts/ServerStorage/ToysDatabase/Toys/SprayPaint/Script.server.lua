--[[ LawlR fix ]]--

local ds = game:GetService("Debris")
local ps = game:GetService("Players")

wait(1)

local tool = script.Parent
local handle = tool:WaitForChild("Handle")
local remoteFunc = tool.RemoteFunction
local sprayAnim = tool.Anim
local sound = handle.Sound

local cooldown = 2.1
local spraysize = 5
local range = 10

local db
local plr, chr, hum
local anim


local function spray(pos, normal, target, id)
	pos = pos.Position
	if (chr:FindFirstChildWhichIsA("BasePart").Position - pos).magnitude <= range then
		local canSpray
		local targetSize = target.Size
		
		if (normal==Enum.NormalId.Front or normal==Enum.NormalId.Back) and targetSize.X >= spraysize and targetSize.Y >= spraysize then
			canSpray = true
		elseif (normal==Enum.NormalId.Left or normal==Enum.NormalId.Right) and targetSize.Y >= spraysize and targetSize.Z >= spraysize then
			canSpray = true
		elseif (normal==Enum.NormalId.Top or normal==Enum.NormalId.Bottom) and targetSize.X >= spraysize and targetSize.Z >= spraysize then
			canSpray = true
		end
		
		local oldGraffiti = workspace:FindFirstChild(plr.Name .. "'s Graffiti")
		if oldGraffiti then
			oldGraffiti:Destroy()
		end
		
		id = tonumber(id) or 0
		
		if canSpray then
			local p = Instance.new("Part")
			ds:AddItem(p, 60)
			p.Name = "Spray"
			p.formFactor = "Custom"
			p.Anchored = false
			p.CanCollide = false
			p.Transparency = 1
			p.Name = plr.Name .. "'s Graffiti"
			
			local d = Instance.new("Decal")
			d.Texture = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. id .. "&width=420&height=420&format=png"
			d.Face = normal
			d.Parent = p
			
			if normal == Enum.NormalId.Front or normal == Enum.NormalId.Back then
				p.Size = Vector3.new(spraysize, spraysize, .2)
			elseif normal == Enum.NormalId.Left or normal == Enum.NormalId.Right then
				p.Size = Vector3.new(.2, spraysize, spraysize)
			elseif normal == Enum.NormalId.Top or normal == Enum.NormalId.Bottom then
				p.Size = Vector3.new(spraysize, .2, spraysize)
			end
			
			local w = Instance.new("Weld")
			w.Part0 = target
			w.Part1 = p
			local cf = CFrame.new(target.CFrame:PointToObjectSpace(pos))
			w.C0 = cf
			w.C1 = CFrame.new(0,0,0)
			w.Parent = target
			p.CFrame = target.CFrame:ToWorldSpace(cf)
			p.Parent = workspace
		end
	end
end


tool.Activated:Connect(function()
	if not db and plr then
		db = true
		tool.Enabled = false
		
		local pos, normal, target, imdId = remoteFunc:InvokeClient(plr)
		if typeof(pos) == "CFrame" and typeof(imdId) == "string" and typeof(normal) == "EnumItem" and typeof(target) == "Instance" and target.Name ~= "SprayImage" then
			spray(pos, normal, target, imdId)
			anim:Play()
			sound:Play()
			wait(cooldown)
			sound:Stop()
		end
		
		db = false
		tool.Enabled = true
	end
end)

tool.Equipped:Connect(function()
	local tempChr = tool.Parent
	local newHum = tempChr:FindFirstChildWhichIsA("Humanoid")
	if newHum ~= hum then
		chr = tempChr
		hum = newHum
		plr = ps:GetPlayerFromCharacter(tempChr)
		anim = hum:LoadAnimation(sprayAnim)
	end
end)