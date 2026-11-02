-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferMachineClient, time of decompilation: Sun May  3 10:12:36 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local XpTransferMachineBillboard = require(ReplicatedStorage.Source.Features.XpTransfer.UI.Components.XpTransferMachineBillboard)
local t1 = {}

t1.__index = t1

local function getRootPart(p1) -- line: 11
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

function t1.new(p2, p3: ((...any) -> ...any)) -- line: 55
	-- upvalues: Players (copy), getRootPart (copy), Vide (copy), t1 (copy), XpTransferMachineBillboard (copy)
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local t2 = {
		billboardDestroy = nil,
		inRange = false,
		blockedUntilExit = false,
		instance = p2,
		root = getRootPart(p2)
	}
	local g19 = nil
	local v18 = nil

	for _, v17 in p2:GetChildren() do
		if v17:IsA("Highlight") then
			v18 = v17
			g19 = true
		end

		if g19 then
			break
		end
	end

	if not g19 then
		v18 = nil
	end

	g19 = false
	t2.highlight = v18
	t2.unlocked = Vide.source(false)

	local v20 = setmetatable(t2, t1)

	if v20.root then
		v20.billboardDestroy = Vide.mount(function() -- line: 68
			-- upvalues: XpTransferMachineBillboard (copy), v20 (copy), p3 (copy)
			return XpTransferMachineBillboard({
				Root = v20.root,
				OnPurchase = p3,
				Unlocked = v20.unlocked
			})
		end, PlayerGui)
	end

	return v20
end
function t1.getPivotPosition(p4) -- line: 80
	if p4.instance:IsA("Model") then
		return p4.instance:GetPivot().Position
	end

	if p4.instance:IsA("BasePart") then
		return p4.instance.Position
	end

	return nil
end
function t1.setUnlocked(p5, b1: boolean) -- line: 91
	p5.unlocked(b1)

	if p5.highlight and p5.highlight.Parent ~= nil then
		p5.highlight.Enabled = not b1
	end
end
function t1.destroy(p6) -- line: 98
	if p6.billboardDestroy then
		p6.billboardDestroy()
		p6.billboardDestroy = nil
	end
end

return t1
