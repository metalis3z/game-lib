--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local EmoteCard = require(frontend.Components.EmoteCard)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type CardProps = {
	emoteName: string,
	emoteId: number,
	isFavourited: Fusion.UsedAs<boolean>,
	activeEmoteId: Fusion.UsedAs<number?>?,
	onRun: (() -> ())?,
	onFavourite: (() -> ())?,
	onUnlock: (() -> ())?,
}
type Row = {
	layoutOrder: number,
	cards: { CardProps },
	columns: number,
}


-- A short row pads with invisible fillers so cards left-align instead of stretching
return function(scope: Scope, row: Row): Instance
	local cardInstances = {}
	for index, card in row.cards do
		-- An activeEmoteId toggle should only update the affected cards, not rebuild rows
		local isActive = if card.activeEmoteId then scope:Computed(function(use)
			return use(card.activeEmoteId) == card.emoteId
		end) else nil
		cardInstances[index] = EmoteCard(scope, {
			emoteName = card.emoteName,
			emoteId = card.emoteId,
			isFavourited = card.isFavourited,
			isActive = isActive,
			onRun = card.onRun,
			onFavourite = card.onFavourite,
			onUnlock = card.onUnlock,
			layoutOrder = index,
		})
	end
	for filler = #row.cards + 1, row.columns do
		cardInstances[filler] = scope:New "Frame" {
			Name = "Filler",
			BackgroundTransparency = 1,
			LayoutOrder = filler,
			Size = UDim2.new(0, 0, 0, 0),
		}
	end
	return scope:New "Frame" {
		Name = "EmoteRow",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = row.layoutOrder,
		Size = UDim2.new(1, 0, 0, 0),
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			cardInstances,
		},
	}
end
