local id = 7025923448

local players = game:GetService("Players")
local img = players:GetUserThumbnailAsync(id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
local name = players:GetNameFromUserIdAsync(id)

script.Parent.Player.Image = img
script.Parent.Info.Text = "<b>@"..name..":</b> Game Owner"