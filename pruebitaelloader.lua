-- Script completo para GUI movible y minimizable con paginación y botones funcionales

local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHubGui"
screenGui.Parent = playerGui

local navFrame = Instance.new("Frame")
navFrame.Size = UDim2.new(0, 400, 0, 300)
navFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
navFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
navFrame.BorderSizePixel = 0
navFrame.Parent = screenGui

-- Barra superior para mover y minimizar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.Parent = navFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Script Hub"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Font = Enum.Font.Gotham
titleLabel.TextScaled = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 1, 0)
minimizeButton.Position = UDim2.new(0.9, 0, 0, 0)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.TextScaled = true
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeButton.Parent = titleBar

-- Contenedor para botones y etiqueta de página
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = navFrame

-- Botón página anterior
local prevButton = Instance.new("TextButton")
prevButton.Size = UDim2.new(0.1, 0, 0, 40)
prevButton.Position = UDim2.new(0, 10, 1, -50)
prevButton.Text = "<"
prevButton.Font = Enum.Font.Gotham
prevButton.TextScaled = true
prevButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
prevButton.TextColor3 = Color3.fromRGB(200, 200, 200)
prevButton.Parent = contentFrame

-- Botón página siguiente
local nextButton = Instance.new("TextButton")
nextButton.Size = UDim2.new(0.1, 0, 0, 40)
nextButton.Position = UDim2.new(0.9, -40, 1, -50)
nextButton.Text = ">"
nextButton.Font = Enum.Font.Gotham
nextButton.TextScaled = true
nextButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
nextButton.Parent = contentFrame

local nextCorner = Instance.new("UICorner")
nextCorner.Parent = nextButton

-- Etiqueta página actual
local pageLabel = Instance.new("TextLabel")
pageLabel.Size = UDim2.new(0.2, 0, 0, 40)
pageLabel.Position = UDim2.new(0.4, 0, 1, -50)
pageLabel.BackgroundTransparency = 1
pageLabel.Text = "1/1"
pageLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
pageLabel.TextScaled = true
pageLabel.Font = Enum.Font.Gotham
pageLabel.Parent = contentFrame

-- Variables para paginación y botones
local allButtons = {}
local scriptsPerPage = 5
local currentPage = 1

-- Función para actualizar botones visibles según página
local function UpdatePage()
    local maxPage = math.ceil(#allButtons / scriptsPerPage)
    if maxPage == 0 then maxPage = 1 end

    pageLabel.Text = currentPage .. "/" .. maxPage

    for _, button in ipairs(allButtons) do
        button.Visible = false
    end

    local startIndex = (currentPage - 1) * scriptsPerPage + 1
    local endIndex = math.min(currentPage * scriptsPerPage, #allButtons)

    for i = startIndex, endIndex do
        allButtons[i].Visible = true
    end
end

-- Función para crear botones con callback
local function CreateButton(name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, (#allButtons * 45))
    button.Text = name
    button.Font = Enum.Font.Gotham
    button.TextScaled = true
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Parent = contentFrame
    button.Visible = false

    button.MouseButton1Click:Connect(callback)

    table.insert(allButtons, button)
end

-- Eventos para botones de navegación
prevButton.MouseButton1Click:Connect(function()
    if currentPage > 1 then
        currentPage = currentPage - 1
        UpdatePage()
    end
end)

nextButton.MouseButton1Click:Connect(function()
    local maxPage = math.ceil(#allButtons / scriptsPerPage)
    if currentPage < maxPage then
        currentPage = currentPage + 1
        UpdatePage()
    end
end)

-- Funcionalidad minimizar/maximizar
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        contentFrame.Visible = false
        navFrame.Size = UDim2.new(0, 400, 0, 30)
        minimizeButton.Text = "+"
    else
        contentFrame.Visible = true
        navFrame.Size = UDim2.new(0, 400, 0, 300)
        minimizeButton.Text = "-"
    end
end)

-- Funcionalidad para mover el GUI
local dragging = false
local dragInput
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = navFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        navFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Creación de botones con sus funciones
CreateButton("SpeedHub", function()
    print("oh yeah el script se ejecuto osi osi")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)

CreateButton("God Mode", function()
    print("God Mode activado")
    -- Código para God Mode aquí
end)

CreateButton("Infinite Jump", function()
    print("Infinite Jump activado")
    -- Código para salto infinito aquí
end)

CreateButton("No Clip", function()
    print("No Clip activado")
    -- Código para No Clip aquí
end)

CreateButton("Teleport to Spawn", function()
    print("Teletransportado")
    -- Código para teletransportar aquí
end)

CreateButton("ESP Players", function()
    print("ESP activado")
    -- Código para ESP aquí
end)

CreateButton("Auto Farm", function()
    print("Auto Farm activado")
    -- Código para Auto Farm aquí
end)

CreateButton("Fly", function()
    print("Fly activado")
    -- Código para vuelo aquí
end)

-- Inicializar la primera página
UpdatePage()
