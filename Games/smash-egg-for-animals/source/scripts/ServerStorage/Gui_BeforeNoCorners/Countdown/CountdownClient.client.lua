-- CountdownClient : affiche le compte a rebours global (lit les attributs poses par CountdownServer)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gui = script.Parent
local container = gui:WaitForChild("Container")
local titleLabel = container:WaitForChild("Title")
local timeLabel = container:WaitForChild("Time")

local function format(secs)
	local d = math.floor(secs / 86400)
	local h = math.floor(secs % 86400 / 3600)
	local m = math.floor(secs % 3600 / 60)
	local s = secs % 60
	if d > 0 then
		return string.format("%dj %02d:%02d:%02d", d, h, m, s)
	elseif h > 0 then
		return string.format("%d:%02d:%02d", h, m, s)
	end
	return string.format("%d:%02d", m, s)
end

local function update()
	local endTime = ReplicatedStorage:GetAttribute("CountdownEnd")
	local left = type(endTime) == "number" and (endTime - workspace:GetServerTimeNow()) or 0
	if left > 0 then
		local secs = math.ceil(left)
		timeLabel.Text = format(secs)
		timeLabel.TextColor3 = secs <= 10 and Color3.fromRGB(255, 90, 70) or Color3.new(1, 1, 1)
		local label = ReplicatedStorage:GetAttribute("CountdownLabel")
		titleLabel.Text = type(label) == "string" and label or ""
		titleLabel.Visible = titleLabel.Text ~= ""
		container.Visible = true
	else
		container.Visible = false -- termine (ou aucun compte a rebours) : la GUI disparait
	end
end

while true do
	update()
	task.wait(0.2)
end
