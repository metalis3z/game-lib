while true do
	local rna = math.random(1, 5)
	wait(rna)
	script.Parent.Sound:Play()
	script.Parent.Core.Enabled = true
	script.Parent.MiniSparks.Enabled = true
	script.Parent.CoreMiniSparks.Enabled = true
	script.Parent.Sparks.Enabled = true
	wait(0.9)
	script.Parent.Core.Enabled = false
	script.Parent.MiniSparks.Enabled = false
	script.Parent.CoreMiniSparks.Enabled = false
	script.Parent.Sparks.Enabled = false
end