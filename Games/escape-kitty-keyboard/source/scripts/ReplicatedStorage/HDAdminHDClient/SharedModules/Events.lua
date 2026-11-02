

local _ = _G.HDAdminMain
local u8 = {
	["DoubleJumped"] = function(u1, p2, ...)
		local u3 = 0
		local u4 = true
		p2:GetPropertyChangedSignal("Jump"):Connect(function()

			if u4 then
				u4 = false
				u3 = u3 + 1
				if u3 == 4 then
					u1:Fire()
				end
				wait()
				u4 = true
				wait(0.2)
				u3 = u3 - 1
			end
		end)
	end,
	["EventName"] = function(_, _, ...) end,
	["New"] = function(_, p5, p6, ...) 

		local v7 = Instance.new("BindableEvent")
		u8[p5](v7, p6, ...)
		v7.Parent = p6
		return v7
	end
}
return u8