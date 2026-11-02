local Function = game.ReplicatedStorage.GetPlayerImage

Function.OnInvoke = function(name)
	return game.Players:GetUserThumbnailAsync(game.Players:GetUserIdFromNameAsync(name), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352)
end