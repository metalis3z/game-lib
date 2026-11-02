--!strict
-- This is the per-run emote card shown to each target


--- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Prompt = require(modules.Prompt)
local Task = require(modules.Objects.Task)


-- FUNCTION
return function(task: Task.Class, target: Player, emoteId: number, emoteName: string?, isLooped: boolean?)
	local Emotes = require(modules.Parent.Services.Emotes) :: any
	local Assets = require(modules.Parent.Services.Assets)
	local targetUser = require(modules.Objects.User).getUser(target)

	-- We whitelist this emote so the Unlock button's PromptBulkPurchase isn't rejected
	Assets.permitAsset(emoteId)

	local emoteAnimation = task.extra.emoteAnimation
	local animationIdString = emoteAnimation and emoteAnimation.AnimationId
	local animationId = if typeof(animationIdString) == "string" then tonumber(animationIdString:match("%d+")) else nil
	local looped = isLooped == true
	task:bindPrompt({
		deactivate = looped,
		rerun = not looped,
		args = {"AnimationSpeed"},
		onChange = function(arg, value)
			-- Keep the emote system's shared speed in sync since createEmoteCommand reads it
			task.extra.emoteSpeed = value
			local animation = task.extra.emoteAnimation
			if animation and animation.Parent then
				animation:SetAttribute("HDSpeed", value)
			end
		end,
		iconButtons = {
			{
				component = "Favourite",
				assetId = emoteId,
				active = Emotes.isFavorited(targetUser, emoteId),
				onAction = function(shouldFavourite: boolean)
					if shouldFavourite and emoteName and not Emotes.getEmoteById(emoteId) then
						Emotes.addEmoteAsync({emoteId = emoteId, originalName = emoteName})
					end
					local ok, reason = Emotes.setFavorite(targetUser, emoteId, shouldFavourite)
					if not ok then
						Prompt.warn(target, tostring(reason))
					end
				end,
			},
			{
				component = "Unlock",
				assetId = emoteId,
				emoteName = emoteName,
				animationId = animationId
			},
		},
	})
end
