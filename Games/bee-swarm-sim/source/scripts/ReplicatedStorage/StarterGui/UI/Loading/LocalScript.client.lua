script.Parent.Visible = true
local TSS = script.Parent.TS
local Frame = script.Parent
wait(2)
for i = 1, 5 do
	TSS["T"..i]:TweenSize(UDim2.new(0.125, 0, 1, 0), "Out", "Back", 0.3, true)
	Frame.Logo:TweenSize(UDim2.new(0, 200 * (i/4), 0, 200 * (i/4)), "Out", "Back", 0.3, true)
	wait(2)
end

for i = 1, 5 do
	TSS["T"..i]:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.3, true)
	wait(0.75)
	if i == 5 then
		Frame.Logo:TweenSize(UDim2.new(0, 600, 0, 600), "Out", "Back", 0.3, true)
		spawn(function()
			wait(0.2)
			Frame.Logo:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.3, true)
		end)
	end
end
wait(1.85)
script.Parent:TweenPosition(UDim2.new(0.5, 0, 2, 0), "Out", "Back", 0.1, true)