local toaster = script:WaitForChild("ObjectPointer").Value
local detector = toaster.ClickDetector
toast1 = toaster.Toast1
toast2 = toaster.Toast2
lever = toaster.Lever
tframe1 = toast1.CFrame
tframe2  = toast2.CFrame
lev = lever.CFrame


function cloner(toast)
	local t = toast:clone()
	t.Name = "Toast"
	t.CanCollide = true
	t.Anchored = false
	t.Transparency = 0
	t.Parent = workspace
	t.CFrame = toast.CFrame
	t.Velocity = Vector3.new(0,40,0)
	
	return t
end
debounce = false
function onMouseClick(player)
	if not debounce then
		debounce = true
	toast1.CFrame = toast1.CFrame + Vector3.new(0,-.3,0)
	toast2.CFrame = toast2.CFrame + Vector3.new(0,-.3,0)
	lever.CFrame = lever.CFrame + Vector3.new(0,-.3,0)
	wait(6)
	toast1.BrickColor = BrickColor.new(192)
	toast2.BrickColor = BrickColor.new(192)
	wait(2)
	toast1.Transparency = 1
	toast2.Transparency = 1
	
	local t1 = cloner(toast1)
	local t2 = cloner(toast2)
	
	wait(3)
	toast1.BrickColor = BrickColor.new(18)
	toast2.BrickColor = BrickColor.new(18)
	toast1.Transparency = 0
	toast2.Transparency = 0
	toast1.CFrame = tframe1
	toast2.CFrame = tframe2
	lever.CFrame = lev
	wait(10)
	t1:Destroy()
	t2:Destroy()
	debounce = false
	end
	

end
detector.MouseClick:connect(onMouseClick)
