-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = script.Resources
local Private = script.Private
local Library = ReplicatedStorage.Library
local v1 = require(Library.Functions.AppendAssetId).Wrap("rbxassetid")
local PipelineBuilder = require(Library.Modules.PipelineBuilder)
local Log = require(Library.Modules.Packages.Log)
local v2 = Log.new()
local TestEz = require(Library.Modules.Packages.TestEz)
local Asserts = require(Library.Asserts)
local DefaultProps = require(Private.DefaultProps)
local GetReplicatedProps = require(Library.Modules.PipelineBuilder.Shared.GetReplicatedProps)

require(Private.Types)

local t = {}
local v3

if not Log.isWithinLevel("Debug") then
	function t.PrepareInstance(p13, p23) --[[ PrepareInstance | Line: 42 | Upvalues: v1 (copy) ]]
		local Sound = Instance.new("Sound")

		Sound.SoundId = v1(p23)

		return Sound
	end
	v3 = PipelineBuilder.create({
		Modifiers = t
	})
	function v3._setSoundProps(p13, p23, p33, p43) --[[ _setSoundProps | Line: 57 | Upvalues: Asserts (copy), GetReplicatedProps (copy), DefaultProps (copy), Resources (copy) ]]
		Asserts.Instance(p13)
		Asserts.optional.table(p23)

		if not p43 then
			p23 = GetReplicatedProps(DefaultProps, p23, p33)
		end

		if not p23 then
			return p13
		end

		local v2, v3

		if typeof(p23.Store) == "Instance" then
			v2 = p23.Store
			v3 = p23

			if not v2 then
				v2 = p23.Store and Resources or p13.Parent
			end
		else
			v3 = p23
			v2 = p23.Store and Resources or p13.Parent
		end

		p13.Parent = v2

		if v3.Props then
			Asserts.table(v3.Props)

			for v4, v5 in v3.Props do
				p13[v4] = v5
			end
		end

		return p13
	end
	function v3.BuildSoundFromProps(p13, p23, p33, p43) --[[ BuildSoundFromProps | Line: 92 | Upvalues: GetReplicatedProps (copy), DefaultProps (copy) ]]
		local v1 = GetReplicatedProps(DefaultProps, p33, p43)
		local v2 = p13:RushGetTrackedInstance(p23)

		if typeof(v2) ~= "table" then
			return p13._setSoundProps(v2, v1, nil, true)
		end

		local v3, v4 = v1, {}

		for v5, v6 in v2 do
			local v7 = p13._setSoundProps(v6, v3, nil, true)

			if v7 then
				table.insert(v4, v7)
			end
		end

		return v4
	end

	return v3
end

task.delay(1, function() --[[ Line: 30 | Upvalues: TestEz (copy), v2 (copy) ]]
	TestEz.run(script.Sandbox, function(p1) --[[ Line: 31 | Upvalues: v2 (ref) ]]
		v2:AtDebug():Log("(Sound pipeline): TestEz result:", p1)
	end)
end)
function t.PrepareInstance(p13, p23) --[[ PrepareInstance | Line: 42 | Upvalues: v1 (copy) ]]
	local Sound = Instance.new("Sound")

	Sound.SoundId = v1(p23)

	return Sound
end
v3 = PipelineBuilder.create({
	Modifiers = t
})
function v3._setSoundProps(p13, p23, p33, p43) --[[ _setSoundProps | Line: 57 | Upvalues: Asserts (copy), GetReplicatedProps (copy), DefaultProps (copy), Resources (copy) ]]
	Asserts.Instance(p13)
	Asserts.optional.table(p23)

	if not p43 then
		p23 = GetReplicatedProps(DefaultProps, p23, p33)
	end

	if not p23 then
		return p13
	end

	local v2, v3

	if typeof(p23.Store) == "Instance" then
		v2 = p23.Store
		v3 = p23

		if not v2 then
			v2 = p23.Store and Resources or p13.Parent
		end
	else
		v3 = p23
		v2 = p23.Store and Resources or p13.Parent
	end

	p13.Parent = v2

	if v3.Props then
		Asserts.table(v3.Props)

		for v4, v5 in v3.Props do
			p13[v4] = v5
		end
	end

	return p13
end
function v3.BuildSoundFromProps(p13, p23, p33, p43) --[[ BuildSoundFromProps | Line: 92 | Upvalues: GetReplicatedProps (copy), DefaultProps (copy) ]]
	local v1 = GetReplicatedProps(DefaultProps, p33, p43)
	local v2 = p13:RushGetTrackedInstance(p23)

	if typeof(v2) ~= "table" then
		return p13._setSoundProps(v2, v1, nil, true)
	end

	local v3, v4 = v1, {}

	for v5, v6 in v2 do
		local v7 = p13._setSoundProps(v6, v3, nil, true)

		if v7 then
			table.insert(v4, v7)
		end
	end

	return v4
end

return v3