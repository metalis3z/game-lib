-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Spr = require(ReplicatedStorage.Library.Modules.Spr)
local v1 = Players.LocalPlayer.PlayerGui:WaitForChild("Click Effect")
local Tile = v1:WaitForChild("Tile")

Tile.Parent = nil

local t = {}

t.__index = t
function t.new() --[[ new | Line: 13 | Upvalues: t (copy) ]]
	return setmetatable({
		Tiles = {}
	}, t)
end
function t.Destroy(p1) --[[ Destroy | Line: 17 | Upvalues: Spr (copy) ]]
	for i, v in ipairs(p1.Tiles) do
		local v1 = v:FindFirstChildWhichIsA("UIScale")

		if v1 then
			Spr.stop(v1)
		end

		Spr.stop(v)
		v:Destroy()
	end

	table.clear(p1.Tiles)
end
function t.Activate(p1, p2) --[[ Activate | Line: 29 | Upvalues: Tile (copy), v1 (copy), Spr (copy) ]]
	local v12 = Tile:Clone()

	v12.BackgroundTransparency = 0
	v12.UIScale.Scale = 0
	v12.Position = UDim2.fromOffset(p2.X, p2.Y)
	v12.Visible = true
	v12.Parent = v1
	Spr.target(v12.UIScale, 100, 600, {
		Scale = 0.75 + math.random() * 0.5
	})
	Spr.target(v12, 100, 600, {
		BackgroundTransparency = 1
	})

	local v2 = v12

	table.insert(p1.Tiles, v2)
	task.delay(2, function() --[[ Line: 43 | Upvalues: p1 (copy), v12 (ref), Spr (ref) ]]
		local v1 = table.find(p1.Tiles, v12)

		if v1 then
			table.remove(p1.Tiles, v1)
		end

		Spr.stop(v12.UIScale)
		Spr.stop(v12)
		v12:Destroy()
		v12 = nil
	end)
end

return t