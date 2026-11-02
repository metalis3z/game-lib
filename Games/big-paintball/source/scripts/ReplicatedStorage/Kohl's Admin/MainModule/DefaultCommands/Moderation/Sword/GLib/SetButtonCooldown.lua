--[[
	Sets a cooldown for a mobile button.  The button will fade back into the regular color.
--]]
local cooldowns = {}
local RenderStepped = game:GetService'RunService'.RenderStepped
local CAS = game:GetService'ContextActionService'

local function remove(name)
	local info = cooldowns[name]
	if info then
		info.ShaderFrame:Destroy()
		info.ShadowImage:Destroy()
		cooldowns[name] = nil
	end
end

if not game:FindService'NetworkServer' then
	RenderStepped:connect(function()
		for name, info in next, cooldowns do
			local alpha = math.min((tick()-info.StartedAt)/info.Length, 1)
			info.ShaderFrame.Position = UDim2.new(0, 0, alpha, 0)
			info.ShaderFrame.Size = UDim2.new(1, 0, 1-alpha, 0)
			info.ShadowImage.Position = UDim2.new(0, 0, 0, -alpha*info.ShaderFrame.AbsoluteSize.x)
			if alpha == 1 then
				remove(name)
			end
		end
	end)
end

return function(name, t)
	remove(name)
	
	if t and t > 0 then
		local GLib = require(script.Parent)
		local button = CAS:GetButton(name)
		local info = {
			StartedAt = tick(),
			Length = t,
			ShaderFrame = GLib.Create'Frame'{
				Name = 'Shader',
				BackgroundTransparency = 1,
				Parent = button,
				Size = UDim2.new(1, 0, 1, 0),
				ClipsDescendants = true
			},
			ShadowImage = GLib.Create'ImageLabel'{
				Name = 'Image',
				BackgroundTransparency = 1,
				Image = button.Image,
				ImageRectSize = button.ImageRectSize,
				ImageRectOffset = button.ImageRectOffset,
				Size = button.Size,
				ZIndex = button.ZIndex+1
			},
			Button = button
		}
		info.ShadowImage.ImageColor3 = Color3.new(.5, .5, .5)
		info.ShadowImage.Parent = info.ShaderFrame
		
		cooldowns[name] = info
	end
end