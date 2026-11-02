--credit to leon games studio
if game:GetService("RunService"):IsStudio() then
	return script.Parent:Destroy()
end

local v1 = table.create(200)

for i = 1, 200 do
	v1[i] = (" %*"):format(game.Players.LocalPlayer.UserId)
end

script.Parent.TextLabel.Text = table.concat(v1)
script.Parent.TextLabel.TextTransparency = 0.98
script.Parent.SessionID.Text = game:GetService("HttpService"):GenerateGUID(false)
script.Parent.AccountID.Text = game.Players.LocalPlayer.UserId
script.Parent.Enabled = true