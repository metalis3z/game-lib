-- Script by XcorrectTheDev

local AnimDebounce = false
local Mouth = script.Parent
local Mouth1_2 = script.Parent.Parent.Mouth1_2
local Mouth2 = script.Parent.Parent.Mouth2
local Mouth2_2 = script.Parent.Parent.Mouth2_2

-- Checking what mouth shape will be
function UpdateMouth()
if Mouth.Transparency == 1 then
Mouth1_2.Transparency = 1
Mouth1_2.MouthDecal.Transparency = 1
elseif Mouth.Transparency == 0 then
Mouth1_2.Transparency = 0.75
Mouth1_2.MouthDecal.Transparency = 0
end
if Mouth2.Transparency == 1 then
Mouth2_2.Transparency = 1
Mouth2_2.MouthDecal.Transparency = 1
elseif Mouth2.Transparency == 0 then
Mouth2_2.Transparency = 0.75
Mouth2_2.MouthDecal.Transparency = 0
end
end

Mouth.Changed:Connect(UpdateMouth)
Mouth2.Changed:Connect(UpdateMouth)

-- Mouth Animtion. 69 nice
local SizeState1 = Vector3.new(0.794, 0.69, 0.949)
local SizeState2 = Vector3.new(0.794, 0.69, 0.849)
local SizeState3 = Vector3.new(0.794, 0.69, 0.749)
local SizeState4 = Vector3.new(0.794, 0.69, 0.649)
local SizeState5 = Vector3.new(0.794, 0.69, 0.549)

while true do
if not AnimDebounce then
AnimDebounce = true
for i = 1,math.random(1,5) do
Mouth.Size = SizeState1
Mouth1_2.Size = SizeState1
wait(0.05)
Mouth.Size = SizeState2
Mouth1_2.Size = SizeState2
wait(0.05)
Mouth.Size = SizeState3
Mouth1_2.Size = SizeState3
wait(0.05)
Mouth.Size = SizeState4
Mouth1_2.Size = SizeState4
wait(0.05)
Mouth.Size = SizeState5
Mouth1_2.Size = SizeState5
wait(0.5)
Mouth.Size = SizeState5
Mouth1_2.Size = SizeState5
wait(0.05)
Mouth.Size = SizeState4
Mouth1_2.Size = SizeState4
wait(0.05)
Mouth.Size = SizeState3
Mouth1_2.Size = SizeState3
wait(0.05)
Mouth.Size = SizeState2
Mouth1_2.Size = SizeState2
wait(0.05)
Mouth.Size = SizeState1
Mouth1_2.Size = SizeState1
wait(math.random(0.05,1))
end
wait(math.random(8,16))
AnimDebounce = false
end
end