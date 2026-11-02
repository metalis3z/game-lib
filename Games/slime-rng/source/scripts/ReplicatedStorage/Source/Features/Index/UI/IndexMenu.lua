-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexMenu, time of decompilation: Sun May  3 10:12:33 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local IndexRewardUtils = require(ReplicatedStorage.Source.Features.Index.IndexRewardUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local IndexSlice = require(ReplicatedStorage.Source.Features.Index.IndexSlice)
local IndexPage = require(ReplicatedStorage.Source.Features.Index.UI.IndexPage)

return {
	menuId = "Index",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 11
		-- upvalues: getDataSource (copy), Vide (copy), IndexServiceUtils (copy), IndexSlice (copy), IndexRewardUtils (copy), Menu (copy), IndexPage (copy)
		local v9 = getDataSource("index")
		local v10 = Vide.derive(function() -- line: 13
			-- upvalues: IndexServiceUtils (copy), v9 (copy)
			return IndexServiceUtils.reconcileIndexData(v9())
		end)
		local v11 = IndexSlice.getActiveCategoryId()
		local t1 = {}

		for v13, v14 in IndexServiceUtils.getCategoryIds() do
			local v15 = IndexServiceUtils.getCategoryDisplayInfo(v14)

			t1[v14] = {
				Text = v15.buttonText,
				Title = v15.title,
				Image = v15.icon,
				SlimeData = v15.slimeData,
				LayoutOrder = v13,
				NotificationCount = function() --[[ NotificationCount ]] -- line: 27
					-- upvalues: IndexRewardUtils (copy), v10 (copy), v14 (copy)
					return IndexRewardUtils.getClaimableRewardCountForCategoryFromData(v10(), v14)
				end,
				NotificationBadgeSize = UDim2.fromOffset(24, 24),
				NotificationBadgePosition = UDim2.fromScale(0.18, 0.08),
				NotificationBadgeAnchorPoint = Vector2.new(0.5, 0.5)
			}
		end

		return Menu.Component({
			menuId = "Index",
			Title = "Index",
			Scale = 1.05,
			SideBarButtons = t1,
			CurrentPageSource = v11,
			SetCurrentPage = IndexSlice.actions.setActiveCategoryId,
			IndexPage()
		})
	end
}
