local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))

local Tool = script.Parent
sp=script.Parent


cooldown=2.1
spraysize=5
range=20


baseid="http://www.roblox.com/Thumbs/Asset.ashx?Width=75&Height=75&AssetID="
local sprayid = 0
equipped=false
check=true



local gui = sp:WaitForChild("SprayGui")
local frame = gui:WaitForChild("Frame")
local image = frame:WaitForChild("ImageLabel")
local player = game.Players.LocalPlayer
local choose = frame:WaitForChild("Frame"):WaitForChild("ChooseDecal")


workspace.Main.AssetIdChanged.AssetIdChanged.Event:connect(function(object,newId)
	if object == Tool then
		sprayid = tonumber(newId)
		image.Image = baseid .. newId
	end
end)

choose.MouseButton1Click:connect(function()
	workspace.Main.OpenAssetPicker.OpenAssetPicker:Fire(Tool,"Decal")
end)





function onEquipped(mouse)
	equipped=true
	local plr=game.Players.LocalPlayer
	if mouse~=nil and plr~=nil then
		local plrgui=plr.PlayerGui
		if plrgui~=nil then
			gui.Parent=plrgui
		end
		mouse.Button1Down:connect(function()
			local chr=sp.Parent
			if chr and check and mouse.Target~=nil and mouse.TargetSurface~=nil and mouse.Target.Name~="Spray" and mouse.Target.Name~="Effect" and sprayid>0 then
				local surface=mouse.TargetSurface
				local t=chr:FindFirstChild("HumanoidRootPart")
				local h=chr:FindFirstChild("Humanoid")
				local animobject=sp:FindFirstChild("SprayPaint")
				if t and h and animobject then
					if h.Health>0 then
						check=false
						anim=h:LoadAnimation(animobject)
						if anim then
							anim:Play()
							sp.Handle.Sound:Play()
						end
						if (t.Position-mouse.Hit.p).magnitude<range then
							local canspray=false
							if (surface==Enum.NormalId.Front or surface==Enum.NormalId.Back) and mouse.Target.Size.x>=spraysize and mouse.Target.Size.y>=spraysize then
								canspray=true
							elseif (surface==Enum.NormalId.Left or surface==Enum.NormalId.Right) and mouse.Target.Size.y>=spraysize and mouse.Target.Size.z>=spraysize then
								canspray=true
							elseif (surface==Enum.NormalId.Top or surface==Enum.NormalId.Bottom) and mouse.Target.Size.x>=spraysize and mouse.Target.Size.z>=spraysize then
								canspray=true
							end
							if canspray then
								
								game.Workspace.Main.SprayPaint:FireServer(sprayid,surface,spraysize,mouse.Target,mouse.Hit.p)
								

							end
						end
						wait(cooldown)
						sp.Handle.Sound:Stop()
						check=true
					end
				end
			end
		end)
	end
end

function onUnequipped()
	gui.Parent=sp
	equipped=false
end

sp.Equipped:connect(onEquipped)
sp.Unequipped:connect(onUnequipped)


