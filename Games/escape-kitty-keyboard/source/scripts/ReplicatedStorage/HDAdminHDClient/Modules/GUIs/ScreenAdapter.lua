

local u1 = _G.HDAdminMain
local u2 = 0
local u3 = {
	[u1.gui.MainFrame] = 0.78,
	[u1.gui.MenuTemplates.Template5] = 0.78,
	[u1.gui.MenuTemplates.Template6] = 0.78,
	[u1.gui.MenuTemplates.Template7] = 0.78,
	[u1.gui.MenuTemplates.Template9] = 0.78,
	[u1.gui.MenuTemplates.Template10] = 1.17,
	[u1.gui.MenuTemplates.Template11] = 1.17,
	[u1.gui.MenuTemplates.Template12] = 0.78,
	[u1.gui.MenuTemplates.Template16] = 0.78
}
local u4 = {
	["Phone"] = 0.9,
	["PhoneVertical"] = 0.5,
	["Tablet"] = 0.7,
	["TabletVertical"] = 0.6,
	["Computer"] = 0.6
}
local function u14() 

	local v5 = u4.Computer
	local _ = u1.gui.Parent
	local v6 = u1.gui.AbsoluteSize.Y > u1.gui.AbsoluteSize.X
	local v7 = u1.device == "Mobile"
	local v8 = v6 and v7
	if v7 then
		if u1.tablet then
			v5 = u4.Tablet
			if v6 then
				v5 = u4.TabletVertical
			end
		else
			v5 = u4.Phone
			if v6 then
				v5 = u4.PhoneVertical
			end
		end
	end
	for v9, v10 in pairs(u3) do
		local v11
		if v10 > 1 then
			v11 = v5 / 1.5
		else
			v11 = v5
		end
		v9.Position = UDim2.new(0, 0, (1 - v11) / 2, 0)
		v9.Size = UDim2.new(0, 0, v11, 0)
		local v12 = v9.AbsoluteSize.Y * v10
		local v13 = v9:GetAttribute("CustomYScalePos")
		v9.Position = UDim2.new((v8 or not v13) and 0.5 or v13, -v12 / 2, v9.Position.Y.Scale, v9.Position.Y.Offset)
		v9.Size = UDim2.new(0, v12, v9.Size.Y.Scale, v9.Size.Y.Offset)
	end
end
u1.gui.Changed:Connect(function(p15)

	if p15 == "AbsoluteSize" then
		u2 = u2 + 1
		wait(0.5)
		u2 = u2 - 1
		if u2 == 0 then
			u14()
			u1:GetModule("PageAbout"):CreateCredits()
		end
	end
end)
u14()
return {}