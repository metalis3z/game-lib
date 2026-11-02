

local v1 = {}
local u2 = game:GetService("Lighting")
game:GetService("Debris")
local u3 = {
	["DURATION"] = 3,
	["FLASH_INTERVAL"] = 0.15
}
local u4 = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 100, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(255, 0, 255),
	Color3.fromRGB(0, 255, 255),
	Color3.fromRGB(255, 128, 0)
}
function v1.Run(_) 

	task.spawn(function()

		local v5 = Instance.new("ColorCorrectionEffect")
		v5.Name = "TikfinityDisco"
		v5.Parent = u2
		local v6 = os.clock()
		local v7 = 1
		while os.clock() - v6 < u3.DURATION do
			v5.TintColor = u4[v7]
			v7 = v7 % #u4 + 1
			task.wait(u3.FLASH_INTERVAL)
		end
		v5:Destroy()
	end)
end
return v1