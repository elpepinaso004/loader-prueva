-- Pepinasoi Loader - Versión Premium Green Style
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Limpiar versiones anteriores si existen
if playerGui:FindFirstChild("PepinasoiLoaderGui") then
    playerGui.PepinasoiLoaderGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PepinasoiLoaderGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame Principal
local navFrame = Instance.new("Frame")
navFrame.Name = "MainFrame"
navFrame.Size = UDim2.new(0, 420, 0, 320)
navFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
navFrame.BackgroundColor3 = Color3.fromRGB(15, 30, 15) -- Fondo ultra oscuro
navFrame.BorderSizePixel = 0
navFrame.ClipsDescendants = true
navFrame.Parent = screenGui

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 12)
navCorner.Parent = navFrame

-- Borde de Neón
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(40, 180, 80)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = navFrame

-- Barra de Título
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 60, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = navFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "PEPINASOI LOADER"
titleLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Botón Minimizar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 35, 0, 30)
minimizeButton.Position = UDim2.new(1, -45, 0.5, -15)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 20
minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 100, 50)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeButton

-- Contenedor de Botones
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = navFrame

-- Paginación y Variables
local allButtons = {}
local scriptsPerPage = 5
local currentPage = 1

-- Botones de Navegación Inferiores
local prevButton = Instance.new("TextButton")
prevButton.Size = UDim2.new(0, 40, 0, 35)
prevButton.Position = UDim2.new(0.05, 0, 0.85, 0)
prevButton.Text = "<"
prevButton.BackgroundColor3 = Color3.fromRGB(30, 80, 40)
prevButton.TextColor3 = Color3.new(1,1,1)
prevButton.Font = Enum.Font.GothamBold
prevButton.Parent = contentFrame

local nextButton = Instance.new("TextButton")
nextButton.Size = UDim2.new(0, 40, 0, 35)
nextButton.Position = UDim2.new(0.85, 0, 0.85, 0)
nextButton.Text = ">"
nextButton.BackgroundColor3 = Color3.fromRGB(30, 80, 40)
nextButton.TextColor3 = Color3.new(1,1,1)
nextButton.Font = Enum.Font.GothamBold
nextButton.Parent = contentFrame

local pageLabel = Instance.new("TextLabel")
pageLabel.Size = UDim2.new(0, 100, 0, 35)
pageLabel.Position = UDim2.new(0.5, -50, 0.85, 0)
pageLabel.BackgroundTransparency = 1
pageLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
pageLabel.Text = "1/1"
pageLabel.Font = Enum.Font.GothamBold
pageLabel.TextSize = 16
pageLabel.Parent = contentFrame

-- Función para actualizar la vista
local function UpdatePage()
    local maxPage = math.ceil(#allButtons / scriptsPerPage)
    if maxPage == 0 then maxPage = 1 end
    currentPage = math.clamp(currentPage, 1, maxPage)
    
    pageLabel.Text = currentPage .. " / " .. maxPage

    for i, btn in ipairs(allButtons) do
        local startRange = (currentPage - 1) * scriptsPerPage + 1
        local endRange = currentPage * scriptsPerPage
        
        if i >= startRange and i <= endRange then
            btn.Visible = true
            btn.Position = UDim2.new(0.1, 0, 0, ((i - startRange) * 45) + 15)
        else
            btn.Visible = false
        end
    end
end

-- Función para Crear Botones de Script
local function AddScript(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35, 110, 55)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = contentFrame
    btn.Visible = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    -- Efectos Hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 180, 80)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 110, 55)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        btn.Text = "¡EJECUTADO!"
        task.wait(0.5)
        btn.Text = name
        callback()
    end)

    table.insert(allButtons, btn)
    UpdatePage()
end

-- Controles de Navegación
prevButton.MouseButton1Click:Connect(function()
    currentPage = currentPage - 1
    UpdatePage()
end)

nextButton.MouseButton1Click:Connect(function()
    currentPage = currentPage + 1
    UpdatePage()
end)

-- Dragging (Arrastrar GUI)
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = navFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        navFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Minimizar
local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        contentFrame.Visible = false
        navFrame:TweenSize(UDim2.new(0, 420, 0, 40), "Out", "Quad", 0.3, true)
        minimizeButton.Text = "+"
    else
        navFrame:TweenSize(UDim2.new(0, 420, 0, 320), "Out", "Quad", 0.3, true)
        task.wait(0.3)
        contentFrame.Visible = true
        minimizeButton.Text = "-"
    end
end)

-- Añade aquí tus scripts con nombre y función
AddScript("SpeedHub X", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
end)

AddScript("Infinite Yield (Admin)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

AddScript("God Mode", function()
    print("Activando God Mode...")
end)

AddScript("Fly Script", function()
    print("Activando Vuelo...")
end)

AddScript("Noclip", function()
    print("Noclip Activado")
end)

AddScript("ESP Players", function()
    print("ESP Cargado")
end)

AddScript("Teleport Tools", function()
    print("TP Tools")
end)

AddScript("Auto-Farm", function()
    print("Farm iniciado")
end)

-- Inicializar primera vista
UpdatePage()
