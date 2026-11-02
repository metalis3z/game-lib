-- LuckHud : affiche "4x server luck" + timer (mm:ss) en bas a gauche tant que l'event de chance est actif
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local label = script.Parent:WaitForChild("Luck")

local function format(secs)
	local h = math.floor(secs / 3600)
	local m = math.floor(secs % 3600 / 60)
	local s = secs % 60
	if h > 0 then return string.format("%d:%02d:%02d", h, m, s) end
	return string.format("%d:%02d", m, s)
end

while true do
	local endTime = ReplicatedStorage:GetAttribute("LuckEnd")
	local mult = ReplicatedStorage:GetAttribute("LuckMultiplier")
	local left = type(endTime) == "number" and (endTime - workspace:GetServerTimeNow()) or 0
	if left > 0 and type(mult) == "number" then
		label.Text = mult .. "x server luck\n" .. format(math.ceil(left))
		label.Visible = true
	else
		label.Visible = false
	end
	task.wait(0.2)
end
