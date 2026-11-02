player = game:GetService("Players").LocalPlayer
require(game.ReplicatedStorage:WaitForChild("Lib"))

local v1 = script.Parent

function updateUI() --[[ updateUI | Line: 6 | Upvalues: v1 (copy) ]]
	if player:GetAttribute("SpeedBoost") and not (player:GetAttribute("SpeedBoost") <= 0) then
		v1.Parent.Visible = true
		v1.Text = "Boost: " .. (player:GetAttribute("SpeedBoost") or "") .. "s"
	else
		v1.Parent.Visible = false
	end
end
player:GetAttributeChangedSignal("SpeedBoost"):Connect(updateUI)