-- Variables y configuración inicial del frame de navegación
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NavigationGui"
screenGui.Parent = playerGui

local navFrame = Instance.new("Frame")
navFrame.Size = UDim2.new(1, 0, 0, 50)
navFrame.Position = UDim2.new(0, 0, 0, 0)
navFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
navFrame.Parent = screenGui

-- Botón para página anterior
local prevButton = Instance.new("TextButton")
prevButton.Size = UDim2.new(0.1, 0, 1, 0)
prevButton.Position = UDim2.new(0, 0, 0, 0)
prevButton.Text = "<"
prevButton.Font = Enum.Font.Gotham
prevButton.TextScaled = true
prevButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
prevButton.TextColor3 = Color3.fromRGB(200, 200, 200)
prevButton.Parent = navFrame

-- Botón para página siguiente
local nextButton = Instance.new("TextButton")
nextButton.Size = UDim2.new(0.1, 0, 1, 0)
nextButton.Position = UDim2.new(0.9, 0, 0, 0)
nextButton.Text = ">"
nextButton.Font = Enum.Font.Gotham
nextButton.TextScaled = true
nextButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
nextButton.Parent = navFrame

-- Decoración de esquinas redondeadas para nextButton
local nextCorner = Instance.new("UICorner")
nextCorner.Parent = nextButton

-- Etiqueta que muestra la página actual
local pageLabel = Instance.new("TextLabel")
pageLabel.Size = UDim2.new(0.1, 0, 1, 0)
pageLabel.Position = UDim2.new(0.45, 0, 0, 0)
pageLabel.BackgroundTransparency = 1
pageLabel.Text = "1/1"
pageLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
pageLabel.TextScaled = true
pageLabel.Font = Enum.Font.Gotham
pageLabel.Parent = navFrame

-- Variables para manejar las páginas y botones
local allButtons = {} -- Aquí se guardarán todos los botones creados
local scriptsPerPage = 5 -- Número de botones que se muestran por página
local currentPage = 1

-- Función para actualizar la visibilidad de los botones según la página actual
local function UpdatePage()
    local maxPage = math.ceil(#allButtons / scriptsPerPage)
    if maxPage == 0 then maxPage = 1 end

    -- Actualizar texto de la etiqueta de página
    pageLabel.Text = currentPage .. "/" .. maxPage

    -- Ocultar todos los botones primero
    for _, button in ipairs(allButtons) do
        button.Visible = false
    end

    -- Mostrar solo los botones correspondientes a la página actual
    local startIndex = (currentPage - 1) * scriptsPerPage + 1
    local endIndex = math.min(currentPage * scriptsPerPage, #allButtons)

    for i = startIndex, endIndex do
        allButtons[i].Visible = true
    end
end

-- Función para crear un botón con nombre y función callback
local function CreateButton(name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 50)
    button.Position = UDim2.new(0.1, 0, 0, (#allButtons * 55)) -- Separación vertical entre botones
    button.Text = name
    button.Font = Enum.Font.Gotham
    button.TextScaled = true
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Parent = navFrame
    button.Visible = false -- Inicialmente oculto, se mostrará según la página

    button.MouseButton1Click:Connect(callback)

    table.insert(allButtons, button)
end

-- Eventos para los botones de navegación
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

-- Creación de botones con sus funciones
CreateButton("SpeedHub", function()
    print("oh yeah el script se ejecuto osi osi")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)

CreateButton("God Mode", function()
    print("God Mode activado")
    -- Aquí puedes poner el código para activar God Mode
end)

CreateButton("Infinite Jump", function()
    print("Infinite Jump activado")
    -- Aquí puedes poner el código para activar salto infinito
end)

CreateButton("No Clip", function()
    print("No Clip activado")
    -- Aquí puedes poner el código para activar No Clip
end)

CreateButton("Teleport to Spawn", function()
    print("Teletransportado")
    -- Aquí puedes poner el código para teletransportar al spawn
end)

CreateButton("ESP Players", function()
    print("ESP activado")
    -- Aquí puedes poner el código para activar ESP
end)

CreateButton("Auto Farm", function()
    print("Auto Farm activado")
    -- Aquí puedes poner el código para activar Auto Farm
end)

CreateButton("Fly", function()
    print("Fly activado")
    -- Aquí puedes poner el código para activar vuelo
end)

-- Inicializar la primera página
UpdatePage()
