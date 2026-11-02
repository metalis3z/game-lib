-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:54
-- Luau version 6, Types version 3
-- Time taken: 0.012966 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "PetController";
	_exist = {};
	_debounce = {};
	_playerPets = {};
	_petPositions = {};
})
local var4_upvw
local var5_upvw
local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.setPetColor(arg1, arg2, arg3) -- Line 50
	--[[ Upvalues[2]:
		[1]: var9_upvw (read and write)
		[2]: var8_upvw (read and write)
	]]
	if arg3 == 1 then
	else
		local any_getTierData_result1 = var9_upvw.petUtils.getTierData(arg3)
		local any_evalColorSequence_result1 = var8_upvw.evalColorSequence(any_getTierData_result1.gradient, 0.4)
		local any_ToHSV_result1, any_ToHSV_result2, _ = any_evalColorSequence_result1:ToHSV()
		for _, v_8 in pairs(arg2:GetDescendants()) do
			if v_8:IsA("BasePart") then
				if v_8:GetAttribute(any_getTierData_result1.attributeName) then
					v_8.Color = v_8:GetAttribute(any_getTierData_result1.attributeName)
					if v_8:GetAttribute("neon") then
						v_8.Material = Enum.Material.Neon
						-- KONSTANTWARNING: GOTO [80] #56
					end
				else
					print("[GOLDEN/TOXIC COLOR CHECK] "..v_8.Name.." -> NO COLOR ATTRIBUTE! (use auto-color)")
					local _, _, any_ToHSV_result3 = v_8.Color:ToHSV()
					v_8.Color = Color3.fromHSV(any_ToHSV_result1, any_ToHSV_result2, any_ToHSV_result3)
					v_8.Material = Enum.Material.Neon
				end
			end
			if v_8:IsA("Decal") then
				v_8.Color3 = any_evalColorSequence_result1
			end
			if v_8:IsA("MeshPart") then
				if v_8.TextureID ~= "" then
					v_8.TextureID = ""
				end
				if v_8:GetAttribute(any_getTierData_result1.attributeName) then
					v_8.Color = v_8:GetAttribute(any_getTierData_result1.attributeName)
					if v_8:GetAttribute(any_getTierData_result1.attributeName.."Neon") then
						v_8.Material = Enum.Material.Neon
					else
						v_8.Material = Enum.Material.SmoothPlastic
					end
				else
					print("[GOLDEN/TOXIC COLOR CHECK] "..v_8.Name.." -> NO COLOR ATTRIBUTE! (use auto-color)")
					local _, _, any_ToHSV_result3_2 = v_8.Color:ToHSV()
					v_8.Color = Color3.fromHSV(any_ToHSV_result1, any_ToHSV_result2, any_ToHSV_result3_2)
					v_8.Material = Enum.Material.Neon
				end
			end
			if v_8:IsA("ParticleEmitter") then
				if v_8:GetAttribute(any_getTierData_result1.attributeName) then
					v_8.Color = v_8:GetAttribute(any_getTierData_result1.attributeName)
				else
					print("[GOLDEN/TOXIC COLOR CHECK] "..v_8.Name.." -> NO COLOR ATTRIBUTE! (use auto-color)")
					v_8.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, any_evalColorSequence_result1), ColorSequenceKeypoint.new(1, any_evalColorSequence_result1)})
				end
			end
		end
	end
end
function any_CreateController_result1.getExist(arg1, arg2, arg3) -- Line 102
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var5_upvw (read and write)
	]]
	local var32
	if not var32 then
		var32 = var9_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2)
	end
	local any_getPetDescriptor_result1 = var9_upvw.petUtils.getPetDescriptor(var32)
	if not arg1._exist[any_getPetDescriptor_result1] then
		if not arg1._debounce[arg2] then
			arg1._debounce[arg2] = true
			task.delay(1, function()
				arg1._debounce[arg2] = nil
			end)
			var5_upvw.getExist:Fire(var32)
		end
		return nil
	end
	if 25 < os.time() - arg1._exist[any_getPetDescriptor_result1].updated then
		var5_upvw.getExist:Fire(var32)
	end
	return arg1._exist[any_getPetDescriptor_result1].exist
end
function any_CreateController_result1.existUpdated(arg1, arg2, arg3) -- Line 129
	arg1._exist[arg2] = arg3
