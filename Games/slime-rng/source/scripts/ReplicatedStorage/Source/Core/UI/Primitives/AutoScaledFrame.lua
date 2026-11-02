-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AutoScaledFrame, time of decompilation: Sun May  3 10:11:00 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Frame = require(script.Parent.Frame)
local Vide = require(ReplicatedStorage.Packages.Vide)
local viewportSizeSource = require(ReplicatedStorage.Source.Core.UI.Sources.viewportSizeSource)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local vector2 = Vector2.new(1500, 803)
local t1 = { "MinSize" }

return function(p1) -- line: 16
	-- upvalues: RemoveKeys (copy), t1 (copy), Vide (copy), viewportSizeSource (copy), vector2 (copy), Frame (copy)
	local v9 = RemoveKeys(p1, t1)
	local v10 = p1.MinSize or Vector2.zero

	table.insert(v9, (Vide.create("UIScale")({
		Scale = Vide.derive(function() -- line: 21
			-- upvalues: viewportSizeSource (copy), v10 (copy), vector2 (copy)
			local v11 = viewportSizeSource()

			return (math.min(math.max(v10.X, v11.X) / vector2.X, math.max(v10.Y, v11.Y) / vector2.Y))
		end)
	})))

	return Frame(v9)
end
