local ogCount = script.Parent.Amount.Value

while true do
	script.Parent.Surface.SurfaceGui.TextLabel.Text = tostring(ogCount).."/"..tostring(ogCount)
	script.Parent.Surface.SurfaceGui.ToolText.Text = script.Parent.ToolValue.Value
	--script.Parent.BillboardGui.ToolText.Text = script.Parent.ToolValue.Value
	wait(300)
	script.Parent.Surface.SurfaceGui.TextLabel.Text = tostring(ogCount).."/"..tostring(ogCount)
	--script.Parent.BillboardGui.TextLabel.Text = "20/20"
	script.Parent.Count.Value = ogCount
end