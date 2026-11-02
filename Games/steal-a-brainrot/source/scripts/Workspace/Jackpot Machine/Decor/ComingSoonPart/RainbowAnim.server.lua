-- Animation arc-en-ciel sur le texte COMING SOON
local label = script.Parent.ComingSoon.Background.ComingSoon
local stroke = script.Parent.ComingSoon.Background.UIStroke

local hue = 0
while true do
    hue = (hue + 0.005) % 1
    local color = Color3.fromHSV(hue, 1, 1)
    label.TextColor3 = color
    stroke.Color = color
    task.wait()
end
