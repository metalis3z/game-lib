--credit to quartz games studio
local t = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local SeedPackSpawnServerLocations = game.Workspace.Map.SeedPackSpawnServerLocations
local SeedPackSpawnClient = game.Workspace.Map.SeedPackSpawnClient
local SeedPacks = game.ReplicatedStorage.Assets.SeedPacks
local Seeds = game.ReplicatedStorage.Assets.Seeds
local PopVFX = game.ReplicatedStorage.Assets.PopVFX
local NotificationController = require(Players.LocalPlayer.PlayerScripts.Controllers.NotificationController)
local t2 = {}
local t3 = {}
local v1 = nil

local function StartLoop() --[[ StartLoop | Line: 34 | Upvalues: v1 (ref), RunService (copy), t2 (copy), t3 (copy) ]]
	if not v1 then
		v1 = RunService.Heartbeat:Connect(function() --[[ Line: 36 | Upvalues: t2 (ref), t3 (ref) ]]
			local v1 = os.clock()
			local v2 = math.sin(v1 * 2) * 0.5
			local v3 = CFrame.Angles(0, v1 * 1.5, 0)

			for v4, v5 in t2 do
				local v6 = t3[v5[3]]

				if v6 and v5[3].Parent then
					v5[3].CFrame = v6 * v3 + Vector3.new(0, v2, 0)
				end
			end
		end)
	end
end

