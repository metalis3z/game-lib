function onTouched(part)

	local h = part.Parent:findFirstChild("Humanoid")

	if h~=nil then

wait(2)
h.WalkSpeed = 18
h.Health = 90

wait(2)
h.WalkSpeed = 18
h.Health = 85

wait(2)
h.WalkSpeed = 18
h.Health = 80

wait(2)
h.WalkSpeed = 15
h.Health = 75

wait(2)
h.WalkSpeed = 15
h.Health = 70

wait(2)
h.WalkSpeed = 15
h.Health = 65

wait(2)
h.WalkSpeed = 12
h.Health = 60

wait(2)
h.WalkSpeed = 12
h.Health = 55

wait(2)
h.WalkSpeed = 12
h.Health = 50

wait(2)
h.WalkSpeed = 9
h.Health = 45

wait(2)
h.WalkSpeed = 9
h.Health = 40

wait(2)
h.WalkSpeed = 9
h.Health = 35

wait(2)
h.WalkSpeed = 6
h.Health = 30

wait(2)
h.WalkSpeed = 6
h.Health = 25

wait(2)
h.WalkSpeed = 6
h.Health = 20

wait(2)
h.WalkSpeed = 0
h.Health = 15

wait(2)
h.WalkSpeed = 0
h.Health = 10

wait(2)
h.WalkSpeed = 0
h.Health = 5

wait(2)
h.WalkSpeed = 0
h.Health = 0


	end

	end






script.Parent.Touched:connect(onTouched)
