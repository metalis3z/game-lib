local Lights = game:GetService("Lighting")
local LowGraph = script.Parent.Parent.Main2
script.Parent.MouseButton1Click:connect(function()
	Lights.Blur.Enabled = true;
	Lights.HDR.Enabled = true;
	Lights.HDR2.Enabled = true;
	Lights.Bloom.Enabled = true;
	LowGraph.Visible = true; 
	script.Parent.Visible = false;
end)
	
	