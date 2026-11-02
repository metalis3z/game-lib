-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferMachineServiceClient, time of decompilation: Sun May  3 10:12:35 2026 ]]
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local client = require(ReplicatedStorage.Packages.DataService).client
local XpTransferServiceClient = require(script.Parent.XpTransferServiceClient)
local XpTransferServiceUtils = require(script.Parent.XpTransferServiceUtils)
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local XpTransferMachineClient = require(ReplicatedStorage.Source.Features.XpTransfer.Classes.XpTransferMachineClient)

return {
	init = function(p1) --[[ init ]] -- line: 26
		-- upvalues: Janitor (copy), CollectionService (copy), RunService (copy)
		p1.janitor = Janitor.new()
		p1.machines = {}
		p1.wasMenuOpen = false
		p1.closingForExit = false

		for _, v14 in CollectionService:GetTagged("XpTransferMachine") do
			p1:addMachine(v14)
		end

		p1.janitor:Add(CollectionService:GetInstanceAddedSignal("XpTransferMachine"):Connect(function(p2) -- line: 36
			-- upvalues: p1 (copy)
			p1:addMachine(p2)
		end))
		p1.janitor:Add(CollectionService:GetInstanceRemovedSignal("XpTransferMachine"):Connect(function(p3) -- line: 39
			-- upvalues: p1 (copy)
			p1:removeMachine(p3)
		end))
		p1.janitor:Add(RunService.Heartbeat:Connect(function() -- line: 42
			-- upvalues: p1 (copy)
			p1:update()
		end))
	end,
	getUnlocks = function(_) --[[ getUnlocks ]] -- line: 47
		-- upvalues: client (copy)
		return client:get("unlocks") or {}
	end,
	isMachineUnlocked = function(p5) --[[ isMachineUnlocked ]] -- line: 51
		-- upvalues: XpTransferServiceUtils (copy)
		return XpTransferServiceUtils.isMachineUnlocked(p5:getUnlocks())
	end,
	addMachine = function(p6, p7) --[[ addMachine ]] -- line: 55
		-- upvalues: XpTransferMachineClient (copy)
		p6:removeMachine(p7)

		local v19 = XpTransferMachineClient.new(p7, function() -- line: 58
			-- upvalues: p6 (copy)
			p6:purchaseMachine()
		end)

		v19:setUnlocked(p6:isMachineUnlocked())
		p6.machines[p7] = v19
	end,
	removeMachine = function(p8, p9) --[[ removeMachine ]] -- line: 65
		local v22 = p8.machines[p9]

		if not v22 then
			return
		end

		v22:destroy()
		p8.machines[p9] = nil
	end,
	purchaseMachine = function(p10) --[[ purchaseMachine ]] -- line: 75
		-- upvalues: XpTransferServiceClient (copy), Players (copy), Menu (copy), XpTransferServiceUtils (copy)
		if not XpTransferServiceClient:unlockMachine() then
			return false
		end

		local Character = Players.LocalPlayer.Character
		local v25 = if Character then Character:GetPivot().Position else nil

		if not v25 or Menu.openedMenu() ~= nil then
			return true
		end

		for _, v27 in p10.machines do
			local v28 = v27:getPivotPosition()

			if v28 and (v28 - v25).Magnitude <= XpTransferServiceUtils.XP_TRANSFER_MACHINE_USE_RADIUS then
				v27.blockedUntilExit = false
				Menu.setOpenedMenu("XpTransfer")

				return true
			end
		end

		return true
	end,
	update = function(p11) --[[ update ]] -- line: 102
		-- upvalues: Players (copy), Menu (copy), XpTransferServiceUtils (copy)
		local v30 = p11:isMachineUnlocked()
		local Character = Players.LocalPlayer.Character
		local v32 = if Character then Character:GetPivot().Position else nil
		local v33 = Menu.openedMenu() == "XpTransfer"
		local v34 = false
		local v35 = false

		if p11.wasMenuOpen and (not v33 and not p11.closingForExit) then
			for _, v37 in p11.machines do
				if v37.inRange then
					v37.blockedUntilExit = true
				end
			end
		end

		for _, v39 in p11.machines do
			v39:setUnlocked(v30)

			local v40 = v39:getPivotPosition()
			local v41 = v30 and (v32 ~= nil and (v40 ~= nil and (v40 - v32).Magnitude <= XpTransferServiceUtils.XP_TRANSFER_MACHINE_USE_RADIUS))

			if v41 then
				v35 = true
			end

			if v41 and not v39.inRange then
				if not v39.blockedUntilExit and Menu.openedMenu() == nil then
					v34 = true
				end
			elseif not v41 and v39.inRange then
				v39.blockedUntilExit = false
			end

			v39.inRange = v41
		end

		if v33 and not v35 then
			p11.closingForExit = true
			Menu.closeCurrentMenu()
			p11.closingForExit = false
		end

		if v34 and Menu.openedMenu() == nil then
			Menu.setOpenedMenu("XpTransfer")
		end

		p11.wasMenuOpen = Menu.openedMenu() == "XpTransfer"
	end
}
