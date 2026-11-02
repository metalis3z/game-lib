hold = false
Tool = script.Parent;
local event = script:WaitForChild("PepperSprayEvent")

function OB1D(mouse)
hold = true
--Tool.Spray.Transparency = 1
--Tool.Spray.Script.Disabled = false
--Tool.Nossle.Spray.Enabled = true
event:FireServer("Button1Down")
end

function OB1U(mouse)
hold = false
--Tool.Spray.Transparency = 1
--Tool.Spray.Script.Disabled = true
--Tool.Nossle.Spray.Enabled = false
event:FireServer("Button1Up")
end

function onEquip(mouse)
if mouse == nil then return end

mouse.Button1Down:connect(function() OB1D(mouse) end)
mouse.Button1Up:connect(function() OB1U(mouse) end)

end
script.Parent.Equipped:connect(onEquip)