end
function any_CreateController_result1.setupPet(arg1, arg2) -- Line 133
	for _, v in arg2:GetDescendants() do
		if v:IsA("BasePart") then
			local WeldConstraint = Instance.new("WeldConstraint", arg2)
			WeldConstraint.Part0 = arg2.PrimaryPart
			WeldConstraint.Part1 = v
			local var43 = false
			v.CanCollide = var43
			if arg2.PrimaryPart == v then
				var43 = true
			else
				var43 = false
			end
			v.Anchored = var43
		end
	end
end
local Billboards_upvr = Assets_upvr.Billboards
function any_CreateController_result1.addPetInfo(arg1, arg2, arg3) -- Line 146
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Billboards_upvr (readonly)
	]]
	local clone_2 = Billboards_upvr.PetInfo:Clone()
	clone_2.Pet.Text = arg3:getName()
	clone_2.Enabled = not var4_upvw:getData().settings.hidePetsInfo
	clone_2.Parent = arg2.PrimaryPart
end
function any_CreateController_result1.spawnPet(arg1, arg2, arg3, arg4) -- Line 155
	if arg1._playerPets[arg3] then
		return
	end
	local any_getData_result1 = var4_upvw:getData()
	local any_createItemFromData_result1 = var9_upvw.itemUtils.createItemFromData(arg4)
	local petName = any_createItemFromData_result1:getName()
	local petConfig = var10_upvw[petName]
	if not petConfig then
		warn("[PetController] No config for pet:", petName)
		return
	end
	local placement = nil
	if petConfig.size == "big" then
		placement = "middle"
	elseif petConfig.size == "huge" then
		placement = "back"
	end
	local petModel = Assets_upvr.Pets:FindFirstChild(petName)
	if not petModel then
		warn("[PetController] No model for pet:", petName)
		return
	end
	local clone = petModel:Clone()
	local any_new_result1 = var11_upvw.new(arg3)
	any_new_result1:setOwner(arg2)
	any_new_result1:setInstance(clone)
	any_new_result1:setFlying(petConfig.fly)
	if placement then
		any_new_result1:setPlacement(placement)
	end
	local hideOwn = false
	if arg2 == LocalPlayer_upvr then
		hideOwn = any_getData_result1.settings.hideYourPets
	end
	local hideOther = false
	if arg2 ~= LocalPlayer_upvr then
		hideOther = any_getData_result1.settings.hideOtherPets
	end
	if hideOwn or hideOther then
		any_new_result1:setHidden(true)
		any_new_result1:unloadInstance()
	end
	arg1._playerPets[arg3] = any_new_result1
	arg1:setPetColor(clone, any_createItemFromData_result1:getTier())
	arg1:setupPet(clone)
	arg1:addPetInfo(clone, any_createItemFromData_result1)
	if LocalPlayer_upvr.Character and LocalPlayer_upvr.Character:FindFirstChild("HumanoidRootPart") then
		clone:PivotTo(LocalPlayer_upvr.Character.HumanoidRootPart.CFrame)
	end
	clone.Parent = workspace.Game.Pets
	clone.Name = arg3
end
function any_CreateController_result1.despawnPet(arg1, arg2) -- Line 201
	local var56 = arg1._playerPets[arg2]
	if var56 then
		local any_getInstance_result1_2 = var56:getInstance()
		if any_getInstance_result1_2 then
			any_getInstance_result1_2:Destroy()
		end
		arg1._playerPets[arg2]:remove()
		arg1._playerPets[arg2] = nil
	end
	if arg1._petPositions[arg2] then
		arg1._petPositions[arg2] = nil
	end
