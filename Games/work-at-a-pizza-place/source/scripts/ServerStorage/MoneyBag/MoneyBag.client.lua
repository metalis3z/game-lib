if game:GetService("UserInputService").TouchEnabled then
	script.Parent.ToolTip = ""
end
local Tool = script.Parent
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")

CoinCount = MainGui.Notifications:WaitForChild("CoinCount")
Amount = CoinCount:WaitForChild("Amount")


function UpdateCount(amount)
	if amount == 0 then 
		CoinCount.Visible = false 
		script.Parent:Destroy() 
	else
		Amount.Text = amount .. " Moneyz left"
		script.Parent.Handle.Mesh.Scale = Vector3.new((.6/6000)*amount,(.9/6000)*amount,(.6/6000)*amount)
	end
end



enabled = true
function onButton1Down(mouse)
	if enabled then
		enabled = false
		workspace.Animation.PlayAnimation.PlayAnimation:Fire("ThrowCoin",0)
		wait(.3)
		local amount = workspace.Main.ThrowCoin:InvokeServer()
		UpdateCount(amount)
		wait(.2)
		enabled = true
	end
end




function onEquippedLocal(mouse)
	local amount = workspace.Main.GetCoinCount:InvokeServer()
	UpdateCount(amount)
	CoinCount.Visible = true
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)
end

function onUnequippedLocal(mouse)
	CoinCount.Visible = false
end


Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)
