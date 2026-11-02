
local head = script.Parent
local sound = head:findFirstChild("Sound")


function onTouched(part)
	local h = part.Parent:findFirstChild("Humanoid")
	if h~=nil then
sound:play()

	end
end

script.Parent.Touched:connect(onTouched)
