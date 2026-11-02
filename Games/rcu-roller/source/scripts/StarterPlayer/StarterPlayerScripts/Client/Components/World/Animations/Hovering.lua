-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:23:05
-- Luau version 6, Types version 3
-- Time taken: 0.001873 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Hovering";
})
local var4_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
function any_new_result1.HeartbeatUpdate(arg1, arg2) -- Line 29
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: CurrentCamera_upvr (readonly)
	]]
	local PrimaryPart = arg1.Instance.PrimaryPart
	if not PrimaryPart then
	else
		local any_getMapIds_result1 = arg1:getMapIds()
		if any_getMapIds_result1 then
			local any_getCurrentMap_result1 = var4_upvw:getCurrentMap(true)
			if not any_getCurrentMap_result1 then return end
			if not table.find(any_getMapIds_result1, any_getCurrentMap_result1) then
				do
					return
				end
				-- KONSTANTWARNING: GOTO [35] #28
			end
		elseif 300 < LocalPlayer_upvr:DistanceFromCharacter(PrimaryPart.Position) then
			return
		end
		local _, any_WorldToViewportPoint_result2 = CurrentCamera_upvr:WorldToViewportPoint(PrimaryPart.Position)
		if not any_WorldToViewportPoint_result2 then return end
		local _originalCFrame = arg1._originalCFrame
		if not _originalCFrame then
			arg1._originalCFrame = PrimaryPart.CFrame
			_originalCFrame = PrimaryPart.CFrame
		end
		local _offset = arg1._offset
		if not _offset then
			arg1._offset = arg1.Instance:GetAttribute("offset") or 0
			_offset = arg1._offset
		end
		arg1.Instance:PivotTo(_originalCFrame + Vector3.new(0, math.sin(3 * (time() + _offset)) / 6 + 0.1, 0))
	end
end
function any_new_result1.getMapIds(arg1) -- Line 73
	if not arg1._mapIds then return end
	local string_split_result1 = string.split(arg1._mapIds, ',')
	for i, v in ipairs(string_split_result1) do
		string_split_result1[i] = tonumber(v)
	end
	return string_split_result1
end
function any_new_result1.Start(arg1) -- Line 87
	arg1._mapIds = arg1.Instance:GetAttribute("hoveringMapIds")
end
local var23_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 91
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var23_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
	]]
	var4_upvw = Knit_upvr.GetController("MapController")
	var23_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1