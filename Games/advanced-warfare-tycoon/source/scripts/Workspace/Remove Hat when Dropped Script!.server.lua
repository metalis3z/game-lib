while true do
wait(3)
local c = game.Workspace:GetChildren()
for i = 1, #c do
if (c[i].className == "Hat") then
c[i]:Remove()
end
end
end
