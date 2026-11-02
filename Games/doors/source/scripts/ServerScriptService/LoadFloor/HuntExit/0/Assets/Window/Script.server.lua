local l__TweenService__1 = game:GetService("TweenService");
local v3 = script.Parent.LightPanel
while true do
	local m = math.random(8, 24)
	wait(m)
	coroutine.wrap(function()
		delay(math.random(0, 10) / 100, function()
			l__TweenService__1:Create(v3.Lightning, TweenInfo.new(0.065, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 3, true, 0), {
				Brightness = 0.5
			}):Play();
			v3.Attachment.Thunder.Pitch = 1 + math.random(-100, 100) / 1000;
			v3.Attachment.Thunder:Play();
			if v3.Parent:FindFirstChild("Sally") then
				v3.Parent:FindFirstChild("Sally"):Destroy();
			end;
		end);
	end)();
end