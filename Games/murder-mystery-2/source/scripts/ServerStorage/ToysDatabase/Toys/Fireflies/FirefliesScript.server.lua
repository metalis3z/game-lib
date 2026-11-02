local Debris = game:GetService("Debris")

Tool = script.Parent
Handle = Tool.Handle
Lid = Tool.Lid
Particles = Handle.Fireflies
RemoteEvent = Tool:WaitForChild("RemoteEvent")
Light = Handle.PointLight
Sound = Handle:WaitForChild("Sound")

local LidWeld = Instance.new("Weld")
LidWeld.Parent = Handle
LidWeld.Part0 = Handle
LidWeld.Part1 = Lid
LidWeld.C1 = CFrame.new(0,-0.65,0)

FireflyNumber = 10

RemoteEvent.OnServerEvent:Connect(function()

Sound:Play()
wait(1.5)

Lid.Transparency = 1
Light.Enabled = false
Particles.Enabled = false

for i = 1, FireflyNumber do

local Fireflies = Instance.new("Part")
Fireflies.Size = Vector3.new(0.2,0.2,0.2)
Fireflies.Position = Vector3.new(Lid.Position.x, Lid.Position.Y, Lid.Position.Z)
Fireflies.Material = Enum.Material.Neon
Fireflies.BrickColor = BrickColor.new("Gold")
Fireflies.Parent = game.Workspace

local FireflyLlight = Instance.new("PointLight")
FireflyLlight.Color = Color3.fromHSV(0.166667, 0.501961, 1)
FireflyLlight.Brightness = 1
FireflyLlight.Range = 5
FireflyLlight.Shadows = true
FireflyLlight.Parent = Fireflies

local Force = Instance.new("BodyVelocity")
Force.Parent = Fireflies
Force.Velocity = Vector3.new(math.random(-1,1), 1, math.random(-1,1))
Force.MaxForce = Vector3.new(1,1,1)*10^2

local SpinNumber = math.random(-10,10)
local Spin = Instance.new("BodyAngularVelocity")
Spin.MaxTorque=Vector3.new(1,1,1)*10^2
Spin.AngularVelocity=Vector3.new(SpinNumber,SpinNumber,SpinNumber)
Spin.Parent = Fireflies

Debris:AddItem(Fireflies, math.random(20,30))

wait(1)
end

wait(1)

Lid.Transparency = 0
Light.Enabled = true
Particles.Enabled = true

end)