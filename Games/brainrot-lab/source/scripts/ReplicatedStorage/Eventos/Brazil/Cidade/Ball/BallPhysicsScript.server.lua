local ball = script.Parent

-- Garante que a bola tem colisão e física
ball.CanCollide = true
ball.Anchored = false

-- Propriedades físicas para quicar bem (alta elasticidade)
ball.CustomPhysicalProperties = PhysicalProperties.new(0.3, 0.9, 0.5)

-- Debounce para não disparar o pulo repetidamente
local debounce = false

-- Força do pulo
local JUMP_FORCE = 80
local HORIZONTAL_FORCE = 60

ball.Touched:Connect(function(otherPart)
    -- Ignora se a bola se tocar com ela mesma
    if otherPart == ball then return end

    if not debounce then
        debounce = true

        -- Direção horizontal aleatória para a bola sair batendo em tudo
        local randomX = (math.random() - 0.5) * 2
        local randomZ = (math.random() - 0.5) * 2

        -- Aplica velocidade: pulo pra cima + direção horizontal aleatória
        ball.AssemblyLinearVelocity = Vector3.new(
            randomX * HORIZONTAL_FORCE,
            JUMP_FORCE,
            randomZ * HORIZONTAL_FORCE
        )

        -- Pequena rotação aleatória pra ficar mais caótico
        ball.AssemblyAngularVelocity = Vector3.new(
            (math.random() - 0.5) * 40,
            (math.random() - 0.5) * 40,
            (math.random() - 0.5) * 40
        )

        -- Cooldown curto para permitir múltiplos toques mas sem spam
        task.wait(0.2)
        debounce = false
    end
end)