while true do
wait(0)
if script.Parent.on.Value == true then
	script.Parent.FL.Transparency = 1
	script.Parent.RL.Transparency = 1
	script.Parent.FL.Light.Enabled = false
	script.Parent.RL.Light.Enabled = false
	wait(0.35)
	script.Parent.FL.Transparency = 0
	script.Parent.RL.Transparency = 0
	script.Parent.FL.Light.Enabled = true
	script.Parent.RL.Light.Enabled = true
	wait(0.35)
else
	script.Parent.FL.Transparency = 1
	script.Parent.RL.Transparency = 1
	script.Parent.FL.Light.Enabled = false
	script.Parent.RL.Light.Enabled = false
end
end