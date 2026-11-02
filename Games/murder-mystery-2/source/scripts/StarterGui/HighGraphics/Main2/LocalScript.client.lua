local Lights = game:GetService("Lighting")
local HighGraph = script.Parent.Parent.Main

script.Parent.MouseButton1Click:connect(function()
	Lights.Blur.Enabled = false;
	Lights.HDR.Enabled = false;
	Lights.HDR2.Enabled = false;
	HighGraph.Visible = true; 
	script.Parent.Visible = false;
end)
	