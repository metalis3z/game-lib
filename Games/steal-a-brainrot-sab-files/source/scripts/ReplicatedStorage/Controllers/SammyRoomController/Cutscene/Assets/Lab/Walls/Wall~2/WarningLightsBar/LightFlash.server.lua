local TweenService = game:GetService("TweenService")
local v1 = script.Parent
local t = { Color3.fromRGB(204, 153, 64), Color3.fromRGB(204, 161, 124) }
local v2 = Color3.new(0/255, 0/255, 0/255)
local t2 = {
	Light1 = {},
	Light2 = {}
}
for i, v in ipairs(v1:GetDescendants()) do
	if v.Name == "Light1" or v.Name == "Light2" then
		table.insert(t2[v.Name], v)
	end
end
local function TweenColor(p1, p2, p3)
	return TweenService:Create(p1, TweenInfo.new(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Color = p3
	})
end
local function Flash(p1, p2, p3)
	for i, v in ipairs(p1) do
		local v1 = TweenColor(v, p3, p2)
		if v1 then
			v1:Play()
		end
	end
end
local function RapidSection()
	Flash(t2.Light1, t[1], 0.1)
	Flash(t2.Light2, v2, 0.04)
	task.wait(0.16)
	Flash(t2.Light1, v2, 0.04)
	Flash(t2.Light2, t[2], 0.1)
	task.wait(0.16)
	Flash(t2.Light1, t[2], 0.1)
	Flash(t2.Light2, t[1], 0.1)
	task.wait(0.16)
	Flash(t2.Light1, v2, 0.04)
	Flash(t2.Light2, v2, 0.04)
	task.wait(0.096)
end
while true do
	RapidSection()
	RapidSection()
end