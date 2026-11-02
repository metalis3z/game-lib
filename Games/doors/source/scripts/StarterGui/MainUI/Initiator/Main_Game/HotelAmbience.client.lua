spawn(function()
	while true do
		local dre = math.random(1, 2)
		
		if workspace:FindFirstChild("AmbienceHotel_"..dre) then
			workspace:FindFirstChild("AmbienceHotel_"..dre):Play()
			wait(workspace:FindFirstChild("AmbienceHotel_"..dre).TimeLength)
			if dre == 1 then
				dre = dre + 1
			elseif dre == 2 then
				dre = dre - 1
			end
		end
	end
end)