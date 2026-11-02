-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:15:28

-- Luau version 6, Types version 3

-- Time taken: 0.005870 seconds


local Signal = require(script.Parent.Parent.Signal)

local Janitor_upvr = require(script.Parent.Parent.Janitor)

local module_upvr = {}

module_upvr.__index = module_upvr

local tbl_upvr = {}

module_upvr.trackers = tbl_upvr

module_upvr.itemAdded = Signal.new()

module_upvr.itemRemoved = Signal.new()

module_upvr.bodyPartsToIgnore = {

	UpperTorso = true;

	LowerTorso = true;

	Torso = true;

	LeftHand = true;

	RightHand = true;

	LeftFoot = true;

	RightFoot = true;

}

function module_upvr.getCombinedTotalVolumes() -- Line 35

	--[[ Upvalues[1]:

		[1]: tbl_upvr (readonly)

	]]

	local var10 = 0

	for i, _ in pairs(tbl_upvr) do

		var10 += i.totalVolume

	end

	return var10

end

function module_upvr.getCharacterSize(arg1) -- Line 43

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local var14

	if arg1 then

		local Head = arg1:FindFirstChild("Head")

	end

	var14 = arg1

	if var14 then

		var14 = arg1:FindFirstChild("HumanoidRootPart")

	end

	if not var14 or not Head then

		return nil

	end

	if not Head:IsA("BasePart") then

	end

	local Y = var14.Size.Y

	local Size_2 = var14.Size

	return Size_2 * Vector3.new(2, 2, 1) + Vector3.new(0, Y, 0), var14.CFrame * CFrame.new(0, Y / 2 - Size_2.Y / 2, 0)

end

local Players_upvr = game:GetService("Players")

