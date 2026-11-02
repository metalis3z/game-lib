-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PlayerCollisions, time of decompilation: Sun May  3 10:10:55 2026 ]]
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local t1 = {
	initialized = false
}
local t2 = {}

local function setPlayerCollisionGroup(p1) -- line: 17
	if not p1:IsA("BasePart") then
		return
	end

	p1.CollisionGroup = "Players"
end
local function trackCharacter(p2, p3) -- line: 35
	-- upvalues: t2 (copy), setPlayerCollisionGroup (copy)
	local v14 = t2[p2]

	if v14 ~= nil and v14.descendantAdded ~= nil then
		v14.descendantAdded:Disconnect()
		v14.descendantAdded = nil
	end

	for _, v16 in p3:GetDescendants() do
		if v16:IsA("BasePart") then
			v16.CollisionGroup = "Players"
		end
	end

	local v17 = t2[p2]

	if v17 == nil then
		return
	end

	v17.descendantAdded = p3.DescendantAdded:Connect(setPlayerCollisionGroup)
end
local function onPlayerAdded(p4) -- line: 50
	-- upvalues: t2 (copy), trackCharacter (copy)
	if t2[p4] ~= nil then
		return
	end

	t2[p4] = {
		characterAdded = p4.CharacterAdded:Connect(function(character) -- line: 56
			-- upvalues: trackCharacter (copy), p4 (copy)
			trackCharacter(p4, character)
		end)
	}

	if p4.Character then
		trackCharacter(p4, p4.Character)
	end
end
local function onPlayerRemoving(p5) -- line: 68
	-- upvalues: t2 (copy)
	local v20 = t2[p5]

	if v20 == nil then
		return
	end

	v20.characterAdded:Disconnect()

	local v21 = t2[p5]

	if v21 ~= nil and v21.descendantAdded ~= nil then
		v21.descendantAdded:Disconnect()
		v21.descendantAdded = nil
	end

	t2[p5] = nil
end

function t1.init(p6) -- line: 79
	-- upvalues: PhysicsService (copy), Players (copy), onPlayerAdded (copy), onPlayerRemoving (copy)
	if p6.initialized then
		return
	end

	p6.initialized = true
	pcall(function() -- line: 86
		-- upvalues: PhysicsService (copy)
		PhysicsService:RegisterCollisionGroup("Players")
	end)
	PhysicsService:CollisionGroupSetCollidable("Players", "Players", false)

	for _, v24 in Players:GetPlayers() do
		onPlayerAdded(v24)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)
end

return t1
