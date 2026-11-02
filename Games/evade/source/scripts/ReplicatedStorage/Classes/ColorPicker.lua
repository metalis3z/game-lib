local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v1.LocalPlayer
local v4 = v_u_3:WaitForChild("PlayerGui")
local v_u_5 = require(v2.Packages.Serializer)
local v6 = require(v2.Packages.Component)
local v_u_7 = require(v2.Packages.Synchronizer)

local v_u_8
local success, err = pcall(function()
	v_u_8 = require(v2.Classes.ColorPicker)
end)
if not success then
	warn("[SkinsPanelWindow] Failed to load ColorPicker from Classes, trying Components...")
	success, err = pcall(function()
		v_u_8 = require(v2.Components.ColorPicker)
	end)
	if not success then
		warn("[SkinsPanelWindow] Failed to load ColorPicker from Components, trying Packages...")
		v_u_8 = require(v2.Packages.ColorPicker)
	end
end

local v_u_9 = require(v2.Packages.Trove)
require(v2.Packages.Timer)
require(v2.Packages.State)
local v_u_10 = require(v2.Packages.Observers)
local v11 = require(v2.Packages.Net)
local v_u_12 = require(v2.Classes.AnimatedButton)
local v_u_13 = v11:RemoteEvent("PlotService/ApplySkin")
local v14 = v6.new({
	["Tag"] = "SkinsPanelWindow",
	["Ancestors"] = { v4 }
})
local v_u_15 = {
	Vector3.new(99, 95, 98),
	Vector3.new(69, 71, 80),
	Vector3.new(27, 42, 53),
	Vector3.new(91, 93, 105)
}
function v14.Construct(p16)
	p16._trove = v_u_9.new()
end
function v14.Start(p17)
	local v18 = v_u_12.new(p17.Instance:WaitForChild("Apply"))
	local v19 = p17.Instance:WaitForChild("Base")
	local v20 = p17.Instance:WaitForChild("Colors")
	local v_u_21 = v19.ViewportFrame
	local v_u_22 = {}
	p17._trove:Add(v_u_10.observeAttribute(v_u_21, "BaseColors", function(p23)
		local v24 = v_u_5.deserializeDictionary(p23)
		for v25, v26 in pairs(v24) do
			v_u_22[v25].Frame.BackgroundColor3 = v26
		end
	end))
	p17._trove:Add(v_u_10.observeAttribute(p17.Instance, "Showing", function(p27)
		local v28 = not p27 and v_u_8.GetCurrentWheel()
		if v28 then
			v28:Destroy()
		end
	end))
	for v29, v_u_30 in pairs(v_u_15) do
		local v_u_31 = v20.Template:Clone()
		v_u_31.TextLabel.Text = ("Base Color %*"):format(v29)
		v_u_31.Visible = true
		v_u_31.Parent = v20
		v_u_31.Frame.MouseButton1Down:Connect(function()
			local v32 = v_u_8.new(v_u_31.Frame.BackgroundColor3)
			if v32 then
				local v33 = v_u_5.deserializeDictionary(v_u_21:GetAttribute("BaseColors"))
				v33[v_u_30] = v32
				v_u_21:SetAttribute("BaseColors", v_u_5.serializeDictionary(v33))
			end
		end)
		v_u_22[v_u_30] = v_u_31
	end
	v_u_21:SetAttribute("BaseColors", v_u_21:GetAttribute("BaseColors"))
	v18:Animate()
	v18.OnActivated:Connect(function()
		v_u_13:FireServer(v_u_21:GetAttribute("BaseColors"))
	end)
	v_u_7:WaitAndCall(v_u_3, function(p34)
		p34:OnChanged("Rebirth", function(p35)
			v_u_21:SetAttribute("Tier", p35)
		end, true)
		p34:OnChanged("BaseSkin", function(p36)
			if p36 and p36 ~= "None" then
				v_u_21:SetAttribute("BaseColors", p36)
			end
		end, true)
	end)
end
function v14.Stop(p37)
	p37._trove:Destroy()
end
return v14