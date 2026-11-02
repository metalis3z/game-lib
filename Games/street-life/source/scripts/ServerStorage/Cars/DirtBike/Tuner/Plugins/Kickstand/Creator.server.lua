local bike = script.Parent.Parent.Parent.Parent

wait(1)
local P = Instance.new("Part", bike.Body.Kickstand)
P.BottomSurface = "Unjoinable"
P.Anchored = true
P.Name = "P"
P.Size = Vector3.new(0.2,0.2,0.2)
P.CustomPhysicalProperties = PhysicalProperties.new(0.01,0,0)
weld = Instance.new( "Motor" )
weld.MaxVelocity = .2
weld.Parent = P
weld.C0 = CFrame.new(Vector3.new(0,0,0))*CFrame.Angles(0,math.rad(-90),0)
weld.Part0 = P
weld.Part1 = bike.Body.Kickstand
local PMesh = Instance.new("CylinderMesh",P)
PMesh.Scale = Vector3.new(1,1,0.5)
P.Material = Enum.Material.SmoothPlastic
P.Color = Color3.new(9/255, 9/255, 9/255)
P.Reflectance = .1

local Stand = Instance.new("Part", P)
Stand.Anchored = true
Stand.CanCollide = false
Stand.Name = "Stand"
Stand.Size = Vector3.new(0.2,.8,0.2)
Stand.CustomPhysicalProperties = PhysicalProperties.new(0.01,0,0)
weld2 = Instance.new( "Weld" )
weld2.Parent = Stand
weld2.C0 = CFrame.new( Vector3.new( 0 , 0.3 , 0 ) )
weld2.Part0 = Stand
weld2.Part1 = P
local StandMesh = Instance.new("CylinderMesh",Stand)
StandMesh.Scale = Vector3.new(1,1,0.5)
Stand.Material = Enum.Material.SmoothPlastic
Stand.Color = Color3.new(9/255, 9/255, 9/255)
Stand.Reflectance = .1

local Foot = Instance.new("Part", Stand)
Foot.Anchored = true
Foot.CanCollide = false
Foot.Name = "Foot"
Foot.Size = Vector3.new(0.4,.2,0.4)
Foot.CustomPhysicalProperties = PhysicalProperties.new(0.01,0,0)
weld3 = Instance.new( "Weld" )
weld3.Parent = Foot
weld3.C0 = CFrame.new( Vector3.new( 0.25 , 0.25 , 0 ) )*CFrame.Angles(0,0,math.rad(-30))
weld3.Part0 = Foot
weld3.Part1 = Stand
local FootMesh = Instance.new("BlockMesh",Foot)
FootMesh.Offset = Vector3.new(0,-0.1,0)
FootMesh.Scale = Vector3.new(0.7,0.2,0.3)
Foot.Material = Enum.Material.SmoothPlastic
Foot.Color = Color3.new(9/255, 9/255, 9/255)
Foot.Reflectance = .1

local Down = Instance.new("BodyGyro", Foot)
Down.P = 0
Down.D = 0
Down.MaxTorque = Vector3.new(0,0,0)

P.Anchored = false
Stand.Anchored = false
Foot.Anchored = false
script:Destroy()