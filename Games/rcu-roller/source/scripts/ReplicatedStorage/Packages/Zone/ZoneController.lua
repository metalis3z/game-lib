-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:15:26

-- Luau version 6, Types version 3

-- Time taken: 0.011493 seconds


-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

local Tracker_upvr = require(script.Tracker)

local CollectiveWorldModel_upvr = require(script.CollectiveWorldModel)

local enums_upvr = require(script.Parent.Enum).enums

local Players_upvr = game:GetService("Players")

local tbl_7_upvr = {}

local var6_upvw = 0

local tbl_6_upvr = {}

local tbl_4_upvr = {}

local tbl_3_upvw = {}

local tbl_upvw = {}

local tbl_8_upvw = {}

local tbl_10_upvw = {}

local var13_upvw = 0

local RunService = game:GetService("RunService")

local tbl_9_upvr = {}

local any_IsClient_result1_upvr = RunService:IsClient()

if any_IsClient_result1_upvr then

	any_IsClient_result1_upvr = Players_upvr.LocalPlayer

end

local module_upvr = {}

local tbl_2_upvr = {

	player = Tracker_upvr.new("player");

	item = Tracker_upvr.new("item");

}

module_upvr.trackers = tbl_2_upvr

local function _(arg1) -- Line 40, Named "dictLength"

	local var23 = 0

	for _, _ in pairs(arg1) do

		var23 += 1

	end

	return var23

end

local function _(arg1, arg2, arg3) -- Line 48, Named "fillOccupants"

	local var27 = arg1[arg2]

	if not var27 then

		var27 = {}

		arg1[arg2] = var27

	end

	local children_2 = arg3:IsA("Player")

	if children_2 then

		children_2 = arg3.Character

	end

	var27[arg3] = children_2 or true

end

local tbl_5_upvr = {

	player = function(arg1) -- Line 59

		--[[ Upvalues[3]:

			[1]: module_upvr (readonly)

			[2]: tbl_7_upvr (readonly)

			[3]: var6_upvw (read and write)

		]]

		return module_upvr._getZonesAndItems("player", tbl_7_upvr, var6_upvw, true, arg1)

	end;

	localPlayer = function(arg1) -- Line 62

		--[[ Upvalues[3]:

			[1]: any_IsClient_result1_upvr (readonly)

			[2]: module_upvr (readonly)

			[3]: tbl_2_upvr (readonly)

		]]

		local module = {}

		local Character = any_IsClient_result1_upvr.Character

		if not Character then

			return module

		end

		for _, v_2 in pairs(module_upvr.getTouchingZones(Character, true, arg1, tbl_2_upvr.player)) do

			if v_2.activeTriggers.localPlayer then

				local var41 = any_IsClient_result1_upvr

				local var42 = module[v_2]

				if not var42 then

					var42 = {}

					module[v_2] = var42

				end

				local children_3 = var41:IsA("Player")

				if children_3 then

					children_3 = var41.Character

				end

				var42[var41] = children_3 or true

			end

		end

		return module

	end;

	item = function(arg1) -- Line 76

		--[[ Upvalues[3]:

			[1]: module_upvr (readonly)

			[2]: tbl_7_upvr (readonly)

			[3]: var6_upvw (read and write)

		]]

		return module_upvr._getZonesAndItems("item", tbl_7_upvr, var6_upvw, true, arg1)

	end;

}

local Janitor_upvr = require(script.Parent.Janitor)

function module_upvr._registerZone(arg1) -- Line 84

	--[[ Upvalues[3]:

		[1]: tbl_4_upvr (readonly)

		[2]: Janitor_upvr (readonly)

		[3]: module_upvr (readonly)

	]]

	tbl_4_upvr[arg1] = true

	local any_add_result1 = arg1.janitor:add(Janitor_upvr.new(), "destroy")

	arg1._registeredJanitor = any_add_result1

	any_add_result1:add(arg1.updated:Connect(function() -- Line 88

		--[[ Upvalues[1]:

			[1]: module_upvr (copied, readonly)

		]]

		module_upvr._updateZoneDetails()

	end), "Disconnect")

	module_upvr._updateZoneDetails()

end

function module_upvr._deregisterZone(arg1) -- Line 94

	--[[ Upvalues[2]:

		[1]: tbl_4_upvr (readonly)

		[2]: module_upvr (readonly)

	]]

	tbl_4_upvr[arg1] = nil

	arg1._registeredJanitor:destroy()

	arg1._registeredJanitor = nil

	module_upvr._updateZoneDetails()

end

