return function(Tool)
	local mag = Tool.GunModel.Magazine
	mag.Transparency = 0
	
	for a = 0,14 do
		local b = Tool.GunModel:findFirstChild("Bullet" .. a)
		if (b) then
			b.Transparency = 0
		end
	end
end