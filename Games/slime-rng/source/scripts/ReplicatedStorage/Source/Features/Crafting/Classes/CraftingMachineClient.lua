-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingMachineClient, time of decompilation: Sun May  3 10:12:25 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local CraftingMachineBillboard = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingMachineBillboard)
local CraftingMachineVisualsClient = require(ReplicatedStorage.Source.Features.Crafting.Classes.CraftingMachineVisualsClient)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {}

t1.__index = t1

local function getRootPart(p1) -- line: 17
	local Root = p1:FindFirstChild("Root")

	if Root and Root:IsA("BasePart") then
		return Root
	end

	if p1:IsA("Model") then
		if p1.PrimaryPart then
			return p1.PrimaryPart
		end

		return p1:FindFirstChildWhichIsA("BasePart", true)
	end

	if p1:IsA("BasePart") then
		return p1
	end

	return nil
end

function t1.new(p2, p3: ((...any) -> ...any), p4: ((...any) -> ...any)) -- line: 64
	-- upvalues: Players (copy), CraftingServiceUtils (copy), getRootPart (copy), Vide (copy), CraftingMachineVisualsClient (copy), t1 (copy), CraftingMachineBillboard (copy)
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local v18 = CraftingServiceUtils.getMachineZoneId(p2)
	local t2 = {
		billboardDestroy = nil,
		inRange = false,
		blockedUntilExit = false,
		instance = p2,
		machineId = if v18 == nil then nil else tostring(v18),
		root = getRootPart(p2)
	}
	local g23 = nil
	local v22 = nil

	for _, v21 in p2:GetChildren() do
		if v21:IsA("Highlight") then
			v22 = v21
			g23 = true
		end

		if g23 then
			break
		end
	end

	if not g23 then
		v22 = nil
	end

	g23 = false
	t2.highlight = v22
	t2.unlocked = Vide.source(false)
	t2.autoCrafting = Vide.source(false)
	t2.visuals = CraftingMachineVisualsClient.new(p2)

	local v24 = setmetatable(t2, t1)

	if v24.root then
		v24.billboardDestroy = Vide.mount(function() -- line: 85
			-- upvalues: CraftingMachineBillboard (copy), v24 (copy), p3 (copy), p4 (copy)
			return CraftingMachineBillboard({
				Root = v24.root,
				OnPurchase = p3,
				OnStopAutoCraft = function() --[[ OnStopAutoCraft ]] -- line: 89
					-- upvalues: v24 (copy), p4 (copy)
					if v24.machineId ~= nil then
						p4(v24.machineId)
					end
				end,
				Unlocked = v24.unlocked,
				IsAutoCrafting = v24.autoCrafting
			})
		end, PlayerGui)
	end

	return v24
end
function t1.getPivotPosition(p5) -- line: 103
	if p5.instance:IsA("Model") then
		return p5.instance:GetPivot().Position
	end

	if p5.instance:IsA("BasePart") then
		return p5.instance.Position
	end

	return nil
end
function t1.setUnlocked(p6, b1: boolean) -- line: 114
	p6.unlocked(b1)

	if p6.highlight and p6.highlight.Parent ~= nil then
		p6.highlight.Enabled = not b1
	end
end
function t1.setAutoCrafting(p7, b2: boolean) -- line: 121
	p7.autoCrafting(b2)
end
function t1.playCraft(p8, t3: {[any]: any}, p9, p10: ((...any) -> ...any)?) -- line: 125
	p8.visuals:enqueueCraft(t3, p9, p10)
end
function t1.destroy(p11) -- line: 134
	if p11.billboardDestroy then
		p11.billboardDestroy()
		p11.billboardDestroy = nil
	end

	p11.visuals:destroy()
end

return t1
