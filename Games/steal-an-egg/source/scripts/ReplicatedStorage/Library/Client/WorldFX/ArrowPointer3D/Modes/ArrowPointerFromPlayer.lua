-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Modules.Packages.Promise)

local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(script.Parent.Parent)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local WaitFor = require(ReplicatedStorage.Library.Modules.Packages.WaitFor)
local v2 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local FuncWrapper = require(ReplicatedStorage.Library.Modules.FuncWrapper)
local LocalPlayer = Players.LocalPlayer
local t = {}

t.__index = t
t.__class = "ArrowPointerFromPlayer"
function t.new(p1, p2, p3) --[[ new | Line: 41 | Upvalues: v1 (copy), t (copy), Trove (copy), FuncWrapper (copy), LocalPlayer (copy), Asserts (copy) ]]
	assert(v1.__types.OptionalConfig(p2))
	p2.CleanupOnPartDestroyed = false

	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2._funcWrapper = FuncWrapper.CreateWrapper(v2)
	v2._trackedPlayer = if p3 then p3 else LocalPlayer
	Asserts.Player(v2._trackedPlayer)
	v2._arrowPointer = v2._trove:Add((v1.new(p1, nil, p2)))
	v2._waitForRootPromise = nil
	v2:_init()

	return v2
end
function t._onCharacterAdded(p1, p2) --[[ _onCharacterAdded | Line: 68 | Upvalues: Asserts (copy), v2 (copy), WaitFor (copy) ]]
	Asserts.Model(p2)

	if p1._waitForRootPromise then
		p1._waitForRootPromise:cancel()
	end

	v2:AtTrace():Log("character added:", p2)
	p1._waitForRootPromise = p1._trove:AddPromise((WaitFor.Child(p2, "HumanoidRootPart"))):andThen(function(p12) --[[ Line: 79 | Upvalues: v2 (ref), Asserts (ref), p1 (copy) ]]
		v2:AtTrace():Log("changing target to:", p12)
		Asserts.BasePart(p12)
		p1._arrowPointer:ChangeOrigin(p12)
	end):catch(function(p1) --[[ Line: 85 | Upvalues: v2 (ref) ]]
		v2:AtWarning():Log((("Failed to fetch root for arrow tracking: %*"):format(p1)))
	end)
end
function t._onCharacterRemoving(p1) --[[ _onCharacterRemoving | Line: 90 ]]
	if p1._waitForRootPromise then
		p1._waitForRootPromise:cancel()
	end

	p1._arrowPointer:Stop()
end
function t.Start(p1) --[[ Start | Line: 98 ]]
	return p1._arrowPointer:Start()
end
function t.Stop(p1) --[[ Stop | Line: 102 ]]
	return p1._arrowPointer:Stop()
end
function t.ChangeTarget(p1, p2) --[[ ChangeTarget | Line: 106 ]]
	return p1._arrowPointer:ChangeTarget(p2)
end
function t.Destroy(p1) --[[ Destroy | Line: 110 ]]
	p1._trove:Destroy()
	table.clear(p1)
	setmetatable(p1, nil)
end
function t._init(p1) --[[ _init | Line: 121 ]]
	local Character = p1._trackedPlayer.Character

	if Character then
		p1:_onCharacterAdded(Character)
	end

	p1._trove:Connect(p1._trackedPlayer.CharacterAdded, p1._funcWrapper(p1._onCharacterAdded))
	p1._trove:Connect(p1._trackedPlayer.CharacterRemoving, p1._funcWrapper(p1._onCharacterRemoving))

	return p1
end

return t