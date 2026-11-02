local Tool = script.Parent;

enabled = true
function onButton1Down(mouse)
	if not enabled then
		return
	end

	local vCharacter = Tool.Parent
	local hum = vCharacter:findFirstChild("Humanoid")
	blah = hum:LoadAnimation(script.Parent.eating)
	blah:Play()

	enabled = false
	mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"

	wait(0.5)
	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	enabled = true

end


function onEquippedLocal(mouse)

	if mouse == nil then
		print("Mouse not found")
		return 
	end

	local vCharacter = Tool.Parent
	local humanoid = vCharacter.Humanoid


	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)
end

function onUnequippedLocal()
end

Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)
