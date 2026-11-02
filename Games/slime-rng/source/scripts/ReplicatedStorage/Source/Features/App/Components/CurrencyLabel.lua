-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CurrencyLabel, time of decompilation: Sun May  3 10:11:12 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local t1 = {
	"Currency",
	"Amount",
	"RedIfInsufficient"
}
local t2 = {
	coins = ImageIds.coin,
	goop = ImageIds.goop,
	rollCurrency = ImageIds.dice
}

return function(t3: {[any]: any}) -- line: 26
	-- upvalues: RemoveKeys (copy), t1 (copy), Vide (copy), getDataSource (copy), Abbreviate (copy), t2 (copy), TextLabel (copy)
	local v11 = RemoveKeys(t3, t1)
	local t4 = {}

	function v11.Text() -- line: 41
		-- upvalues: Abbreviate (copy), Vide (copy), t3 (copy)
		return Abbreviate(Vide.read(t3.Amount))
	end

	v11.Stroke = {}
	v11.Prefix = {
		Image = function() --[[ Image ]] -- line: 46
			-- upvalues: t2 (copy), Vide (copy), t3 (copy)
			return t2[Vide.read(t3.Currency)]
		end,
		Size = UDim2.fromScale(0.8, 0.8)
	}

	if t3.RedIfInsufficient then
		function v11.TextColor3() -- line: 53
			-- upvalues: Vide (copy), t3 (copy), t4 (copy), getDataSource (copy)
			local v15 = Vide.read(t3.Currency)
			local v16 = t4[v15]

			if not v16 then
				v16 = getDataSource(v15)
				t4[v15] = v16
			end

			return (v16() or 0) >= Vide.read(t3.Amount) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 45, 73)
		end
	end

	return TextLabel(v11)
end