end
function any_CreateController_result1.getPlayersToUpdate(arg1) -- Line 220
	--[[ Upvalues[3]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var8_upvw (read and write)
		[3]: Players_upvr (readonly)
	]]
	debug.profilebegin("petMovement/getPlayersToUpdate")
	local module_2 = {LocalPlayer_upvr}
	local any_getHRP_result1_4 = var8_upvw.getHRP(LocalPlayer_upvr)
	if not any_getHRP_result1_4 then
		return {}
	end
	for _, v_2 in Players_upvr:GetPlayers() do
		if LocalPlayer_upvr ~= v_2 then
			local any_getHRP_result1_2 = var8_upvw.getHRP(v_2)
			if any_getHRP_result1_2 and 250 >= (any_getHRP_result1_4.Position - any_getHRP_result1_2.Position).Magnitude then
				module_2[#module_2 + 1] = v_2
			end
		end
	end
	debug.profileend("petMovement/getPlayersToUpdate")
	return module_2
end
function any_CreateController_result1.getPetPositions(arg1, arg2) -- Line 249
	--[[ Upvalues[1]:
		[1]: var12_upvw (read and write)
	]]
	local module_3 = {}
	for i_3, v_3 in arg2 do
		local tbl_3 = {}
		local any_getPlacement_result1 = v_3:getPlacement()
		tbl_3.placement = any_getPlacement_result1
		if v_3:getFlying() then
			any_getPlacement_result1 = math.huge
		else
			any_getPlacement_result1 = 1
		end
		tbl_3.priority = any_getPlacement_result1
		module_3[i_3] = tbl_3
	end
	return var12_upvw(module_3)
end
local RunService_upvr = game:GetService("RunService")
function any_CreateController_result1.petMovement(arg1) -- Line 262
	task.spawn(function()
		RunService_upvr.PreSimulation:Connect(function(dt)
			debug.profilebegin("petMovement/playerPetsOwnerCalculation")
			local ownerGroups = {}
			for _, pet in arg1._playerPets do
				local owner = pet:getOwner()
				if owner:IsDescendantOf(Players_upvr) and not pet:getHidden() then
					if not table.find(arg1:getPlayersToUpdate(), owner) then
						pet:unloadInstance()
						pet:setState(false)
					else
						pet:loadInstance()
						if not ownerGroups[owner] then
							ownerGroups[owner] = {}
						end
						ownerGroups[owner][#ownerGroups[owner] + 1] = pet
					end
				end
			end
			debug.profileend()
			if var8_upvw.getAmountInTable(ownerGroups) == 0 then return end

			local ownerCache = {}
			debug.profilebegin("petMovement/setPositions")
			for _, pets in ownerGroups do
				local parts = {}
				local cframes = {}
				for idx, pet in pairs(pets) do
					local itemId = pet:getItemId()
					local instance = pet:getInstance()
					if not instance or not instance.PrimaryPart then continue end
					local owner = pet:getOwner()
					local isFlying = pet:getFlying()
					local rotation = isFlying and 0 or pet:getRotation()

					if not ownerCache[owner] then
						ownerCache[owner] = {
							humanoidRootPart = var8_upvw.getHRP(owner),
							humanoid = var8_upvw.getHumanoid(owner),
						}
					end
					local cache = ownerCache[owner]
					if not cache.humanoid or not cache.humanoidRootPart then continue end

					local isMoving = cache.humanoid.MoveDirection.Magnitude > 0
					if isMoving then
						pet:setState(true)
						pet:setHasSetFirstCFrame(true)
					end

					local petPositions = arg1:getPetPositions(pets)
					if not petPositions[idx] then continue end
					local targetPos = cache.humanoidRootPart.CFrame * petPositions[idx].position
					local rayResult = pet:raycast(targetPos.Position)

					local groundY = nil
					if isFlying and rayResult then
						groundY = rayResult.Position.Y + math.sin(4 * time() + 1.6) / 8 + 2.5
					elseif rayResult then
						groundY = rayResult.Position.Y
					end

					local halfHeight = instance.PrimaryPart.Size.Y / 2
					local finalY = (groundY or targetPos.Y) + halfHeight
					local position = Vector3.new(targetPos.X, finalY, targetPos.Z)

					if not arg1._petPositions[itemId] then
						arg1._petPositions[itemId] = CFrame.new(position)
					end

					local lookDir = arg1._petPositions[itemId].LookVector
					if not isMoving then
						lookDir = -cache.humanoidRootPart.CFrame.LookVector * 10
					end

					local targetCFrame = CFrame.lookAt(position, arg1._petPositions[itemId].Position + lookDir)
					arg1._petPositions[itemId] = arg1._petPositions[itemId]:Lerp(targetCFrame, dt * 7)

					local finalCFrame = arg1._petPositions[itemId] * CFrame.Angles(math.rad(rotation), 0, 0) * CFrame.Angles(0, math.pi, 0) + Vector3.new(0, pet:getHeight(), 0)
					local dist = (targetCFrame.Position - finalCFrame.Position).Magnitude

					if not pet:getHasSetFirstCFrame() then
						parts[#parts + 1] = instance.PrimaryPart
						cframes[#cframes + 1] = targetCFrame * CFrame.Angles(0, math.pi, 0)
					elseif dist > 0.01 then
						parts[#parts + 1] = instance.PrimaryPart
						cframes[#cframes + 1] = finalCFrame
					end

					if dist < 0.5 then
						pet:setState(false)
					end
				end
				-- BulkMoveTo outside pet loop, per owner group
				if #parts > 0 then
					debug.profilebegin("petMovement/bulkMoveTo")
					workspace:BulkMoveTo(parts, cframes)
					debug.profileend()
				end
			end
			debug.profileend()
		end)
	end)
end
function any_CreateController_result1.requestPets(arg1) -- Line 393
	--[[ Upvalues[2]:
		[1]: Knit_upvr (readonly)
		[2]: var5_upvw (read and write)
	]]
	task.spawn(function() -- Line 394
		--[[ Upvalues[2]:
			[1]: Knit_upvr (copied, readonly)
			[2]: var5_upvw (copied, read and write)
		]]
		repeat
			Knit_upvr.listenToUpdate:Wait()
		until _G.introFinished
		var5_upvw.requestPets:Fire()
	end)
end
function any_CreateController_result1.togglePets(arg1, arg2, arg3) -- Line 403
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	for _, v_5 in arg1._playerPets do
		local isLocalPlayer = v_5:getOwner() == LocalPlayer_upvr
		local shouldToggle
		if arg2 then
			shouldToggle = isLocalPlayer
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			shouldToggle = not isLocalPlayer
		end
		if shouldToggle then
			v_5:setHidden(not arg3)
			v_5:setState(not arg3)
			if arg3 then
				v_5:loadInstance()
			else
				v_5:unloadInstance()
			end
		end
	end
end
function any_CreateController_result1.togglePetInfos(arg1, arg2) -- Line 428
	for _, v_6 in arg1._playerPets do
		local class_BillboardGui = v_6:getInstance().PrimaryPart:FindFirstChildWhichIsA("BillboardGui")
		if class_BillboardGui then
			class_BillboardGui.Enabled = arg2
		end
	end
end
function any_CreateController_result1.warnDevsIncorrectRarity(arg1) -- Line 441
	--[[ Upvalues[2]:
		[1]: var10_upvw (read and write)
		[2]: var8_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	for _, v_7 in {"Dog", "Cat", "Bunny"} do
		if not table.find({"Common", "Uncommon", "Rare"}, var10_upvw[v_7].rarity) then
			local var152 = '!'
			for _ = 1, 5 do
				var8_upvw.print(`⚠️ {v_7:upper()} IS CURRENTLY NOT CORRECT RARITY, REMEMBER TO CHANGE BACK{var152} ⚠️`, warn)
				var152 = var152..'!'
				local var153
			end
		end
	end
end
function any_CreateController_result1.KnitStart(arg1) -- Line 455
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	task.spawn(function() -- Line 456
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		var5_upvw.spawnPet:Connect(function(...) -- Line 459
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:spawnPet(...)
		end)
		var5_upvw.despawnPet:Connect(function(...) -- Line 462
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:despawnPet(...)
		end)
		arg1:requestPets()
		arg1:petMovement()
		arg1:warnDevsIncorrectRarity()
	end)
	var5_upvw.existUpdated:Connect(function(...) -- Line 471
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:existUpdated(...)
	end)
end
local var158_upvw
local var159_upvw
local var160_upvw
local var161_upvw
local var162_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 476
	--[[ Upvalues[14]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var158_upvw (read and write)
		[5]: var8_upvw (read and write)
		[6]: ReplicatedStorage_upvr (readonly)
		[7]: var9_upvw (read and write)
		[8]: var159_upvw (read and write)
		[9]: var160_upvw (read and write)
		[10]: var10_upvw (read and write)
		[11]: var161_upvw (read and write)
		[12]: var162_upvw (read and write)
		[13]: var11_upvw (read and write)
		[14]: var12_upvw (read and write)
	]]
	var5_upvw = Knit_upvr.GetService("PetService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var158_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var159_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var160_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Eggs)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Pets)
	var161_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var162_upvw = require(Knit_upvr.Modules.Button)
	var11_upvw = require(script.PlayerPet)
	var12_upvw = require(script.PetPosition)
end
return any_CreateController_result1