Up = false
Debounce = false

function touched(Part)
if Debounce == false then
Debounce = true

if Up == false then
for i=1, 10 do
game.Workspace.gate.CFrame = script.Parent.CFrame * CFrame.new(0, -0.2, 0)
wait(0.03)
end
Up = true
Debounce = false
end

elseif Up == true then
Debounce = true
for i=1, 10 do
game.Workspace.gate.CFrame = script.Parent.CFrame * CFrame.new(0, 0.2, 0)
wait(0.03)
Debounce = false
Up = false
end
end
end
script.Parent.Touched:connect(touched)