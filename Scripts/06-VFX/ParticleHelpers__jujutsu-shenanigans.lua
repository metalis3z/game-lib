-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ReplicatedStorage/Modules/Utility/Particles.lua  (ModuleScript, 63 lines)
-- What it does: Small helpers: highest particle lifetime under a part (for cleanup timing), emit all by EmitCount, toggle emitters/beams/trails, scale lifetimes, tween a Model's scale.

local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')

return {
	GetHLF = function(Part: Part?): number
		local HighestLifetime = 0
		for _,v in Part:GetDescendants() do
			if v:IsA('ParticleEmitter') and v.Lifetime.Max > HighestLifetime then
				HighestLifetime = v.Lifetime.Max
			end
		end
		
		return HighestLifetime
	end,
	
	Emit = function(Part: Part?)
		if Part:IsA('ParticleEmitter') then
			Part:Emit(Part:GetAttribute('EmitCount'))
		else
			for _,v in Part:GetDescendants() do
				if v:IsA('ParticleEmitter') then
					v:Emit(v:GetAttribute('EmitCount'))
				end
			end
		end
	end,
	
	Enabled = function(Part: Part?, State: boolean)
		for _,v in Part:GetDescendants() do
			if v:IsA('ParticleEmitter') or v:IsA('Beam') then
				v.Enabled = State
			end
		end
	end,
	
	EnableTrail = function(Part: Part?, State: boolean)
		for _,v in Part:GetDescendants() do
			if v:IsA('Trail') then
				v.Enabled = State
			end
		end
	end,
	
	scaleLifetime = function(Part: Part?, newScale: number)
		for _, Particle in Part:GetDescendants() do
			if Particle:IsA("ParticleEmitter") then
				Particle.Lifetime = NumberRange.new(Particle.Lifetime.Min * newScale, Particle.Lifetime.Max * newScale)
			end
		end
	end,
	
	tweenScale = function(Model: Model, Parameters: { startScale: number?, goalScale: number, Info: TweenInfo })
		local scaleValue = Instance.new('NumberValue')
		scaleValue.Value = Parameters.startScale or Model:GetScale()
		scaleValue:GetPropertyChangedSignal('Value'):Connect(function()
			Model:ScaleTo(scaleValue.Value)
		end)
		
		TS:Create(scaleValue, Parameters.Info, { Value = Parameters.goalScale }):Play()
		
		Debris:AddItem(scaleValue, Parameters.Info.Time)
	end,
}
