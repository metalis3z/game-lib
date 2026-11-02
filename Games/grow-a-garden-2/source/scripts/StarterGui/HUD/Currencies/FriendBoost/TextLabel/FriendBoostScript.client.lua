--credit to prince games studio
local v1 = script.Parent
local TextLabel = script.Parent:WaitForChild("TextLabel")
local LocalPlayer = game.Players.LocalPlayer
local v2 = script.Parent.Parent

local function update() --[[ update | Line: 7 | Upvalues: LocalPlayer (copy), v1 (copy), TextLabel (copy), v2 (copy) ]]
	local v12 = LocalPlayer:GetAttribute("Friends") or 0
	local v22 = "FRIEND BOOST: " .. v12 * 10 .. "%"

	v1.Text = v22
	TextLabel.Text = v22

	if v12 > 0 then
		v2.Visible = true
	else
		v2.Visible = false
	end
end

local v3 = LocalPlayer:GetAttribute("Friends") or 0
local v4 = "FRIEND BOOST: " .. v3 * 10 .. "%"

v1.Text = v4
TextLabel.Text = v4

if v3 > 0 then
	v2.Visible = true
else
	v2.Visible = false
end

LocalPlayer:GetAttributeChangedSignal("Friends"):Connect(update)