function module_upvr.new(arg1) -- Line 60

	--[[ Upvalues[4]:

		[1]: module_upvr (readonly)

		[2]: Janitor_upvr (readonly)

		[3]: Players_upvr (readonly)

		[4]: tbl_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local module_upvr_2 = {}

	setmetatable(module_upvr_2, module_upvr)

	module_upvr_2.name = arg1

	module_upvr_2.totalVolume = 0

	module_upvr_2.parts = {}

	module_upvr_2.partToItem = {}

	module_upvr_2.items = {}

	module_upvr_2.whitelistParams = nil

	module_upvr_2.characters = {}

	module_upvr_2.baseParts = {}

	module_upvr_2.exitDetections = {}

	module_upvr_2.janitor = Janitor_upvr.new()

	if arg1 == "player" then

		local function updateItem_upvr() -- Line 76, Named "updatePlayerCharacters"

			--[[ Upvalues[2]:

				[1]: Players_upvr (copied, readonly)

				[2]: module_upvr_2 (readonly)

			]]

			for _, v_2 in pairs(Players_upvr:GetPlayers()) do

				local Character = v_2.Character

				if Character then

					({})[Character] = true

				end

			end

			-- KONSTANTERROR: Expression was reused, decompilation is incorrect

			module_upvr_2.characters = {}

		end

		local function playerAdded(arg1_2) -- Line 87

			--[[ Upvalues[2]:

				[1]: updateItem_upvr (readonly)

				[2]: module_upvr_2 (readonly)

			]]

			local function charAdded(arg1_3) -- Line 88

				--[[ Upvalues[2]:

					[1]: updateItem_upvr (copied, readonly)

					[2]: module_upvr_2 (copied, readonly)

				]]

				local Humanoid = arg1_3:WaitForChild("Humanoid", 3)

				if Humanoid then

					updateItem_upvr()

					module_upvr_2:update()

					for _, v_3 in pairs(Humanoid:GetChildren()) do

						if v_3:IsA("NumberValue") then

							v_3.Changed:Connect(function() -- Line 95

								--[[ Upvalues[1]:

									[1]: module_upvr_2 (copied, readonly)

								]]

								module_upvr_2:update()

							end)

						end

					end

				end

			end

			if arg1_2.Character then

				charAdded(arg1_2.Character)

			end

			arg1_2.CharacterAdded:Connect(charAdded)

			arg1_2.CharacterRemoving:Connect(function(arg1_4) -- Line 106

				--[[ Upvalues[1]:

					[1]: module_upvr_2 (copied, readonly)

				]]

				module_upvr_2.exitDetections[arg1_4] = nil

			end)

		end

		Players_upvr.PlayerAdded:Connect(playerAdded)

		for _, v_4 in pairs(Players_upvr:GetPlayers()) do

			playerAdded(v_4)

			local var45

		end

		Players_upvr.PlayerRemoving:Connect(function(arg1_5) -- Line 116

			--[[ Upvalues[2]:

				[1]: updateItem_upvr (readonly)

				[2]: module_upvr_2 (readonly)

			]]

			updateItem_upvr()

			module_upvr_2:update()

		end)

	elseif arg1 == "item" then

		function updateItem_upvr(arg1_6, arg2) -- Line 123, Named "updateItem"

			--[[ Upvalues[1]:

				[1]: module_upvr_2 (readonly)

			]]

			if arg1_6.isCharacter then

				module_upvr_2.characters[arg1_6.item] = arg2

			elseif arg1_6.isBasePart then

				module_upvr_2.baseParts[arg1_6.item] = arg2

			end

			module_upvr_2:update()

		end

		module_upvr.itemAdded:Connect(function(arg1_7) -- Line 131

			--[[ Upvalues[1]:

				[1]: module_upvr_2 (readonly)

			]]

			if arg1_7.isCharacter then

				module_upvr_2.characters[arg1_7.item] = true

			elseif arg1_7.isBasePart then

				module_upvr_2.baseParts[arg1_7.item] = true

			end

			module_upvr_2:update()

		end)

		module_upvr.itemRemoved:Connect(function(arg1_8) -- Line 134

			--[[ Upvalues[1]:

				[1]: module_upvr_2 (readonly)

			]]

			module_upvr_2.exitDetections[arg1_8.item] = nil

			if arg1_8.isCharacter then

				module_upvr_2.characters[arg1_8.item] = nil

			elseif arg1_8.isBasePart then

				module_upvr_2.baseParts[arg1_8.item] = nil

			end

			module_upvr_2:update()

		end)

	end

	updateItem_upvr = tbl_upvr

	updateItem_upvr[module_upvr_2] = true

	updateItem_upvr = task.defer

	updateItem_upvr(module_upvr_2.update, module_upvr_2)

	return module_upvr_2

end

function module_upvr._preventMultiFrameUpdates(arg1, arg2, ...) -- Line 148

	local _preventMultiDetails = arg1._preventMultiDetails

	if not _preventMultiDetails then

		_preventMultiDetails = {}

	end

	arg1._preventMultiDetails = _preventMultiDetails

	_preventMultiDetails = arg1._preventMultiDetails[arg2]

	local var50_upvw = _preventMultiDetails

	if not var50_upvw then

		var50_upvw = {

			calling = false;

			callsThisFrame = 0;

			updatedThisFrame = false;

		}

		arg1._preventMultiDetails[arg2] = var50_upvw

	end

	var50_upvw.callsThisFrame += 1

	if var50_upvw.callsThisFrame == 1 then

		local packed_upvr = table.pack(...)

		task.defer(function() -- Line 165

			--[[ Upvalues[4]:

				[1]: var50_upvw (read and write)

				[2]: arg1 (readonly)

				[3]: arg2 (readonly)

				[4]: packed_upvr (readonly)

			]]

			var50_upvw.callsThisFrame = 0

			if 1 < var50_upvw.callsThisFrame then

				arg1[arg2](arg1, unpack(packed_upvr))

			end

		end)

		return false

	end

	return true

end

function module_upvr.update(arg1) -- Line 177

	--[[ Upvalues[2]:

		[1]: module_upvr (readonly)

		[2]: Janitor_upvr (readonly)

	]]

	if arg1:_preventMultiFrameUpdates("update") then

	else

		arg1.totalVolume = 0

		arg1.parts = {}

		arg1.partToItem = {}

		arg1.items = {}

		for i_5_upvr, _ in pairs(arg1.characters) do

			local any_getCharacterSize_result1 = module_upvr.getCharacterSize(i_5_upvr)

			if any_getCharacterSize_result1 then

				arg1.totalVolume += any_getCharacterSize_result1.X * any_getCharacterSize_result1.Y * any_getCharacterSize_result1.Z

				local any_add_result1_upvw = arg1.janitor:add(Janitor_upvr.new(), "destroy", "trackCharacterParts-"..arg1.name)

				local function _(arg1_9) -- Line 198, Named "updateTrackerOnParentChanged"

					--[[ Upvalues[2]:

						[1]: any_add_result1_upvw (read and write)

						[2]: arg1 (readonly)

					]]

					any_add_result1_upvw:add(arg1_9.AncestryChanged:Connect(function() -- Line 199

						--[[ Upvalues[3]:

							[1]: arg1_9 (readonly)

							[2]: any_add_result1_upvw (copied, read and write)

							[3]: arg1 (copied, readonly)

						]]

						if not arg1_9:IsDescendantOf(game) and arg1_9.Parent == nil and any_add_result1_upvw ~= nil then

							any_add_result1_upvw:destroy()

							any_add_result1_upvw = nil

							arg1:update()

						end

					end), "Disconnect")

				end

				for _, v_6_upvr in pairs(i_5_upvr:GetChildren()) do

					if v_6_upvr:IsA("BasePart") and not module_upvr.bodyPartsToIgnore[v_6_upvr.Name] then

						arg1.partToItem[v_6_upvr] = i_5_upvr

						table.insert(arg1.parts, v_6_upvr)

						any_add_result1_upvw:add(v_6_upvr.AncestryChanged:Connect(function() -- Line 199

							--[[ Upvalues[3]:

								[1]: v_6_upvr (readonly)

								[2]: any_add_result1_upvw (read and write)

								[3]: arg1 (readonly)

							]]

							if not v_6_upvr:IsDescendantOf(game) and v_6_upvr.Parent == nil and any_add_result1_upvw ~= nil then

								any_add_result1_upvw:destroy()

								any_add_result1_upvw = nil

								arg1:update()

							end

						end), "Disconnect")

					end

				end

				any_add_result1_upvw:add(i_5_upvr.AncestryChanged:Connect(function() -- Line 199

					--[[ Upvalues[3]:

						[1]: i_5_upvr (readonly)

						[2]: any_add_result1_upvw (read and write)

						[3]: arg1 (readonly)

					]]

					if not i_5_upvr:IsDescendantOf(game) and i_5_upvr.Parent == nil and any_add_result1_upvw ~= nil then

						any_add_result1_upvw:destroy()

						any_add_result1_upvw = nil

						arg1:update()

					end

				end), "Disconnect")

				table.insert(arg1.items, i_5_upvr)

			end

		end

		for i_7, _ in pairs(arg1.baseParts) do

			local Size = i_7.Size

			arg1.totalVolume += Size.X * Size.Y * Size.Z

			arg1.partToItem[i_7] = i_7

			table.insert(arg1.parts, i_7)

			table.insert(arg1.items, i_7)

		end

		arg1.whitelistParams = OverlapParams.new()

		arg1.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist

		arg1.whitelistParams.MaxParts = #arg1.parts

		arg1.whitelistParams.FilterDescendantsInstances = arg1.parts

	end

end

return module_upvr
