-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingMachineServiceClient, time of decompilation: Sun May  3 10:12:22 2026 ]]
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local client = require(ReplicatedStorage.Packages.DataService).client
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local CraftingMachineClient = require(ReplicatedStorage.Source.Features.Crafting.Classes.CraftingMachineClient)
local CraftingServiceClient = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceClient)
local CraftingSlice = require(ReplicatedStorage.Source.Features.Crafting.CraftingSlice)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return {
	init = function(p1) --[[ init ]] -- line: 37
		-- upvalues: Janitor (copy), CollectionService (copy), RunService (copy), CraftingServiceClient (copy)
		p1.janitor = Janitor.new()
		p1.machines = {}
		p1.wasCraftingMenuOpen = false
		p1.closingForExit = false
		p1.hidingForCraftAnimation = false
		p1.craftAnimationInProgress = false

		for _, v16 in CollectionService:GetTagged("CraftingMachine") do
			p1:addMachine(v16)
		end

		p1.janitor:Add(CollectionService:GetInstanceAddedSignal("CraftingMachine"):Connect(function(p2) -- line: 49
			-- upvalues: p1 (copy)
			p1:addMachine(p2)
		end))
		p1.janitor:Add(CollectionService:GetInstanceRemovedSignal("CraftingMachine"):Connect(function(p3) -- line: 52
			-- upvalues: p1 (copy)
			p1:removeMachine(p3)
		end))
		p1.janitor:Add(RunService.Heartbeat:Connect(function() -- line: 55
			-- upvalues: p1 (copy)
			p1:update()
		end))
		p1.janitor:Add(CraftingServiceClient.crafted:Connect(function(_, p5, p6, p7, p8) -- line: 58
			-- upvalues: p1 (copy)
			p1:onCrafted(p5, p6, p7, p8)
		end))
	end,
	getUnlocks = function(_) --[[ getUnlocks ]] -- line: 69
		-- upvalues: client (copy)
		return client:get("unlocks") or {}
	end,
	isMachineUnlocked = function(p10) --[[ isMachineUnlocked ]] -- line: 73
		-- upvalues: CraftingServiceUtils (copy)
		return CraftingServiceUtils.isMachineUnlocked(p10:getUnlocks())
	end,
	addMachine = function(p11, p12) --[[ addMachine ]] -- line: 77
		-- upvalues: CraftingMachineClient (copy), CraftingServiceClient (copy)
		p11:removeMachine(p12)

		local v21 = CraftingMachineClient.new(p12, function() -- line: 80
			-- upvalues: p11 (copy)
			p11:purchaseMachine()
		end, function(s1: string) -- line: 82
			-- upvalues: CraftingServiceClient (copy)
			CraftingServiceClient:stopAutoCraft(s1)
		end)

		v21:setUnlocked(p11:isMachineUnlocked())
		p11.machines[p12] = v21
	end,
	removeMachine = function(p13, p14) --[[ removeMachine ]] -- line: 89
		local v24 = p13.machines[p14]

		if not v24 then
			return
		end

		v24:destroy()
		p13.machines[p14] = nil
	end,
	purchaseMachine = function(p15) --[[ purchaseMachine ]] -- line: 99
		-- upvalues: CraftingServiceClient (copy), Players (copy), Menu (copy), CraftingServiceUtils (copy), CraftingSlice (copy)
		if not CraftingServiceClient:unlockMachine() then
			return false
		end

		local Character = Players.LocalPlayer.Character
		local v27 = if Character then Character:GetPivot().Position else nil

		if not v27 or Menu.openedMenu() ~= nil then
			return true
		end

		for _, v29 in p15.machines do
			local v30 = v29:getPivotPosition()

			if v30 and (v30 - v27).Magnitude <= CraftingServiceUtils.CRAFTING_MACHINE_USE_RADIUS then
				v29.blockedUntilExit = false
				CraftingSlice.activeMachineId(v29.machineId)
				Menu.setOpenedMenu("Crafting")

				return true
			end
		end

		return true
	end,
	getMachineById = function(p16, s2: string?) --[[ getMachineById ]] -- line: 124
		if s2 == nil then
			return nil
		end

		for _, v34 in p16.machines do
			if s2 == v34.machineId then
				return v34
			end
		end

		return nil
	end,
	getNearestInRangeMachine = function(p17) --[[ getNearestInRangeMachine ]] -- line: 141
		-- upvalues: Players (copy)
		local Character = Players.LocalPlayer.Character
		local v37 = if Character then Character:GetPivot().Position else nil

		if v37 == nil then
			return nil
		end

		local v38 = nil
		local n1 = 1e999

		for _, v41 in p17.machines do
			if v41.inRange then
				local v42 = v41:getPivotPosition()

				if v42 ~= nil then
					local Magnitude = (v42 - v37).Magnitude

					if Magnitude < n1 then
						n1 = Magnitude
						v38 = v41
					end
				end
			end
		end

		return v38
	end,
	onCrafted = function(p18, t1: {[any]: any}, p19, s3: string?, b1: boolean?) --[[ onCrafted ]] -- line: 169
		-- upvalues: Menu (copy), CraftingSlice (copy)
		local v49 = if s3 == nil then p18:getNearestInRangeMachine() else p18:getMachineById(s3)

		if v49 == nil then
			return
		end

		local t2 = {}

		for _, v52 in t1 do
			table.insert(t2, {
				id = v52.id,
				mutations = v52.mutations
			})
		end

		if not b1 then
			p18.craftAnimationInProgress = true
		end

		if not b1 and Menu.openedMenu() == "Crafting" then
			p18.hidingForCraftAnimation = true
			Menu.closeCurrentMenu()
			p18.hidingForCraftAnimation = false
		end

		v49:playCraft(t2, p19, function(b2: boolean) -- line: 195
			-- upvalues: b1 (copy), p18 (copy), Menu (copy), CraftingSlice (copy), v49 (copy)
			if not b1 then
				p18.craftAnimationInProgress = false
			end

			if not b2 then
				return
			end

			if Menu.openedMenu() ~= nil then
				return
			end

			if b1 then
				return
			end

			if p18:getNearestInRangeMachine() == nil then
				return
			end

			CraftingSlice.activeMachineId(v49.machineId)
			Menu.setOpenedMenu("Crafting")
		end)
	end,
	syncAutoCraftingMachines = function(p20) --[[ syncAutoCraftingMachines ]] -- line: 217
		-- upvalues: client (copy)
		local v54 = client:get("activeAutoCrafts") or {}

		for _, v56 in p20.machines do
			v56:setAutoCrafting(v56.machineId ~= nil and v54[v56.machineId] ~= nil)
		end
	end,
	update = function(p21) --[[ update ]] -- line: 225
		-- upvalues: Players (copy), Menu (copy), client (copy), CraftingServiceUtils (copy), CraftingSlice (copy)
		local v58 = p21:isMachineUnlocked()
		local Character = Players.LocalPlayer.Character
		local v60 = if Character then Character:GetPivot().Position else nil
		local v61 = Menu.openedMenu() == "Crafting"
		local v62 = nil
		local v63 = false
		local v64 = client:get("activeAutoCrafts") or {}

		p21:syncAutoCraftingMachines()

		if p21.wasCraftingMenuOpen and (not v61 and not p21.closingForExit and not p21.hidingForCraftAnimation) then
			for _, v66 in p21.machines do
				if v66.inRange then
					v66.blockedUntilExit = true
				end
			end
		end

		for _, v68 in p21.machines do
			v68:setUnlocked(v58)

			local v69 = v68.machineId ~= nil and v64[v68.machineId] ~= nil
			local v70 = v68:getPivotPosition()
			local v71 = v58 and (v60 ~= nil and (v70 ~= nil and (v70 - v60).Magnitude <= CraftingServiceUtils.CRAFTING_MACHINE_USE_RADIUS))

			if v71 then
				v63 = true
			end

			if v71 and not v68.inRange then
				if not v69 and not v68.blockedUntilExit and not p21.craftAnimationInProgress and Menu.openedMenu() == nil then
					v62 = v68
				end
			elseif not v71 and v68.inRange then
				v68.blockedUntilExit = false
			end

			v68.inRange = v71
		end

		if v61 and not v63 then
			p21.closingForExit = true
			Menu.closeCurrentMenu()
			p21.closingForExit = false
		end

		if v62 ~= nil and Menu.openedMenu() == nil then
			CraftingSlice.activeMachineId(v62.machineId)
			Menu.setOpenedMenu("Crafting")
		end

		p21.wasCraftingMenuOpen = Menu.openedMenu() == "Crafting"
	end
}
