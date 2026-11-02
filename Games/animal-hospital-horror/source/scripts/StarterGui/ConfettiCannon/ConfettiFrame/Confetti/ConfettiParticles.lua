local CurrentCamera = game:GetService("Workspace").CurrentCamera
local t = { script:WaitForChild("SquareConfetti") }
local t2 = {
	Color3.fromRGB(0, 0, 0),
	Color3.fromRGB(0, 0, 0),
	Color3.fromRGB(0, 0, 0),
	Color3.fromRGB(0, 0, 0),
	Color3.fromRGB(0, 0, 0)
}
local t3 = {}

t3.__index = t3

local v1 = Vector2.new(0, 1)

function t3.setGravity(p1) --[[ setGravity | Line: 14 | Upvalues: v1 (ref) ]]
	v1 = p1
end
function t3.createParticle(p1, p2, p3, p4) --[[ createParticle | Line: 18 | Upvalues: t3 (copy), t2 (ref), t (copy) ]]
	local t4 = {}

	setmetatable(t4, t3)
	t2 = p4

	local X = p2.X

	if X < 0 then
		X = X * -1
	end

	local v2 = Vector2.new(p2.X, p2.Y + (0 - X) * 0.75)

	if p4 == nil then
		p4 = t2
	end

	t4.EmitterPosition = p1
	t4.EmitterPower = v2
	t4.Position = Vector2.new(0, 0)
	t4.Power = v2
	t4.Color = p4[math.random(#p4)]

	local function getParticle() --[[ getParticle | Line: 32 | Upvalues: t (ref), t4 (copy), p3 (copy) ]]
		local v1 = t[math.random(#t)]:Clone()

		v1.ImageColor3 = t4.Color
		v1.Parent = p3
		v1.Rotation = math.random(360)
		v1.Visible = true
		v1.ZIndex = 20

		return v1
	end

	local v3 = t[math.random(#t)]:Clone()

	v3.ImageColor3 = t4.Color
	v3.Parent = p3
	v3.Rotation = math.random(360)
	v3.Visible = true
	v3.ZIndex = 20
	t4.Label = v3
	t4.DefaultSize = 30
	t4.Size = 1
	t4.Side = -1
	t4.OutOfBounds = false
	t4.Enabled = false
	t4.Cycles = 0

	return t4
end
function t3.Update(p1, p2) --[[ Update | Line: 50 | Upvalues: t2 (ref), v1 (ref), CurrentCamera (copy) ]]
	if p1.Enabled and p1.OutOfBounds then
		p1.Label.ImageColor3 = p1.Color
		p1.Position = Vector2.new(0, 0)
		p1.Power = Vector2.new(p1.EmitterPower.X + math.random(10) - 5, p1.EmitterPower.Y + math.random(10) - 5)
		p1.Cycles = p1.Cycles + 1
	end

	if (p1.Enabled or not p1.OutOfBounds) and (p1.Enabled or p1.Cycles ~= 0) then
		p1.Label.Visible = true

		local EmitterPosition = p1.EmitterPosition
		local Position = p1.Position
		local Power = p1.Power
		local Label = p1.Label

		if not Label then
			return
		end

		local v12 = Vector2.new(Position.X - Power.X, Position.Y - Power.Y)
		local v2 = Vector2.new(Power.X / 1.09 - v1.X, Power.Y / 1.1 - v1.Y)
		local ViewportSize = CurrentCamera.ViewportSize

		Label.Position = UDim2.new(EmitterPosition.X, v12.X, EmitterPosition.Y, v12.Y)
		p1.OutOfBounds = if Label.AbsolutePosition.X > ViewportSize.X and v1.X > 0 or Label.AbsolutePosition.Y > ViewportSize.Y and v1.Y > 0 or Label.AbsolutePosition.X < 0 and v1.X < 0 then true elseif Label.AbsolutePosition.Y < 0 then if v1.Y < 0 then true else false else false
		p1.Position = v12
		p1.Power = v2

		if not (v2.Y < 0) then
			return
		end

		if p1.Size <= 0 then
			p1.Side = 1
			Label.ImageColor3 = p1.Color
		end

		if p1.Size >= p1.DefaultSize then
			p1.Side = -1
			Label.ImageColor3 = Color3.new(p1.Color.r * 0.65, p1.Color.g * 0.65, p1.Color.b * 0.65)
		end

		p1.Size = p1.Size + p1.Side * 2
		Label.Size = UDim2.new(0, p1.DefaultSize, 0, p1.Size)

		return
	end

	p1.Label.Visible = false
	p1.OutOfBounds = true
	p1.Color = t2[math.random(#t2)]
end
function t3.Toggle(p1) --[[ Toggle | Line: 98 ]]
	p1.Enabled = not p1.Enabled
end
function t3.SetColors(p1, p2) --[[ SetColors | Line: 102 | Upvalues: t2 (ref) ]]
	t2 = p2
end

return t3