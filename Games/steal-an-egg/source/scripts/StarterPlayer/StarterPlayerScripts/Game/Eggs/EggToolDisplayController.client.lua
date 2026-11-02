-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local EggToolDisplay = require(ReplicatedStorage.Library.Client.Eggs.EggToolDisplay)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Log.new()
local t = {}

local function destroyActiveDisplay(p1) --[[ destroyActiveDisplay | Line: 31 ]]
	p1.ActiveDisplayVersion = p1.ActiveDisplayVersion + 1

	if p1.ActiveDisplay ~= nil then
		p1.ActiveDisplay:Destroy()
		p1.ActiveDisplay = nil
	end

	p1.ActiveTool = nil
end

local function attachTool(p1, p2) --[[ attachTool | Line: 40 | Upvalues: EggToolDisplay (copy), v1 (copy), EggCmds (copy), Players (copy) ]]
	if p1.ActiveTool == p2 then
		return
	end

	p1.ActiveDisplayVersion = p1.ActiveDisplayVersion + 1

	if p1.ActiveDisplay ~= nil then
		p1.ActiveDisplay:Destroy()
		p1.ActiveDisplay = nil
	end

	p1.ActiveTool = nil

	local v12 = EggToolDisplay.GetToolUid(p2)

	if v12 == nil then
		v1:AtError():Log((("Egg tool %* is missing an egg UID"):format((p2:GetFullName()))))

		return
	end

	local v2 = EggCmds.GetRuntimeRecord(p1.Owner.UserId, v12)

	if v2 == nil and p1.Owner == Players.LocalPlayer then
		v2 = EggCmds.RequestLocalEggRecord(v12)
	end

	if v2 == nil then
		v1:AtDebug():Log((("Egg tool %* has no record for owner %*"):format(p2:GetFullName(), p1.Owner.UserId)))

		return
	end

	p1.ActiveTool = p2
	p1.ActiveDisplayVersion = p1.ActiveDisplayVersion + 1

	local v4 = EggToolDisplay.new(p2, {
		OwnerUserId = p1.Owner.UserId,
		UID = v12,
		ModelName = ("%*_%*"):format(p1.Owner.UserId, v12),
		Record = v2
	})

	if p1.ActiveTool == p2 and (p1.ActiveDisplayVersion == p1.ActiveDisplayVersion and p2.Parent ~= nil) then
		p1.ActiveDisplay = v4
	else
		v4:Destroy()
	end
end

local function refreshActiveTool(p1) --[[ refreshActiveTool | Line: 80 | Upvalues: EggToolDisplay (copy), attachTool (copy) ]]
	local Character = p1.Owner.Character

	if Character == nil then
		return
	end

	for i, v in ipairs(Character:GetChildren()) do
		if v.ClassName == "Tool" and EggToolDisplay.IsEggTool(v) then
			attachTool(p1, v)

			return
		end
	end
end

local function bindCharacter(p1, p2) --[[ bindCharacter | Line: 97 | Upvalues: Trove (copy), EggToolDisplay (copy), attachTool (copy), refreshActiveTool (copy) ]]
	if p1.CharacterTrove ~= nil then
		p1.CharacterTrove:Destroy()
	end

	p1.ActiveDisplayVersion = p1.ActiveDisplayVersion + 1

	if p1.ActiveDisplay ~= nil then
		p1.ActiveDisplay:Destroy()
		p1.ActiveDisplay = nil
	end

	p1.ActiveTool = nil

	local v1 = Trove.new()

	p1.CharacterTrove = v1
	v1:Connect(p2.ChildAdded, function(p12) --[[ Line: 105 | Upvalues: EggToolDisplay (ref), attachTool (ref), p1 (copy) ]]
		if p12.ClassName ~= "Tool" or not EggToolDisplay.IsEggTool(p12) then
			return
		end

		attachTool(p1, p12)
	end)
	v1:Connect(p2.ChildRemoved, function(p12) --[[ Line: 110 | Upvalues: p1 (copy) ]]
		if p12 ~= p1.ActiveTool then
			return
		end

		local v1 = p1

		v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1

		if v1.ActiveDisplay ~= nil then
			v1.ActiveDisplay:Destroy()
			v1.ActiveDisplay = nil
		end

		v1.ActiveTool = nil
	end)
	refreshActiveTool(p1)
end

local function destroyPlayerState(p1) --[[ destroyPlayerState | Line: 118 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 == nil then
		return
	end

	v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1

	if v1.ActiveDisplay ~= nil then
		v1.ActiveDisplay:Destroy()
		v1.ActiveDisplay = nil
	end

	v1.ActiveTool = nil

	if v1.CharacterTrove ~= nil then
		v1.CharacterTrove:Destroy()
	end

	v1.Trove:Destroy()
	t[p1] = nil
end

local function trackPlayer(p1) --[[ trackPlayer | Line: 131 | Upvalues: t (copy), Trove (copy), bindCharacter (copy) ]]
	local v1 = t[p1]

	if v1 ~= nil then
		v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1

		if v1.ActiveDisplay ~= nil then
			v1.ActiveDisplay:Destroy()
			v1.ActiveDisplay = nil
		end

		v1.ActiveTool = nil

		if v1.CharacterTrove ~= nil then
			v1.CharacterTrove:Destroy()
		end

		v1.Trove:Destroy()
		t[p1] = nil
	end

	local t2 = {
		CharacterTrove = nil,
		ActiveTool = nil,
		ActiveDisplay = nil,
		ActiveDisplayVersion = 0,
		Owner = p1,
		Trove = Trove.new()
	}

	t[p1] = t2
	t2.Trove:Connect(p1.CharacterAdded, function(p1) --[[ Line: 144 | Upvalues: bindCharacter (ref), t2 (copy) ]]
		bindCharacter(t2, p1)
	end)
	t2.Trove:Connect(p1.CharacterRemoving, function() --[[ Line: 147 | Upvalues: t2 (copy) ]]
		local v1 = t2

		v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1

		if v1.ActiveDisplay ~= nil then
			v1.ActiveDisplay:Destroy()
			v1.ActiveDisplay = nil
		end

		v1.ActiveTool = nil

		if t2.CharacterTrove == nil then
			return
		end

		t2.CharacterTrove:Destroy()
		t2.CharacterTrove = nil
	end)

	if p1.Character == nil then
		return
	end

	bindCharacter(t2, p1.Character)
end

Players.PlayerAdded:Connect(function(p1) --[[ Line: 163 | Upvalues: trackPlayer (copy) ]]
	task.defer(trackPlayer, p1)
end)
Players.PlayerRemoving:Connect(destroyPlayerState)

for i, v in ipairs(Players:GetPlayers()) do
	task.defer(trackPlayer, v)
end