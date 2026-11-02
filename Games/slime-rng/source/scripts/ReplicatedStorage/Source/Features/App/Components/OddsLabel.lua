-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OddsLabel, time of decompilation: Sun May  3 10:11:12 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local OddsGradients = require(ReplicatedStorage.Source.Game.Items.OddsGradients)
local t1 = { "odds" }

return function(p1) -- line: 16
	-- upvalues: RemoveKeys (copy), t1 (copy), Abbreviate (copy), Vide (copy), OddsGradients (copy), TextLabel (copy)
	local v9 = RemoveKeys(p1, t1)

	v9.Stroke = {
		Thickness = 3,
		Color = Color3.fromRGB(43, 43, 43),
		Transparency = v9.TextTransparency
	}

	function v9.Text() -- line: 23
		-- upvalues: Abbreviate (copy), Vide (copy), p1 (copy)
		return `1 / { Abbreviate((math.ceil(1 / Vide.read(p1.odds)))) }`
	end

	v9.DropShadow = {
		Transparency = function() --[[ Transparency ]] -- line: 27
			-- upvalues: Vide (copy), v9 (copy)
			return 0.5 + 0.5 * Vide.read(v9.TextTransparency or 0)
		end,
		Offset = UDim2.fromScale(0, 0.16)
	}
	v9.Gradient = {
		Rotation = 90,
		Color = function() --[[ Color ]] -- line: 34
			-- upvalues: OddsGradients (copy), Vide (copy), p1 (copy)
			return OddsGradients.getGradient(Vide.read(p1.odds))
		end
	}

	return TextLabel(v9)
end
