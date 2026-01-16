local Players = game:GetService("Players")
local player = Players.LocalPlayer

repeat task.wait() until player:FindFirstChild("PlayerGui")

-- Crear GUI
local gui = Instance.new("ScreenGui")
gui.Name = "StageChanger"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,220,0,120)
frame.Position = UDim2.new(0.5, -110, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(45,45,45)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- TextBox Stage
local stageBox = Instance.new("TextBox")
stageBox.Size = UDim2.new(1, -20, 0, 40)
stageBox.Position = UDim2.new(0, 10, 0, 10)
stageBox.PlaceholderText = "Escoge Stage 1 - 19"
stageBox.Text = "" -- quitar cualquier texto predeterminado
stageBox.TextScaled = true
stageBox.BackgroundColor3 = Color3.fromRGB(80,80,80)
stageBox.TextColor3 = Color3.fromRGB(255,255,255)
stageBox.ClearTextOnFocus = false
stageBox.Parent = frame

-- Botón IR
local goButton = Instance.new("TextButton")
goButton.Size = UDim2.new(1, -20, 0, 40)
goButton.Position = UDim2.new(0, 10, 0, 60)
goButton.Text = "IR (Reiniciar)"
goButton.TextScaled = true
goButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
goButton.TextColor3 = Color3.new(1,1,1)
goButton.Parent = frame

-- Mensaje flotante
local function showMessage(text)
    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1,0,0,30)
    msg.Position = UDim2.new(0,0,1,0)
    msg.BackgroundTransparency = 0.5
    msg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    msg.TextColor3 = Color3.fromRGB(255,255,255)
    msg.TextScaled = true
    msg.Text = text
    msg.Parent = frame

    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = tweenService:Create(msg, tweenInfo, {Position = UDim2.new(0,0,0, -35), TextTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function() msg:Destroy() end)
end

-- Función para actualizar el stage
local function updateStage()
    local num = tonumber(stageBox.Text)
    if num and num >=1 and num <=19 then
        local stageValue
        if player:FindFirstChild("stage") then
            stageValue = player.stage
        elseif player:FindFirstChild("Stage") then
            stageValue = player.Stage
        elseif player:FindFirstChild("leaderstats") then
            stageValue = player.leaderstats:FindFirstChild("Stage")
        end

        if stageValue then
            stageValue.Value = num
            showMessage("Stage cambiado a "..num)
        end
    end
end

-- Actualizar automáticamente al escribir solo números
stageBox:GetPropertyChangedSignal("Text"):Connect(function()
    stageBox.Text = stageBox.Text:gsub("%D","")
    updateStage()
end)

-- Botón IR reinicia el personaje
goButton.MouseButton1Click:Connect(function()
    if player.Character then
        player.Character:BreakJoints()
    end
end)
