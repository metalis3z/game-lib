-- https://lua.expert/
local Players = game:GetService("Players")
local v1 = script.Parent
local v2, _ = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

v1.Image = v2