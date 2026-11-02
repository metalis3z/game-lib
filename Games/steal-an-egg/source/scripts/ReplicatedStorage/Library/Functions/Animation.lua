-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

local function resolveAnimator(p1) --[[ resolveAnimator | Line: 7 ]]
	if p1:IsA("Animator") then
		return p1
	end

	if p1:IsA("Player") then
		local Character = p1.Character

		if Character then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				local Animator = Humanoid:FindFirstChildOfClass("Animator")

				if Animator then
					return Animator
				end
			end

			local AnimationController = Character:FindFirstChildOfClass("AnimationController")

			if AnimationController then
				local Animator = AnimationController:FindFirstChildOfClass("Animator")

				if Animator then
					return Animator
				end
			end
		end
	end

	if p1:IsA("Humanoid") then
		local Animator = p1:FindFirstChildOfClass("Animator")

		assert(Animator ~= nil, (("Missing Animator under %*"):format((p1:GetFullName()))))

		return Animator
	end

	if p1:IsA("AnimationController") then
		local Animator = p1:FindFirstChildOfClass("Animator")

		assert(Animator ~= nil, (("Missing Animator under %*"):format((p1:GetFullName()))))

		return Animator
	end

	local Animator = p1:FindFirstChildOfClass("Animator")

	if Animator then
		return Animator
	end

	local AnimationController = p1:FindFirstChildOfClass("AnimationController")

	if not AnimationController then
		error("No way to animate!")
	end

	local Animator2 = AnimationController:FindFirstChildOfClass("Animator")

	assert(Animator2 ~= nil, (("Missing Animator under %*"):format((AnimationController:GetFullName()))))

	return Animator2
end

function t.ResolveAnimatorFromModel(p1, p2) --[[ ResolveAnimatorFromModel | Line: 60 ]]
	local v1

	if p2 == nil then
		v1 = p1
	else
		local v2 = p1:WaitForChild(p2)
		local v3 = v2:IsA("Model")

		assert(v3, (("Animation target child \"%*\" must be a Model"):format(p2)))
		v1 = v2
	end

	local AnimationController = v1:WaitForChild("AnimationController")
	local v5 = AnimationController:IsA("AnimationController")

	assert(v5, (("Missing AnimationController under %*"):format((v1:GetFullName()))))

	local Animator = AnimationController:WaitForChild("Animator")
	local v7 = Animator:IsA("Animator")

	assert(v7, (("Missing Animator under %*"):format((AnimationController:GetFullName()))))

	return Animator
end
function t.ResolveOptionalAnimatorFromModel(p1, p2) --[[ ResolveOptionalAnimatorFromModel | Line: 79 ]]
	local v1

	if p2 == nil then
		v1 = p1
	else
		local v2 = p1:FindFirstChild(p2)

		if v2 == nil then
			return nil
		end

		local v3 = v2:IsA("Model")

		assert(v3, (("Animation target child \"%*\" must be a Model"):format(p2)))
		v1 = v2
	end

	local AnimationController = v1:FindFirstChild("AnimationController")

	if AnimationController == nil then
		return nil
	end

	assert(AnimationController:IsA("AnimationController"), (("Missing AnimationController under %*"):format((v1:GetFullName()))))

	local Animator = AnimationController:FindFirstChild("Animator")

	if Animator == nil then
		return nil
	end

	assert(Animator:IsA("Animator"), (("Missing Animator under %*"):format((AnimationController:GetFullName()))))

	return Animator
end
t.ResolveAnimator = resolveAnimator
function t.Play(p1, p2, p3, p4, p5, p6) --[[ Play | Line: 112 | Upvalues: resolveAnimator (copy) ]]
	local v2 = resolveAnimator(p2)
	local v3

	if typeof(p1) == "number" or typeof(p1) == "string" then
		local Animation = Instance.new("Animation")
		local v4

		if typeof(p1) == "string" and p1 then
			v3 = Animation
			v4 = p1
		else
			v4 = "rbxassetid://" .. tostring(p1)
			v3 = Animation
		end

		v3.AnimationId = v4
	else
		v3 = p1
	end

	local v5 = v2:LoadAnimation(v3)

	if p4 ~= nil then
		v5.Looped = p4 == true
	end

	v5:Play(p5, p6, p3 or 1)

	return v5
end

return setmetatable(t, {
	__call = function(p1, ...) --[[ __call | Line: 140 | Upvalues: t (copy) ]]
		return t.Play(...)
	end
})