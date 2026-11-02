-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:15:18

-- Luau version 6, Types version 3

-- Time taken: 0.023261 seconds


local longstring1 = "Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts."

local RunService_upvr = game:GetService("RunService")

local any_IsClient_result1_upvr = RunService_upvr:IsClient()

if any_IsClient_result1_upvr then

	any_IsClient_result1_upvr = game:GetService("Players").LocalPlayer

end

local enums_upvr = require(script.Enum).enums

local Janitor_upvr = require(script.Janitor)

local ZoneController = script.ZoneController

local Tracker_upvr = ZoneController.Tracker

local ZoneController_2_upvr = require(ZoneController)

if game:GetService("RunService"):IsClient() then

else

end

local module_6_upvr = {}

module_6_upvr.__index = module_6_upvr

module_6_upvr.enum = enums_upvr

local HttpService_upvr = game:GetService("HttpService")

local Signal_upvr = require(script.Signal)

function module_6_upvr.new(arg1) -- Line 34

	--[[ Upvalues[7]:

		[1]: module_6_upvr (readonly)

		[2]: enums_upvr (readonly)

		[3]: Janitor_upvr (readonly)

		[4]: HttpService_upvr (readonly)

		[5]: ZoneController_2_upvr (readonly)

		[6]: Signal_upvr (readonly)

		[7]: any_IsClient_result1_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local module_2_upvr = {}

	setmetatable(module_2_upvr, module_6_upvr)

	local typeof_result1 = typeof(arg1)

	if typeof_result1 ~= "table" and typeof_result1 ~= "Instance" then

		error("The zone container must be a model, folder, basepart or table!")

	end

	module_2_upvr.accuracy = enums_upvr.Accuracy.High

	module_2_upvr.autoUpdate = true

	module_2_upvr.respectUpdateQueue = true

	local any_new_result1 = Janitor_upvr.new()

	module_2_upvr.janitor = any_new_result1

	module_2_upvr._updateConnections = any_new_result1:add(Janitor_upvr.new(), "destroy")

	module_2_upvr.container = arg1

	module_2_upvr.zoneParts = {}

	module_2_upvr.overlapParams = {}

	module_2_upvr.region = nil

	module_2_upvr.volume = nil

	module_2_upvr.boundMin = nil

	module_2_upvr.boundMax = nil

	module_2_upvr.recommendedMaxParts = nil

	module_2_upvr.zoneId = HttpService_upvr:GenerateGUID()

	module_2_upvr.activeTriggers = {}

	module_2_upvr.occupants = {}

	module_2_upvr.trackingTouchedTriggers = {}

	module_2_upvr.enterDetection = enums_upvr.Detection.Centre

	module_2_upvr.exitDetection = enums_upvr.Detection.Centre

	module_2_upvr._currentEnterDetection = nil

	module_2_upvr._currentExitDetection = nil

	module_2_upvr.totalPartVolume = 0

	module_2_upvr.allZonePartsAreBlocks = true

	module_2_upvr.trackedItems = {}

	module_2_upvr.settingsGroupName = nil

	module_2_upvr.worldModel = workspace

	module_2_upvr.onItemDetails = {}

	module_2_upvr.itemsToUntrack = {}

	ZoneController_2_upvr.updateDetection(module_2_upvr)

	module_2_upvr.updated = any_new_result1:add(Signal_upvr.new(), "destroy")

	local tbl_7 = {"player", "part", "localPlayer", "item"}

	for _, v_upvr in pairs(tbl_7) do

		local var43_upvw = 0

		local var44_upvw = 0

		for _, v_2 in pairs({"entered", "exited"}) do

			local any_add_result1_2 = any_new_result1:add(Signal_upvr.new(true), "destroy")

			local var49_upvr = v_2:sub(1, 1):upper()..v_2:sub(2)

			module_2_upvr[v_upvr..var49_upvr] = any_add_result1_2

			any_add_result1_2.connectionsChanged:Connect(function(arg1_2) -- Line 105

				--[[ Upvalues[7]:

					[1]: v_upvr (readonly)

					[2]: any_IsClient_result1_upvr (copied, readonly)

					[3]: var49_upvr (readonly)

					[4]: var44_upvw (read and write)

					[5]: var43_upvw (read and write)

					[6]: ZoneController_2_upvr (copied, readonly)

					[7]: module_2_upvr (readonly)

				]]

				if v_upvr == "localPlayer" and not any_IsClient_result1_upvr and arg1_2 == 1 then

					error(string.format("Can only connect to 'localPlayer%s' on the client!", var49_upvr))

				end

				var44_upvw = var43_upvw

				var43_upvw += arg1_2

				if var44_upvw == 0 and 0 < var43_upvw then

					ZoneController_2_upvr._registerConnection(module_2_upvr, v_upvr, var49_upvr)

				elseif 0 < var44_upvw and var43_upvw == 0 then

					ZoneController_2_upvr._deregisterConnection(module_2_upvr, v_upvr)

				end

			end)

			local var51

		end

	end

	module_6_upvr.touchedConnectionActions = {}

	for _, v_3 in pairs(tbl_7) do

		local var55_upvr = module_2_upvr[string.format("_%sTouchedZone", v_3)]

		if var55_upvr then

			module_2_upvr.trackingTouchedTriggers[v_3] = {}

			module_6_upvr.touchedConnectionActions[v_3] = function(arg1_3) -- Line 129

				--[[ Upvalues[2]:

					[1]: var55_upvr (readonly)

					[2]: module_2_upvr (readonly)

				]]

				var55_upvr(module_2_upvr, arg1_3)

			end

		end

	end

	module_2_upvr:_update()

	ZoneController_2_upvr._registerZone(module_2_upvr)

	any_new_result1:add(function() -- Line 140

		--[[ Upvalues[2]:

			[1]: ZoneController_2_upvr (copied, readonly)

			[2]: module_2_upvr (readonly)

		]]

		ZoneController_2_upvr._deregisterZone(module_2_upvr)

	end, true)

	return module_2_upvr

end

function module_6_upvr.fromRegion(arg1, arg2) -- Line 147

	--[[ Upvalues[1]:

		[1]: module_6_upvr (readonly)

	]]

	local Model_upvr = Instance.new("Model")

	local function createCube_upvr(arg1_4, arg2_2) -- Line 150, Named "createCube"

		--[[ Upvalues[2]:

			[1]: createCube_upvr (readonly)

			[2]: Model_upvr (readonly)

		]]

		if 2024 < arg2_2.X or 2024 < arg2_2.Y or 2024 < arg2_2.Z then

			local var59 = arg2_2 * 0.25

			local var60 = arg2_2 * 0.5

			createCube_upvr(arg1_4 * CFrame.new(-var59.X, -var59.Y, -var59.Z), var60)

			createCube_upvr(arg1_4 * CFrame.new(-var59.X, -var59.Y, var59.Z), var60)

			createCube_upvr(arg1_4 * CFrame.new(-var59.X, var59.Y, -var59.Z), var60)

			createCube_upvr(arg1_4 * CFrame.new(-var59.X, var59.Y, var59.Z), var60)

			createCube_upvr(arg1_4 * CFrame.new(var59.X, -var59.Y, -var59.Z), var60)

			createCube_upvr(arg1_4 * CFrame.new(var59.X, -var59.Y, var59.Z), var60)

			createCube_upvr(arg1_4 * CFrame.new(var59.X, var59.Y, -var59.Z), var60)

			createCube_upvr(arg1_4 * CFrame.new(var59.X, var59.Y, var59.Z), var60)

		else

			local Part_2 = Instance.new("Part")

			Part_2.CFrame = arg1_4

			Part_2.Size = arg2_2

			Part_2.Anchored = true

			Part_2.Parent = Model_upvr

		end

	end

	createCube_upvr(arg1, arg2)

	local any_new_result1_2 = module_6_upvr.new(Model_upvr)

	any_new_result1_2:relocate()

	return any_new_result1_2

end

function module_6_upvr._calculateRegion(arg1, arg2, arg3) -- Line 179

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local tbl_6 = {

		Min = {};

		Max = {};

	}

	for i_4_upvr, v_4 in pairs(tbl_6) do

		v_4.Values = {}

		function v_4.parseCheck(arg1_5, arg2_3) -- Line 183

			--[[ Upvalues[1]:

				[1]: i_4_upvr (readonly)

			]]

			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

			local var107 = i_4_upvr

			if var107 == "Min" then

				if arg1_5 > arg2_3 then

					var107 = false

				else

					var107 = true

				end

				return var107

			end

			var107 = i_4_upvr

			if var107 == "Max" then

				if arg2_3 > arg1_5 then

				else

				end

				return true

			end

		end

		function v_4.parse(arg1_6, arg2_4) -- Line 190

			for i_5, v_5 in pairs(arg2_4) do

				if arg1_6.parseCheck(v_5, arg1_6.Values[i_5] or v_5) then

					arg1_6.Values[i_5] = v_5

				end

			end

		end

	end

	for _, v_6 in pairs(arg2) do

		local var116 = v_6.Size * 0.5

		for _, v_7 in pairs({v_6.CFrame * CFrame.new(-var116.X, -var116.Y, -var116.Z), v_6.CFrame * CFrame.new(-var116.X, -var116.Y, var116.Z), v_6.CFrame * CFrame.new(-var116.X, var116.Y, -var116.Z), v_6.CFrame * CFrame.new(-var116.X, var116.Y, var116.Z), v_6.CFrame * CFrame.new(var116.X, -var116.Y, -var116.Z), v_6.CFrame * CFrame.new(var116.X, -var116.Y, var116.Z), v_6.CFrame * CFrame.new(var116.X, var116.Y, -var116.Z), v_6.CFrame * CFrame.new(var116.X, var116.Y, var116.Z)}) do

			local any_GetComponents_result1, any_GetComponents_result2, any_GetComponents_result3 = v_7:GetComponents()

			local tbl = {any_GetComponents_result1, any_GetComponents_result2, any_GetComponents_result3}

			tbl_6.Min:parse(tbl)

			tbl_6.Max:parse(tbl)

		end

	end

	local function _(arg1_7) -- Line 222, Named "roundToFour"

		return math.floor((arg1_7 + 2) / 4) * 4

	end

	for i_8, v_8 in pairs(tbl_6) do

		local var131 = 0

		for _, v_9 in pairs(v_8.Values) do

			if i_8 ~= "Min" or not {} then

			end

			if not arg3 then

				if i_8 == "Min" then

					var131 = -2

				else

					var131 = 2

				end

			end

			table.insert({}, math.floor((v_9 + var131 + 2) / 4) * 4)

		end

	end

	-- KONSTANTERROR: Expression was reused, decompilation is incorrect

	local vector3 = Vector3.new(unpack({}))

	-- KONSTANTERROR: Expression was reused, decompilation is incorrect

	local vector3_2 = Vector3.new(unpack({}))

	return Region3.new(vector3, vector3_2), vector3, vector3_2

end

function module_6_upvr._displayBounds(arg1) -- Line 245

	if not arg1.displayBoundParts then

		arg1.displayBoundParts = true

		for i_10, v_10 in pairs({

			BoundMin = arg1.boundMin;

			BoundMax = arg1.boundMax;

		}) do

			local Part = Instance.new("Part")

			Part.Anchored = true

			Part.CanCollide = false

			Part.Transparency = 0.5

			Part.Size = Vector3.new(1, 1, 1)

			Part.Color = Color3.fromRGB(255, 0, 0)

			Part.CFrame = CFrame.new(v_10)

			Part.Name = i_10

			Part.Parent = workspace

			arg1.janitor:add(Part, "Destroy")

		end

	end

end

function module_6_upvr._update(arg1) -- Line 264

	--[[ Upvalues[1]:

		[1]: RunService_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local container_2 = arg1.container

	local tbl_8 = {}

	local var199_upvw = 0

	arg1._updateConnections:clean()

	local typeof_result1_2 = typeof(container_2)

	local tbl_2 = {}

	local var202

	if typeof_result1_2 == "table" then

		var202 = pairs(container_2)

		local pairs_result1_8, pairs_result2, pairs_result3 = pairs(container_2)

		for _, v_11 in pairs_result1_8, pairs_result2, pairs_result3 do

			if v_11:IsA("BasePart") then

				table.insert(tbl_8, v_11)

			end

		end

	elseif typeof_result1_2 == "Instance" then

		pairs_result1_8 = container_2:IsA("BasePart")

		if pairs_result1_8 then

			pairs_result1_8 = table.insert

			pairs_result1_8(tbl_8, container_2)

		else

			pairs_result1_8 = table.insert

			pairs_result1_8(tbl_2, container_2)

			pairs_result1_8 = pairs(container_2:GetDescendants())

			local pairs_result1_18, pairs_result2_8, pairs_result3_15 = pairs(container_2:GetDescendants())

			for _, v_24 in pairs_result1_18, pairs_result2_8, pairs_result3_15 do

				if v_24:IsA("BasePart") then

					table.insert(tbl_8, v_24)

				else

					table.insert(tbl_2, v_24)

				end

			end

		end

	end

	arg1.zoneParts = tbl_8

	pairs_result1_18 = {}

	arg1.overlapParams = pairs_result1_18

	pairs_result1_18 = true

	for _, v_12_upvr in pairs(tbl_8) do

		local _, pcall_result2 = pcall(function() -- Line 298

			--[[ Upvalues[1]:

				[1]: v_12_upvr (readonly)

			]]

			return v_12_upvr.Shape.Name

		end)

		if pcall_result2 ~= "Block" then

			pairs_result1_18 = false

		end

	end

	arg1.allZonePartsAreBlocks = pairs_result1_18

	local OverlapParams_new_result1_2 = OverlapParams.new()

	OverlapParams_new_result1_2.FilterType = Enum.RaycastFilterType.Whitelist

	OverlapParams_new_result1_2.MaxParts = #tbl_8

	OverlapParams_new_result1_2.FilterDescendantsInstances = tbl_8

	arg1.overlapParams.zonePartsWhitelist = OverlapParams_new_result1_2

	local OverlapParams_new_result1 = OverlapParams.new()

	OverlapParams_new_result1.FilterType = Enum.RaycastFilterType.Blacklist

	OverlapParams_new_result1.FilterDescendantsInstances = tbl_8

	arg1.overlapParams.zonePartsIgnorelist = OverlapParams_new_result1

	local function _(arg1_8) -- Line 340, Named "verifyDefaultCollision"

		if arg1_8.CollisionGroupId ~= 0 then

			error(longstring1)

		end

	end

	for _, v_13_upvr in pairs(tbl_8) do

		for _, v_14 in pairs({"Size", "Position"}) do

			arg1._updateConnections:add(v_13_upvr:GetPropertyChangedSignal(v_14):Connect(function() -- Line 318, Named "update"

				--[[ Upvalues[3]:

					[1]: arg1 (readonly)

					[2]: var199_upvw (read and write)

					[3]: RunService_upvr (copied, readonly)

				]]

				if arg1.autoUpdate then

					local os_clock_result1_upvw = os.clock()

					if arg1.respectUpdateQueue then

						var199_upvw += 1

						os_clock_result1_upvw += 0.1

					end

					local var219_upvw

					var219_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 326

						--[[ Upvalues[4]:

							[1]: os_clock_result1_upvw (read and write)

							[2]: var219_upvw (read and write)

							[3]: arg1 (copied, readonly)

							[4]: var199_upvw (copied, read and write)

						]]

						if os_clock_result1_upvw <= os.clock() then

							var219_upvw:Disconnect()

							if arg1.respectUpdateQueue then

								var199_upvw -= 1

							end

							if var199_upvw == 0 and arg1.zoneId then

								arg1:_update()

							end

						end

					end)

				end

			end), "Disconnect")

			local _

		end

		if v_13_upvr.CollisionGroupId ~= 0 then

			error(longstring1)

		end

		arg1._updateConnections:add(v_13_upvr:GetPropertyChangedSignal("CollisionGroupId"):Connect(function() -- Line 350

			--[[ Upvalues[1]:

				[1]: v_13_upvr (readonly)

			]]

			if v_13_upvr.CollisionGroupId ~= 0 then

				error(longstring1)

			end

		end), "Disconnect")

	end

	for _, _ in pairs(tbl_2) do

		for _, v_16 in pairs({"ChildAdded", "ChildRemoved"}) do

			arg1._updateConnections:add(arg1.container[v_16]:Connect(function(arg1_9) -- Line 357

				--[[ Upvalues[3]:

					[1]: arg1 (readonly)

					[2]: var199_upvw (read and write)

					[3]: RunService_upvr (copied, readonly)

				]]

				if arg1_9:IsA("BasePart") and arg1.autoUpdate then

					local os_clock_result1_3_upvw = os.clock()

					if arg1.respectUpdateQueue then

						var199_upvw += 1

						os_clock_result1_3_upvw += 0.1

					end

					local var239_upvw

					var239_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 326

						--[[ Upvalues[4]:

							[1]: os_clock_result1_3_upvw (read and write)

							[2]: var239_upvw (read and write)

							[3]: arg1 (copied, readonly)

							[4]: var199_upvw (copied, read and write)

						]]

						if os_clock_result1_3_upvw <= os.clock() then

							var239_upvw:Disconnect()

							if arg1.respectUpdateQueue then

								var199_upvw -= 1

							end

							if var199_upvw == 0 and arg1.zoneId then

								arg1:_update()

							end

						end

					end)

				end

			end), "Disconnect")

		end

	end

	local any__calculateRegion_result1, any__calculateRegion_result2, any__calculateRegion_result3 = arg1:_calculateRegion(tbl_8)

	local any__calculateRegion_result1_2, _, _ = arg1:_calculateRegion(tbl_8, true)

	arg1.region = any__calculateRegion_result1

	arg1.exactRegion = any__calculateRegion_result1_2

	arg1.boundMin = any__calculateRegion_result2

	arg1.boundMax = any__calculateRegion_result3

	local Size_2 = any__calculateRegion_result1.Size

	arg1.volume = Size_2.X * Size_2.Y * Size_2.Z

	arg1:_updateTouchedConnections()

	arg1.updated:Fire()

end

function module_6_upvr._updateOccupants(arg1, arg2, arg3) -- Line 393

	local var255 = arg1.occupants[arg2]

	if not var255 then

		var255 = {}

		arg1.occupants[arg2] = var255

	end

	local module = {}

	for i_17, v_17 in pairs(var255) do

		local var260 = arg3[i_17]

		if var260 == nil or var260 ~= v_17 then

			var255[i_17] = nil

			if not module.exited then

				module.exited = {}

			end

			table.insert(module.exited, i_17)

		end

	end

	for i_18, _ in pairs(arg3) do

		local var264

		if var255[i_18] == nil then

			local function INLINED() -- Internal function, doesn't exist in bytecode

				var264 = i_18.Character

				return var264

			end

			if not i_18:IsA("Player") or not INLINED() then

				var264 = true

			end

			var255[i_18] = var264

			var264 = module.entered

			if not var264 then

				var264 = {}

				module.entered = var264

			end

			var264 = table.insert

			var264(module.entered, i_18)

		end

	end

	return module

end

function module_6_upvr._formTouchedConnection(arg1, arg2) -- Line 423

	--[[ Upvalues[1]:

		[1]: Janitor_upvr (readonly)

	]]

	local var265 = "_touchedJanitor"..arg2

	if arg1[var265] then

		arg1[var265]:clean()

	else

		arg1[var265] = arg1.janitor:add(Janitor_upvr.new(), "destroy")

	end

	arg1:_updateTouchedConnection(arg2)

end

function module_6_upvr._updateTouchedConnection(arg1, arg2) -- Line 435

	local var270 = arg1["_touchedJanitor"..arg2]

	if not var270 then

	else

		for _, v_25 in pairs(arg1.zoneParts) do

			var270:add(v_25.Touched:Connect(arg1.touchedConnectionActions[arg2], arg1), "Disconnect")

		end

	end

end

function module_6_upvr._updateTouchedConnections(arg1) -- Line 444

	for i_19, _ in pairs(arg1.touchedConnectionActions) do

		local var279 = arg1["_touchedJanitor"..i_19]

		if var279 then

			var279:cleanup()

			arg1:_updateTouchedConnection(i_19)

		end

	end

end

function module_6_upvr._disconnectTouchedConnection(arg1, arg2) -- Line 455

	local var280 = "_touchedJanitor"..arg2

	local var281 = arg1[var280]

	if var281 then

		var281:cleanup()

		arg1[var280] = nil

	end

end

local function _(arg1, arg2) -- Line 464, Named "round"

	return math.round(arg1 * 10 ^ arg2) * 10 ^ (-arg2)

end

local Heartbeat_upvr = RunService_upvr.Heartbeat

function module_6_upvr._partTouchedZone(arg1, arg2) -- Line 467

	--[[ Upvalues[3]:

		[1]: Janitor_upvr (readonly)

		[2]: Heartbeat_upvr (readonly)

		[3]: enums_upvr (readonly)

	]]

	local part_upvr = arg1.trackingTouchedTriggers.part

	if part_upvr[arg2] then

	else

		local any_add_result1_3_upvr = arg1.janitor:add(Janitor_upvr.new(), "destroy")

		part_upvr[arg2] = any_add_result1_3_upvr

		if not ({

			Seat = true;

			VehicleSeat = true;

		})[arg2.ClassName] and ({

			HumanoidRootPart = true;

		})[arg2.Name] then

			arg2.CanTouch = false

		end

		local var287_upvr = math.round(arg2.Size.X * arg2.Size.Y * arg2.Size.Z * 100000) * 0.00001

		arg1.totalPartVolume += var287_upvr

		local const_number_upvw = 0

		local var290_upvw = false

		local Position_upvw = arg2.Position

		local os_clock_result1_2_upvw = os.clock()

		any_add_result1_3_upvr:add(Heartbeat_upvr:Connect(function() -- Line 485

			--[[ Upvalues[8]:

				[1]: const_number_upvw (read and write)

				[2]: enums_upvr (copied, readonly)

				[3]: arg1 (readonly)

				[4]: arg2 (readonly)

				[5]: var290_upvw (read and write)

				[6]: Position_upvw (read and write)

				[7]: os_clock_result1_2_upvw (read and write)

				[8]: any_add_result1_3_upvr (readonly)

			]]

			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)

			local os_clock_result1 = os.clock()

			local var294 = const_number_upvw

			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [44] 35. Error Block 7 start (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [44] 35. Error Block 7 end (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [54] 42. Error Block 8 start (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [54] 42. Error Block 8 end (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [63] 49. Error Block 13 start (CF ANALYSIS FAILED)

			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [63.2]

			if not nil then

				var290_upvw = false

				Position_upvw = arg2.Position

				os_clock_result1_2_upvw = os.clock()

				arg1.partExited:Fire(arg2)

			end

			-- KONSTANTERROR: [63] 49. Error Block 13 end (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [81] 63. Error Block 12 start (CF ANALYSIS FAILED)

			-- KONSTANTERROR: [81] 63. Error Block 12 end (CF ANALYSIS FAILED)

		end), "Disconnect")

		any_add_result1_3_upvr:add(function() -- Line 516

			--[[ Upvalues[4]:

				[1]: part_upvr (readonly)

				[2]: arg2 (readonly)

				[3]: arg1 (readonly)

				[4]: var287_upvr (readonly)

			]]

			part_upvr[arg2] = nil

			arg2.CanTouch = true

			arg1.totalPartVolume = math.round((arg1.totalPartVolume - var287_upvr) * 100000) * 0.00001

		end, true)

	end

end

local tbl_3_upvr = {

	Ball = function(arg1) -- Line 524

		return "GetPartBoundsInRadius", {arg1.Position, arg1.Size.X}

	end;

	Block = function(arg1) -- Line 527

		return "GetPartBoundsInBox", {arg1.CFrame, arg1.Size}

	end;

	Other = function(arg1) -- Line 530

		local module_5 = {}

		module_5[1] = arg1

		return "GetPartsInPart", module_5

	end;

}

function module_6_upvr._getRegionConstructor(arg1, arg2, arg3) -- Line 534

	--[[ Upvalues[1]:

		[1]: tbl_3_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local pcall_result1_2, pcall_result2_2 = pcall(function() -- Line 535

		--[[ Upvalues[1]:

			[1]: arg2 (readonly)

		]]

		return arg2.Shape.Name

	end)

	local var316

	if pcall_result1_2 then

		if arg1.allZonePartsAreBlocks then

			local var317 = tbl_3_upvr[pcall_result2_2]

			if var317 then

				local var317_result1, var317_result2 = var317(arg2)

				var316 = var317_result2

			end

		end

	end

	if not var317_result1 then

		local any_Other_result1, any_Other_result2_2 = tbl_3_upvr.Other(arg2)

		var316 = any_Other_result2_2

	end

	if arg3 then

		table.insert(var316, arg3)

	end

	return any_Other_result1, var316

end

function module_6_upvr.findLocalPlayer(arg1) -- Line 555

	--[[ Upvalues[1]:

		[1]: any_IsClient_result1_upvr (readonly)

	]]

	if not any_IsClient_result1_upvr then

		error("Can only call 'findLocalPlayer' on the client!")

	end

	return arg1:findPlayer(any_IsClient_result1_upvr)

end

function module_6_upvr._find(arg1, arg2, arg3) -- Line 562

	--[[ Upvalues[1]:

		[1]: ZoneController_2_upvr (readonly)

	]]

	ZoneController_2_upvr.updateDetection(arg1)

	for _, v_20 in pairs(ZoneController_2_upvr.getTouchingZones(arg3, false, arg1._currentEnterDetection, ZoneController_2_upvr.trackers[arg2])) do

		if v_20 == arg1 then

			return true

		end

	end

	return false

end

function module_6_upvr.findPlayer(arg1, arg2) -- Line 574

	local var328 = arg2.Character

	if var328 then

		var328 = arg2.Character:FindFirstChildOfClass("Humanoid")

	end

	if not var328 then

		return false

	end

	return arg1:_find("player", arg2.Character)

end

function module_6_upvr.findItem(arg1, arg2) -- Line 583

	return arg1:_find("item", arg2)

end

function module_6_upvr.findPart(arg1, arg2) -- Line 587

	local any__getRegionConstructor_result1_2, any__getRegionConstructor_result2_2 = arg1:_getRegionConstructor(arg2, arg1.overlapParams.zonePartsWhitelist)

	local any_any_result1_2 = arg1.worldModel[any__getRegionConstructor_result1_2](arg1.worldModel, unpack(any__getRegionConstructor_result2_2))

	if 0 < #any_any_result1_2 then

		return true, any_any_result1_2

	end

	return false

end

function module_6_upvr.getCheckerPart(arg1) -- Line 597

	--[[ Upvalues[1]:

		[1]: ZoneController_2_upvr (readonly)

	]]

	local var332

	if not arg1.checkerPart then

		var332 = arg1.janitor:add(Instance.new("Part"), "Destroy")

		local var333 = var332

		var332 = Vector3.new(0.10000, 0.10000, 0.10000)

		var333.Size = var332

		var332 = "ZonePlusCheckerPart"

		var333.Name = var332

		var332 = true

		var333.Anchored = var332

		var332 = 1

		var333.Transparency = var332

		var332 = false

		var333.CanCollide = var332

		arg1.checkerPart = var333

	end

	var332 = arg1.worldModel

	if var332 == workspace then

		var332 = ZoneController_2_upvr.getWorkspaceContainer()

	end

	if var333.Parent ~= var332 then

		var333.Parent = var332

	end

	return var333

end

function module_6_upvr.findPoint(arg1, arg2) -- Line 618

	local var334 = arg2

	if typeof(arg2) == "Vector3" then

		var334 = CFrame.new(arg2)

	end

	local any_getCheckerPart_result1 = arg1:getCheckerPart()

	any_getCheckerPart_result1.CFrame = var334

	local any__getRegionConstructor_result1, any__getRegionConstructor_result2 = arg1:_getRegionConstructor(any_getCheckerPart_result1, arg1.overlapParams.zonePartsWhitelist)

	local any_any_result1 = arg1.worldModel[any__getRegionConstructor_result1](arg1.worldModel, unpack(any__getRegionConstructor_result2))

	if 0 < #any_any_result1 then

		return true, any_any_result1

	end

	return false

end

function module_6_upvr._getAll(arg1, arg2) -- Line 635

	--[[ Upvalues[1]:

		[1]: ZoneController_2_upvr (readonly)

	]]

	ZoneController_2_upvr.updateDetection(arg1)

	local module_4 = {}

	local var345 = ZoneController_2_upvr._getZonesAndItems(arg2, {

		self = true;

	}, arg1.volume, false, arg1._currentEnterDetection)[arg1]

	if var345 then

		for i_21, _ in pairs(var345) do

			table.insert(module_4, i_21)

		end

	end

	return module_4

end

function module_6_upvr.getPlayers(arg1) -- Line 648

	return arg1:_getAll("player")

end

function module_6_upvr.getItems(arg1) -- Line 652

	return arg1:_getAll("item")

end

function module_6_upvr.getParts(arg1) -- Line 656

	local module_3 = {}

	if arg1.activeTriggers.part then

		for i_22, _ in pairs(arg1.trackingTouchedTriggers.part) do

			table.insert(module_3, i_22)

		end

		return module_3

	end

	for _, v_23 in pairs(arg1.worldModel:GetPartBoundsInBox(arg1.region.CFrame, arg1.region.Size, arg1.overlapParams.zonePartsIgnorelist)) do

		if arg1:findPart(v_23) then

			table.insert(module_3, v_23)

		end

	end

	return module_3

end

function module_6_upvr.getRandomPoint(arg1) -- Line 677

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local Size = arg1.exactRegion.Size

	local random_state = Random.new()

	local var367

	repeat

		var367 = arg1.exactRegion.CFrame * CFrame.new(random_state:NextNumber(-Size.X / 2, Size.X / 2), random_state:NextNumber(-Size.Y / 2, Size.Y / 2), random_state:NextNumber(-Size.Z / 2, Size.Z / 2))

		local any_findPoint_result1, any_findPoint_result2 = arg1:findPoint(var367)

		local var370

		if any_findPoint_result1 then

			var370 = true

		end

	until var370

	return var367.Position, any_findPoint_result2

end

function module_6_upvr.setAccuracy(arg1, arg2) -- Line 696

	--[[ Upvalues[1]:

		[1]: enums_upvr (readonly)

	]]

	-- KONSTANTERROR: [0] 1. Error Block 11 start (CF ANALYSIS FAILED)

	local tonumber_result1_2 = tonumber(arg2)

	if not tonumber_result1_2 then

		tonumber_result1_2 = enums_upvr.Accuracy[arg2]

		if not tonumber_result1_2 then

			error(string.format("'%s' is an invalid enumName!", arg2))

			-- KONSTANTWARNING: GOTO [36] #29

		end

	elseif not enums_upvr.Accuracy.getName(tonumber_result1_2) then

		error(string.format("%s is an invalid enumId!", tonumber_result1_2))

	end

	-- KONSTANTERROR: [0] 1. Error Block 11 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [36] 29. Error Block 7 start (CF ANALYSIS FAILED)

	arg1.accuracy = tonumber_result1_2

	-- KONSTANTERROR: [36] 29. Error Block 7 end (CF ANALYSIS FAILED)

end

function module_6_upvr.setDetection(arg1, arg2) -- Line 712

	--[[ Upvalues[1]:

		[1]: enums_upvr (readonly)

	]]

	-- KONSTANTERROR: [0] 1. Error Block 11 start (CF ANALYSIS FAILED)

	local tonumber_result1 = tonumber(arg2)

	if not tonumber_result1 then

		tonumber_result1 = enums_upvr.Detection[arg2]

		if not tonumber_result1 then

			error(string.format("'%s' is an invalid enumName!", arg2))

			-- KONSTANTWARNING: GOTO [36] #29

		end

	elseif not enums_upvr.Detection.getName(tonumber_result1) then

		error(string.format("%s is an invalid enumId!", tonumber_result1))

	end

	-- KONSTANTERROR: [0] 1. Error Block 11 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [36] 29. Error Block 7 start (CF ANALYSIS FAILED)

	arg1.enterDetection = tonumber_result1

	arg1.exitDetection = tonumber_result1

	-- KONSTANTERROR: [36] 29. Error Block 7 end (CF ANALYSIS FAILED)

end

function module_6_upvr.trackItem(arg1, arg2) -- Line 729

	--[[ Upvalues[2]:

		[1]: Janitor_upvr (readonly)

		[2]: Tracker_upvr (readonly)

	]]

	local children = arg2:IsA("BasePart")

	local var374 = false

	if not children then

		local class_Humanoid = arg2:FindFirstChildOfClass("Humanoid")

		if class_Humanoid then

			class_Humanoid = arg2:FindFirstChild("HumanoidRootPart")

		end

		var374 = class_Humanoid

	end

	assert(children or var374, "Only BaseParts or Characters/NPCs can be tracked!")

	if arg1.trackedItems[arg2] then

	else

		if arg1.itemsToUntrack[arg2] then

			arg1.itemsToUntrack[arg2] = nil

		end

		local any_add_result1 = arg1.janitor:add(Janitor_upvr.new(), "destroy")

		local tbl_4 = {

			janitor = any_add_result1;

		}

		tbl_4.item = arg2

		tbl_4.isBasePart = children

		tbl_4.isCharacter = var374

		arg1.trackedItems[arg2] = tbl_4

		any_add_result1:add(arg2.AncestryChanged:Connect(function() -- Line 754

			--[[ Upvalues[2]:

				[1]: arg2 (readonly)

				[2]: arg1 (readonly)

			]]

			if not arg2:IsDescendantOf(game) then

				arg1:untrackItem(arg2)

			end

		end), "Disconnect")

		require(Tracker_upvr).itemAdded:Fire(tbl_4)

	end

end

function module_6_upvr.untrackItem(arg1, arg2) -- Line 764

	--[[ Upvalues[1]:

		[1]: Tracker_upvr (readonly)

	]]

	local var379 = arg1.trackedItems[arg2]

	if var379 then

		var379.janitor:destroy()

	end

	arg1.trackedItems[arg2] = nil

	require(Tracker_upvr).itemRemoved:Fire(var379)

end

function module_6_upvr.bindToGroup(arg1, arg2) -- Line 775

	--[[ Upvalues[1]:

		[1]: ZoneController_2_upvr (readonly)

	]]

	arg1:unbindFromGroup()

	local any_getGroup_result1_2 = ZoneController_2_upvr.getGroup(arg2)

	if not any_getGroup_result1_2 then

		any_getGroup_result1_2 = ZoneController_2_upvr.setGroup(arg2)

	end

	any_getGroup_result1_2._memberZones[arg1.zoneId] = arg1

	arg1.settingsGroupName = arg2

end

function module_6_upvr.unbindFromGroup(arg1) -- Line 782

	--[[ Upvalues[1]:

		[1]: ZoneController_2_upvr (readonly)

	]]

	if arg1.settingsGroupName then

		local any_getGroup_result1 = ZoneController_2_upvr.getGroup(arg1.settingsGroupName)

		if any_getGroup_result1 then

			any_getGroup_result1._memberZones[arg1.zoneId] = nil

		end

		arg1.settingsGroupName = nil

	end

end

local CollectiveWorldModel_upvr = ZoneController.CollectiveWorldModel

function module_6_upvr.relocate(arg1) -- Line 792

	--[[ Upvalues[1]:

		[1]: CollectiveWorldModel_upvr (readonly)

	]]

	if arg1.hasRelocated then

	else

		local any_setupWorldModel_result1 = require(CollectiveWorldModel_upvr).setupWorldModel(arg1)

		arg1.worldModel = any_setupWorldModel_result1

		arg1.hasRelocated = true

		local container = arg1.container

		if typeof(container) == "table" then

			container = Instance.new("Folder")

			for _, v_26 in pairs(arg1.zoneParts) do

				v_26.Parent = container

			end

		end

		arg1.relocationContainer = arg1.janitor:add(container, "Destroy", "RelocationContainer")

		container.Parent = any_setupWorldModel_result1

	end

end

function module_6_upvr._onItemCallback(arg1, arg2, arg3, arg4, arg5) -- Line 813

	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [4] 4. Error Block 2 start (CF ANALYSIS FAILED)

	local tbl_5 = {}

	arg1.onItemDetails[arg4] = tbl_5

	-- KONSTANTERROR: [4] 4. Error Block 2 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [9] 7. Error Block 3 start (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [9] 7. Error Block 3 end (CF ANALYSIS FAILED)

end

function module_6_upvr.onItemEnter(arg1, ...) -- Line 860

	arg1:_onItemCallback("itemEntered", true, ...)

end

function module_6_upvr.onItemExit(arg1, ...) -- Line 864

	arg1:_onItemCallback("itemExited", false, ...)

end

function module_6_upvr.destroy(arg1) -- Line 868

	arg1:unbindFromGroup()

	arg1.janitor:destroy()

end

module_6_upvr.Destroy = module_6_upvr.destroy

return module_6_upvr