function module_upvr._registerConnection(arg1, arg2) -- Line 101

	--[[ Upvalues[5]:

		[1]: var13_upvw (read and write)

		[2]: tbl_7_upvr (readonly)

		[3]: module_upvr (readonly)

		[4]: tbl_6_upvr (readonly)

		[5]: tbl_5_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local var56 = 0

	for _, _ in pairs(arg1.activeTriggers) do

		var56 += 1

	end

	var13_upvw += 1

	if var56 == 0 then

		var56 = true

		tbl_7_upvr[arg1] = var56

		var56 = module_upvr

		var56._updateZoneDetails()

	end

	var56 = tbl_6_upvr

	local var60 = var56[arg2]

	var56 = tbl_6_upvr

	if not var60 or not (var60 + 1) then

	end

	var56[arg2] = 1

	var56 = arg1.activeTriggers

	var56[arg2] = true

	var56 = arg1.touchedConnectionActions[arg2]

	if var56 then

		var56 = arg1._formTouchedConnection

		var56(arg1, arg2)

	end

	var56 = tbl_5_upvr[arg2]

	if var56 then

		var56 = module_upvr._formHeartbeat

		var56(arg2)

	end

end

function module_upvr.updateDetection(arg1) -- Line 121

	--[[ Upvalues[2]:

		[1]: Tracker_upvr (readonly)

		[2]: enums_upvr (readonly)

	]]

	for i_4, v_4 in pairs({

		enterDetection = "_currentEnterDetection";

		exitDetection = "_currentExitDetection";

	}) do

		local var69 = arg1[i_4]

		if var69 == enums_upvr.Detection.Automatic then

			if 729000 < Tracker_upvr.getCombinedTotalVolumes() then

				var69 = enums_upvr.Detection.Centre

			else

				var69 = enums_upvr.Detection.WholeBody

			end

		end

		arg1[v_4] = var69

	end

end

local Heartbeat_upvr = RunService.Heartbeat

function module_upvr._formHeartbeat(arg1) -- Line 140
	-- Zone heartbeat disabled: decompiled code has CF ANALYSIS FAILED
	-- World components use ProximityPrompts as fallback
	return
end



function module_upvr._deregisterConnection(arg1, arg2) -- Line 249

	--[[ Upvalues[5]:

		[1]: var13_upvw (read and write)

		[2]: tbl_6_upvr (readonly)

		[3]: tbl_9_upvr (readonly)

		[4]: tbl_7_upvr (readonly)

		[5]: module_upvr (readonly)

	]]

	var13_upvw -= 1

	local var144

	if tbl_6_upvr[arg2] == 1 then

		tbl_6_upvr[arg2] = nil

		local var145 = tbl_9_upvr[arg2]

		if var145 then

			var144 = nil

			tbl_9_upvr[arg2] = var144

			var145:Disconnect()

			-- KONSTANTWARNING: GOTO [24] #23

		end

	else

		local var146 = tbl_6_upvr

		var146[arg2] -= 1

	end

	arg1.activeTriggers[arg2] = nil

	var144 = 0

	for _, _ in pairs(arg1.activeTriggers) do

		var144 += 1

	end

	if var144 == 0 then

		tbl_7_upvr[arg1] = nil

		module_upvr._updateZoneDetails()

	end

	if arg1.touchedConnectionActions[arg2] then

		arg1:_disconnectTouchedConnection(arg2)

	end

end

function module_upvr._updateZoneDetails() -- Line 271

	--[[ Upvalues[7]:

		[1]: tbl_3_upvw (read and write)

		[2]: tbl_upvw (read and write)

		[3]: tbl_8_upvw (read and write)

		[4]: tbl_10_upvw (read and write)

		[5]: var6_upvw (read and write)

		[6]: tbl_4_upvr (readonly)

		[7]: tbl_7_upvr (readonly)

	]]

	tbl_3_upvw = {}

	tbl_upvw = {}

	tbl_8_upvw = {}

	tbl_10_upvw = {}

	var6_upvw = 0

	for i_6, _ in pairs(tbl_4_upvr) do

		local var157 = tbl_7_upvr[i_6]

		if var157 then

			var6_upvw += i_6.volume

		end

		for _, v_7 in pairs(i_6.zoneParts) do

			if var157 then

				table.insert(tbl_3_upvw, v_7)

				tbl_upvw[v_7] = i_6

			end

			table.insert(tbl_8_upvw, v_7)

			tbl_10_upvw[v_7] = i_6

		end

	end

end

function module_upvr._getZonesAndItems(arg1, arg2, arg3, arg4, arg5) -- Line 293

	--[[ Upvalues[4]:

		[1]: tbl_2_upvr (readonly)

		[2]: module_upvr (readonly)

		[3]: Players_upvr (readonly)

		[4]: CollectiveWorldModel_upvr (readonly)

	]]

	-- KONSTANTERROR: [0] 1. Error Block 81 start (CF ANALYSIS FAILED)

	local var173 = arg3

	if not var173 then

		for i_8, _ in pairs(arg2) do

			var173 += i_8.volume

		end

	end

	local module_4 = {}

	local var178 = tbl_2_upvr[arg1]

	if var178.totalVolume < var173 then

		for _, v_9 in pairs(var178.items) do

			local _

			for _, v_10 in pairs(module_upvr.getTouchingZones(v_9, arg4, arg5, var178)) do

				if not arg4 or v_10.activeTriggers[arg1] then

					local var186 = v_9

					if arg1 == "player" then

						var186 = Players_upvr:GetPlayerFromCharacter(v_9)

					end

					if var186 then

						local var187 = var186

						local var188 = module_4[v_10]

						if not var188 then

							var188 = {}

							module_4[v_10] = var188

						end

						local children = var187:IsA("Player")

						if children then

							children = var187.Character

						end

						var188[var187] = children or true

					end

				end

			end

		end

		return module_4

	end

	local pairs_result1_12, pairs_result2_6, pairs_result3_4 = pairs(arg2)

	-- KONSTANTERROR: [0] 1. Error Block 81 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [167] 126. Error Block 46 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [167] 126. Error Block 46 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [79] 61. Error Block 23 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [79] 61. Error Block 23 end (CF ANALYSIS FAILED)

end

function module_upvr.getZones() -- Line 354

	--[[ Upvalues[1]:

		[1]: tbl_4_upvr (readonly)

	]]

	local module_2 = {}

	for i_11, _ in pairs(tbl_4_upvr) do

		table.insert(module_2, i_11)

	end

	return module_2

end

function module_upvr.getTouchingZones(arg1, arg2, arg3, arg4) -- Line 374

	--[[ Upvalues[7]:

		[1]: enums_upvr (readonly)

		[2]: Tracker_upvr (readonly)

		[3]: tbl_3_upvw (read and write)

		[4]: tbl_8_upvw (read and write)

		[5]: tbl_upvw (read and write)

		[6]: tbl_10_upvw (read and write)

		[7]: CollectiveWorldModel_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	-- KONSTANTERROR: [0] 1. Error Block 83 start (CF ANALYSIS FAILED)

	local var209

	local var210

	if arg4 then

		var210 = arg4.exitDetections

		var209 = var210[arg1]

		var210 = arg4.exitDetections

		var210[arg1] = nil

	end

	var210 = nil

	if arg1:IsA("BasePart") then

		var210 = arg1.Size

		table.insert({}, arg1)

		-- KONSTANTWARNING: GOTO [68] #51

	end

	-- KONSTANTERROR: [0] 1. Error Block 83 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [33] 26. Error Block 86 start (CF ANALYSIS FAILED)

	if (var209 or arg3) == enums_upvr.Detection.WholeBody then

		local any_getCharacterSize_result1, any_getCharacterSize_result2 = Tracker_upvr.getCharacterSize(arg1)

		var210 = any_getCharacterSize_result1

		local _ = any_getCharacterSize_result2

	else

		local HumanoidRootPart = arg1:FindFirstChild("HumanoidRootPart")

		if HumanoidRootPart then

			var210 = HumanoidRootPart.Size

			table.insert(arg1:GetChildren(), HumanoidRootPart)

		end

	end

	if not var210 or not HumanoidRootPart.CFrame then

		return {}

	end

	if not arg2 or not tbl_3_upvw then

		local var217 = tbl_8_upvw

	end

	if not arg2 or not tbl_upvw then

	end

	local OverlapParams_new_result1 = OverlapParams.new()

	OverlapParams_new_result1.FilterType = Enum.RaycastFilterType.Whitelist

	OverlapParams_new_result1.MaxParts = #var217

	OverlapParams_new_result1.FilterDescendantsInstances = var217

	-- KONSTANTERROR: Expression was reused, decompilation is incorrect

	for _, v_12 in pairs(CollectiveWorldModel_upvr:GetPartBoundsInBox(HumanoidRootPart.CFrame, var210, OverlapParams_new_result1)) do

		local var222 = tbl_10_upvw[v_12]

		if var222 and var222.allZonePartsAreBlocks then

			({})[var222] = true

			;({})[v_12] = var222

		else

			table.insert({}, v_12)

		end

	end

	-- KONSTANTERROR: Expression was reused, decompilation is incorrect

	-- KONSTANTERROR: [33] 26. Error Block 86 end (CF ANALYSIS FAILED)

end

local module_3_upvr = {}

function module_upvr.setGroup(arg1, arg2) -- Line 491

	--[[ Upvalues[1]:

		[1]: module_3_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local var232 = module_3_upvr[arg1]

	if not var232 then

		var232 = {}

		module_3_upvr[arg1] = var232

	end

	var232.onlyEnterOnceExitedAll = true

	var232._name = arg1

	var232._memberZones = {}

	if typeof(arg2) == "table" then

		for i_13, v_13 in pairs(arg2) do

			var232[i_13] = v_13

		end

	end

	return var232

end

function module_upvr.getGroup(arg1) -- Line 515

	--[[ Upvalues[1]:

		[1]: module_3_upvr (readonly)

	]]

	return module_3_upvr[arg1]

end

if RunService:IsClient() then

else

end

local var236_upvw

local formatted_upvr = string.format("ZonePlus%sContainer", "Server")

function module_upvr.getWorkspaceContainer() -- Line 521

	--[[ Upvalues[2]:

		[1]: var236_upvw (read and write)

		[2]: formatted_upvr (readonly)

	]]

	local var238 = var236_upvw

	if not var238 then

		var238 = workspace:FindFirstChild(formatted_upvr)

	end

	if not var238 then

		local Folder = Instance.new("Folder")

		Folder.Name = formatted_upvr

		Folder.Parent = workspace

		var236_upvw = Folder

	end

	return Folder

end

return module_upvr
