---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_contentprovider = game:GetService("ContentProvider")
require(v_replicatedstorage.Controllers.AnimalController).OnAnimalSpawn:Connect(function(self)
	local v_animationcontroller = self.AnimalModel.AnimationController
	local v1 = v_animationcontroller.Animator or Instance.new("Animator", v_animationcontroller)
	local v_u_loadanimation = v1:LoadAnimation(script.Dance)
	v_u_loadanimation.Priority = Enum.AnimationPriority.Action2
	v_u_loadanimation.Looped = true
	local v_u_loadanimation = v1:LoadAnimation(script.GettingUpTransition)
	v_u_loadanimation.Priority = Enum.AnimationPriority.Action3
	v_u_loadanimation.Looped = false
	local v_u_loadanimation = v1:LoadAnimation(script.GroundDance)
	v_u_loadanimation.Priority = Enum.AnimationPriority.Action3
	v_u_loadanimation.Looped = true
	v_u_loadanimation.Stopped:Connect(function()
		-- upvalues: (copy) v_u_loadanimation
		v_u_loadanimation:Play()
	end)
	local v_u_loadanimation = v1:LoadAnimation(script.GroundTransition)
	v_u_loadanimation.Priority = Enum.AnimationPriority.Action3
	v_u_loadanimation.Looped = false
	v_u_loadanimation.Stopped:Connect(function()
		-- upvalues: (copy) v_u_loadanimation
		v_u_loadanimation:Play()
	end)
	local function v2()
		-- upvalues: (copy) self, (copy) v_u_loadanimation
		if self.Instance:GetAttribute("Dance") then
			if not v_u_loadanimation.IsPlaying then
				self.WalkTrack:Stop()
				self.IdleTrack:Stop()
				v_u_loadanimation:Play()
				return
			end
		elseif v_u_loadanimation.IsPlaying then
			v_u_loadanimation:Stop()
			if self.Instance:GetAttribute("ForceIdle") then
				self.IdleTrack:Play()
				return
			end
			self.WalkTrack:Play()
		end
	end
	self.Collector:Add(self.Instance:GetAttributeChangedSignal("Dance"):Connect(v2))
	self.Collector:Add(task.spawn(v2))
	local function v3()
		-- upvalues: (copy) self, (copy) v_u_loadanimation, (copy) v_u_loadanimation, (copy) v_u_loadanimation, (copy) v_u_loadanimation
		if self.Instance:GetAttribute("GroundDance") then
			self.WalkTrack:Stop()
			self.IdleTrack:Stop()
			if not (v_u_loadanimation.IsPlaying or v_u_loadanimation.IsPlaying) then
				if v_u_loadanimation.IsPlaying then
					v_u_loadanimation:Stop()
				end
				v_u_loadanimation:Play()
				return
			end
		elseif v_u_loadanimation.IsPlaying or v_u_loadanimation.IsPlaying then
			if v_u_loadanimation.IsPlaying then
				v_u_loadanimation:Stop()
			end
			if v_u_loadanimation.IsPlaying then
				v_u_loadanimation:Stop()
			end
			v_u_loadanimation:Play()
			if self.Instance:GetAttribute("ForceIdle") then
				self.IdleTrack:Play()
				return
			end
			if not v_u_loadanimation.IsPlaying then
				self.WalkTrack:Play()
			end
		end
	end
	self.Collector:Add(self.Instance:GetAttributeChangedSignal("GroundDance"):Connect(v3))
	self.Collector:Add(task.spawn(v3))
end)
return {
	["Start"] = function()
		-- upvalues: (copy) v_u_contentprovider
		task.spawn(pcall, function()
			-- upvalues: (ref) v_u_contentprovider
			v_u_contentprovider:PreloadAsync(script:GetChildren())
		end)
	end
}