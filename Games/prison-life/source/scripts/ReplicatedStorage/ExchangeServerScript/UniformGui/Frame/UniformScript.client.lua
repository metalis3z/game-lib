--[Reference Variables]--
local sp = script.Parent
local open = sp:WaitForChild("OpenButton")
local toggle = sp:WaitForChild("Toggle")
local removeUni = sp:WaitForChild("RemoveUniform")
local removeHats = sp:WaitForChild("RemoveHats")
local removeTShirt = sp:WaitForChild("RemoveTShirt")

--[Value Variables]--
local isOpen = false
local deb = false

--[Events]--
open.Activated:connect(function()
	if not deb then
		deb = true
		if not isOpen then
			toggle.Visible = true
			removeUni.Visible = true
			removeHats.Visible = true
			removeTShirt.Visible = true
			toggle:TweenPosition(UDim2.new(0.125,0,0.2,0),"Out","Quad",.1,true)
			removeHats:TweenPosition(UDim2.new(0.125,0,0.4,0),"Out","Quad",.1,true)
			removeUni:TweenPosition(UDim2.new(0.125,0,0.8,0),"Out","Quad",.1,true)
			removeTShirt:TweenPosition(UDim2.new(0.125,0,0.6,0),"Out","Quad",.1,true)
			isOpen = true
		else
			toggle:TweenPosition(UDim2.new(0.125,0,0.05,0),"Out","Quad",.1,true)
			removeHats:TweenPosition(UDim2.new(0.125,0,0.05,0),"Out","Quad",.1,true)
			removeUni:TweenPosition(UDim2.new(0.125,0,0.05,0),"Out","Quad",.1,true)
			removeTShirt:TweenPosition(UDim2.new(0.125,0,0.05,0),"Out","Quad",.1,true)
			wait(.1)
			toggle.Visible = false
			removeUni.Visible = false
			removeHats.Visible = false
			removeTShirt.Visible = false
			isOpen = false
		end
		deb = false
	end
end)

toggle.Activated:connect(function()
	game.ReplicatedStorage.ExchangeServerScript.UniActions:FireServer("toggle")
end)

removeHats.Activated:connect(function()
	game.ReplicatedStorage.ExchangeServerScript.UniActions:FireServer("remove hats")
end)

removeUni.Activated:connect(function()
	game.ReplicatedStorage.ExchangeServerScript.UniActions:FireServer("remove uniform")
	script.Parent.Parent:Destroy()
end)

removeTShirt.Activated:connect(function()
	game.ReplicatedStorage.ExchangeServerScript.UniActions:FireServer("remove tshirt")
end)

--Created by devTools