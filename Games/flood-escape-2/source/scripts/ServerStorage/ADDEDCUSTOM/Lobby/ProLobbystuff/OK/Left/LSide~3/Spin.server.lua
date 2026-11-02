spinning = script.Parent

while true do
spinning.CFrame = spinning.CFrame * CFrame.fromEulerAnglesXYZ(0,(-0.005),0)
wait(0.00)
end
