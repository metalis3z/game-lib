-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexPage, time of decompilation: Sun May  3 10:12:33 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local IndexSlice = require(ReplicatedStorage.Source.Features.Index.IndexSlice)
local IndexInfoFrame = require(ReplicatedStorage.Source.Features.Index.UI.Components.IndexInfoFrame)
local IndexListFrame = require(ReplicatedStorage.Source.Features.Index.UI.Components.IndexListFrame)
local IndexProgressBar = require(ReplicatedStorage.Source.Features.Index.UI.Components.IndexProgressBar)
local IndexRewardsFrame = require(ReplicatedStorage.Source.Features.Index.UI.Components.IndexRewardsFrame)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return function() -- line: 17
	-- upvalues: getDataSource (copy), Vide (copy), IndexServiceUtils (copy), IndexSlice (copy), Slimes (copy), Frame (copy), IndexListFrame (copy), IndexInfoFrame (copy), IndexProgressBar (copy), IndexRewardsFrame (copy)
	local v12 = getDataSource("index")
	local v13 = Vide.derive(function() -- line: 19
		-- upvalues: IndexServiceUtils (copy), v12 (copy)
		return IndexServiceUtils.reconcileIndexData(v12())
	end)
	local v14 = IndexSlice.getActiveCategoryId()
	local v15 = Vide.derive(function() -- line: 23
		-- upvalues: IndexSlice (copy), v14 (copy)
		return IndexSlice.selectedSlimeIds()[v14()]
	end)
	local v16 = Vide.derive(function() -- line: 26
		-- upvalues: v14 (copy), v15 (copy), Slimes (copy), IndexServiceUtils (copy), v13 (copy)
		local v17 = v14()
		local v18 = v15()

		if v18 ~= nil then
			return v18
		end

		for _, v20 in Slimes.getSortedSlimes() do
			if IndexServiceUtils.isUnlockedFromData(v13(), v17, v20.id) then
				return v20.id
			end
		end

		if Slimes.getSortedSlimes()[1] then
			return Slimes.getSortedSlimes()[1].id
		end

		return nil
	end)

	return Frame({
		Name = "IndexPage",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		IndexListFrame({
			CategoryId = v14,
			SelectedSlimeId = v16,
			IndexData = v13,
			OnSelected = function(s1: string) --[[ OnSelected ]] -- line: 51
				-- upvalues: IndexSlice (copy), v14 (copy)
				IndexSlice.actions.setSelectedSlimeId(v14(), s1)
			end
		}),
		IndexInfoFrame({
			CategoryId = v14,
			SelectedSlimeId = v16,
			IndexData = v13
		}),
		IndexProgressBar({
			CategoryId = v14,
			IndexData = v13
		}),
		IndexRewardsFrame({
			CategoryId = v14,
			IndexData = v13
		})
	})
end