local function StopLoop() --[[ StopLoop | Line: 50 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1:Disconnect()
	v1 = nil
end

local function WaitForSeedPackAttributes(p1) --[[ WaitForSeedPackAttributes | Line: 60 ]]
	local v1 = os.clock() + 1

	while p1.Parent do
		local v2 = p1:GetAttribute("SeedPack")
		local v3 = if p1:GetAttribute("RainbowSeed") == true then true else false
		local v4 = if p1:GetAttribute("GoldSeed") == true then true else false

		if v2 == nil and not (v3 or v4) then
			if v1 <= os.clock() then
				break
			end

			p1:GetAttributeChangedSignal("SeedPack"):Wait()
		else
			return if type(v2) == "string" then v2 else nil, v3, v4
		end
	end

	return nil, false, false
end

function t.SpawnClient(p1, p2, p3) --[[ SpawnClient | Line: 75 | Upvalues: WaitForSeedPackAttributes (copy), Seeds (copy), SeedPacks (copy), SeedPackSpawnClient (copy), t3 (copy), t2 (copy), t (copy), v1 (ref), RunService (copy), NotificationController (copy) ]]
	task.spawn(function() --[[ Line: 76 | Upvalues: p2 (copy), p3 (ref), WaitForSeedPackAttributes (ref), Seeds (ref), SeedPacks (ref), SeedPackSpawnClient (ref), t3 (ref), t2 (ref), t (ref), v1 (ref), RunService (ref), NotificationController (ref) ]]
		if not p2.Parent then
			return
		end

		local v12 = p2:GetAttribute("RainbowSeed") == true
		local v2 = if p2:GetAttribute("GoldSeed") == true then true else false

		if not v12 and (not v2 and (p3 == nil or p3 == "")) then
			local v3, v4, v5 = WaitForSeedPackAttributes(p2)

			p3 = v3
			v12 = v4
			v2 = v5
		end

		if not p2.Parent then
			return
		end

		local v6 = nil
		local v7 = nil
		local v8 = nil

		if v12 then
			local Rainbow = Seeds:FindFirstChild("Rainbow")

			v6 = Rainbow
			v7 = 5
			v8 = "Rainbow Seed"
		elseif v2 then
			local Gold = Seeds:FindFirstChild("Gold")

			v6 = Gold
			v7 = 5
			v8 = "Gold Seed"
		elseif type(p3) == "string" and p3 ~= "" then
			v8 = p3
			v6, v7 = SeedPacks:FindFirstChild(p3), 3
		end

		if not v6 then
			return
		end

		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.CanCollide = false
		Part.Size = Vector3.new(1, 1, 1)
		Part.Transparency = 1
		Part.CFrame = p2.CFrame
		Part.Parent = SeedPackSpawnClient

		local v11 = v6:Clone()
		local v122

		if v11:IsA("BasePart") then
			v122 = Instance.new("Model")
			v11.Anchored = false
			v11.Parent = v122
			v122.PrimaryPart = v11
			v122.Parent = SeedPackSpawnClient
			v11.Size = v11.Size * v7
		else
			v122 = v11
			v11.Parent = SeedPackSpawnClient

			if not v11.PrimaryPart then
				for v13, v14 in v11:GetDescendants() do
					if v14:IsA("BasePart") then
						v11.PrimaryPart = v14

						break
					end
				end
			end

			if not v11.PrimaryPart then
				Part:Destroy()
				v11:Destroy()
			else
				v11:ScaleTo(v7)
			end
		end

		local _, v15 = v122:GetBoundingBox()

		t3[Part] = p2.CFrame * CFrame.new(0, -p2.Size.Y / 2, 0) * CFrame.new(0, v15.Y / 2 + 1, 0)

		local Attachment = Instance.new("Attachment")

		Attachment.Parent = v122.PrimaryPart

		local Attachment2 = Instance.new("Attachment")

		Attachment2.Parent = Part

		local AlignPosition = Instance.new("AlignPosition")

		AlignPosition.Attachment0 = Attachment
		AlignPosition.Attachment1 = Attachment2
		AlignPosition.RigidityEnabled = true
		AlignPosition.Parent = v122.PrimaryPart

		local AlignOrientation = Instance.new("AlignOrientation")

		AlignOrientation.Attachment0 = Attachment
		AlignOrientation.Attachment1 = Attachment2
		AlignOrientation.RigidityEnabled = true
		AlignOrientation.Parent = v122.PrimaryPart

		local v16 = t2
		local t4 = { p2, v122, Part }

		table.insert(v16, t4)

		local v17 = nil

		v17 = p2.Destroying:Connect(function() --[[ Line: 172 | Upvalues: t (ref), p2 (ref), v122 (ref), v17 (ref) ]]
			t:DespawnClient(p2, v122)
			v17:Disconnect()
		end)

		if not v1 then
			v1 = RunService.Heartbeat:Connect(function() --[[ Line: 36 | Upvalues: t2 (ref), t3 (ref) ]]
				local v1 = os.clock()
				local v2 = math.sin(v1 * 2) * 0.5
				local v3 = CFrame.Angles(0, v1 * 1.5, 0)

				for v4, v5 in t2 do
					local v6 = t3[v5[3]]

					if v6 and v5[3].Parent then
						v5[3].CFrame = v6 * v3 + Vector3.new(0, v2, 0)
					end
				end
			end)
		end

		if v8 then
			NotificationController:CreateSeedPackSpawnNotification(v8)
		end
	end)
end
function t.DespawnClient(p1, p2, p3) --[[ DespawnClient | Line: 186 | Upvalues: t2 (copy), t3 (copy), v1 (ref) ]]
	for k, v in pairs(t2) do
		if v[1] == p2 then
			local v12 = table.find(t2, v)

			if v[3] then
				t3[v[3]] = nil
				v[3]:Destroy()
				v[3] = nil
			end

			if v[2] then
				v[2]:Destroy()
				v[2] = nil
			end

			if not v12 then
				break
			end

			table.remove(t2, v12)

			break
		end
	end

	if #t2 ~= 0 or not v1 then
		return
	end

	v1:Disconnect()
	v1 = nil
end
function t.Start(p1) --[[ Start | Line: 210 ]] end
function t.Init(p1) --[[ Init | Line: 214 | Upvalues: SeedPackSpawnServerLocations (copy), t (copy), Networking (copy), PopVFX (copy), SoundService (copy) ]]
	for k, v in pairs(SeedPackSpawnServerLocations:GetChildren()) do
		t:SpawnClient(v, v:GetAttribute("SeedPack"))
	end

	SeedPackSpawnServerLocations.ChildAdded:Connect(function(p1) --[[ Line: 218 | Upvalues: t (ref) ]]
		t:SpawnClient(p1, p1:GetAttribute("SeedPack"))
	end)
	Networking.SeedPackSpawn.FX.OnClientEvent:Connect(function(p1) --[[ Line: 221 | Upvalues: PopVFX (ref), SoundService (ref) ]]
		local v1 = PopVFX:Clone()

		v1.Position = p1
		v1.Parent = game.Workspace

		local Sound = Instance.new("Sound")

		Sound.SoundId = "rbxassetid://70730950826307"
		Sound.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		Sound.Parent = v1
		task.defer(function() --[[ Line: 232 | Upvalues: v1 (copy), Sound (copy) ]]
			for k, v in pairs(v1.PopEffect:GetChildren()) do
				v:Emit(v:GetAttribute("EmitCount"))
			end

			Sound:Play()
			game.Debris:AddItem(v1, 3)
		end)
	end)
end

return t