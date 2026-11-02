-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Private = script.Private
local Library = ReplicatedStorage.Library
local v1 = require(Library.Functions.AppendAssetId).Wrap("rbxassetid")
local PipelineBuilder = require(Library.Modules.PipelineBuilder)

require(Library.Modules.Packages.Log).new()
require(Library.Modules.Packages.TestEz)

local Asserts = require(Library.Asserts)
local GetReplicatedProps = require(Library.Modules.PipelineBuilder.Shared.GetReplicatedProps)
local DefaultTransitions = require(Private.DefaultTransitions)

require(Private.Types)

local v2 = PipelineBuilder.create({
	Modifiers = {
		PrepareInstance = function(p1, p2) --[[ PrepareInstance | Line: 45 | Upvalues: v1 (copy) ]]
			local Animation = Instance.new("Animation")

			Animation.AnimationId = v1(p2)

			return Animation
		end
	},
	Resources = {
		DefaultTransitions = DefaultTransitions
	}
})

function v2.GetDataFromAnimation(p1, p2, p3, p4, p5) --[[ GetDataFromAnimation | Line: 61 | Upvalues: Asserts (copy), GetReplicatedProps (copy), DefaultTransitions (copy) ]]
	Asserts.Instance(p2)
	Asserts.optional.table(p3)

	if not p5 then
		p3 = GetReplicatedProps(DefaultTransitions, p3, p4)
	end

	return not p3 and {
		weight = 1,
		anim = p2
	} or {
		anim = p2,
		looped = p3.Looped,
		weight = p3.DropWeight or 1,
		protocol = {
			Play = p3.Play,
			Stop = p3.Stop
		}
	}
end
function v2.GetAndSerializeAnimation(p1, p2, p3, p4) --[[ GetAndSerializeAnimation | Line: 94 | Upvalues: GetReplicatedProps (copy), DefaultTransitions (copy) ]]
	local v1 = GetReplicatedProps(DefaultTransitions, p3, p4)
	local v2 = p1:RushGetTrackedInstance(p2)

	if typeof(v2) ~= "table" then
		return p1:GetDataFromAnimation(v2, v1, nil, true)
	end

	local v3, v4 = v1, {}

	for v5, v6 in v2 do
		local v7 = p1:GetDataFromAnimation(v6, v3, nil, true)

		if v7 then
			table.insert(v4, v7)
		end
	end

	return v4
end

return v2