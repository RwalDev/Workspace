-- leaked by pookiepepelss on discord
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local LocalPlayer = Players.LocalPlayer
local Novo = {}
Novo.Guis = {}

do
local Theme = {
	Panel        = Color3.fromRGB(23, 23, 26),
	PanelDeep    = Color3.fromRGB(15, 15, 17),
	Raise        = Color3.fromRGB(29, 29, 33),
	Divider      = Color3.fromRGB(44, 44, 50),
	Track        = Color3.fromRGB(47, 47, 47),

	Stroke       = Color3.fromRGB(55, 55, 61),
	StrokeSoft   = Color3.fromRGB(60, 60, 68),
	StrokeNav    = Color3.fromRGB(40, 40, 46),
	StrokeDot    = Color3.fromRGB(24, 24, 28),

	Text         = Color3.fromRGB(244, 244, 246),
	TextBright   = Color3.fromRGB(255, 255, 255),
	TextMuted    = Color3.fromRGB(156, 156, 166),
	TextDim      = Color3.fromRGB(180, 180, 180),
	TextFaint    = Color3.fromRGB(205, 205, 212),

	Accent       = Color3.fromRGB(52, 116, 204),
	AccentLight  = Color3.fromRGB(76, 143, 230),
	AccentDark   = Color3.fromRGB(35, 82, 153),
	AccentDeep   = Color3.fromRGB(41, 90, 159),
	Good         = Color3.fromRGB(64, 200, 120),

	R_Panel      = UDim.new(0, 14),
	R_Card       = UDim.new(0, 12),
	R_Button     = UDim.new(0, 10),
	R_Nav        = UDim.new(0, 8),
	R_Pill       = UDim.new(1, 0),

	T_Overlay    = 0.38,
	T_Stroke     = 0.45,
	T_StrokeSoft = 0.70,
	T_StrokeNav  = 0.72,
	T_Card       = 0.85,

	Wallpaper    = "rbxassetid://84947831307834",
	Shadow       = "rbxassetid://6014261993",
	ShadowSlice  = Rect.new(49, 49, 450, 450),
}

local function gotham(weight)
	return Font.new("rbxasset://fonts/families/GothamSSm.json", weight, Enum.FontStyle.Normal)
end

Theme.Font = {
	Regular  = gotham(Enum.FontWeight.Regular),
	Medium   = gotham(Enum.FontWeight.Medium),
	SemiBold = gotham(Enum.FontWeight.SemiBold),
	Bold     = gotham(Enum.FontWeight.Bold),
}

Theme.Icon = {
	Home      = "rbxassetid://127423679155445",
	Commands  = "rbxassetid://80224450231681",
	Players   = "rbxassetid://90813744897378",
	Music     = "rbxassetid://122449170161975",
	Scripts   = "rbxassetid://116337355510336",
	Settings  = "rbxassetid://127213529537158",
	Plus      = "rbxassetid://91305247413991",
	Close     = "rbxassetid://124858252806023",
	Minimize  = "rbxassetid://136052598813918",
	Resize    = "rbxassetid://132772681347890",
	Cross     = "rbxassetid://82927197777156",
	Fab       = "rbxassetid://137047199953006",
}

Novo.Theme = Theme
end

do
local Util = {}

function Util.new(class, props, children)
	local inst = Instance.new(class)
	local parent = nil
	for k, v in pairs(props or {}) do
		if k == "Parent" then
			parent = v
		else
			inst[k] = v
		end
	end
	for _, child in ipairs(children or {}) do
		child.Parent = inst
	end
	inst.Parent = parent
	return inst
end

local new = Util.new

function Util.corner(radius, parent)
	return new("UICorner", { CornerRadius = radius, Parent = parent })
end

function Util.stroke(color, thickness, transparency, mode, parent)
	return new("UIStroke", {
		Color = color,
		Thickness = thickness,
		Transparency = transparency,
		ApplyStrokeMode = mode or Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Round,
		Parent = parent,
	})
end

function Util.padding(t, b, l, r, parent)
	return new("UIPadding", {
		PaddingTop = UDim.new(0, t),
		PaddingBottom = UDim.new(0, b),
		PaddingLeft = UDim.new(0, l),
		PaddingRight = UDim.new(0, r),
		Parent = parent,
	})
end

function Util.list(dir, pad, halign, valign, parent)
	return new("UIListLayout", {
		FillDirection = dir,
		Padding = UDim.new(0, pad),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = halign or Enum.HorizontalAlignment.Left,
		VerticalAlignment = valign or Enum.VerticalAlignment.Top,
		Parent = parent,
	})
end

function Util.surfaceShine(parent, height, radius, fillTransparency, keypoints, zindex)
	local group = new("CanvasGroup", {
		Size = typeof(height) == "UDim2" and height or UDim2.new(1, 0, 0, height),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = zindex or 40,
		Name = "SurfaceShine",
		Parent = parent,
	})
	Util.corner(radius, group)
	local fill = new("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = fillTransparency,
		BorderSizePixel = 0,
		Name = "Fill",
		Parent = group,
	})
	new("UIGradient", {
		Color = ColorSequence.new(Color3.new(1, 1, 1)),
		Transparency = NumberSequence.new(keypoints),
		Rotation = 90,
		Parent = fill,
	})
	return group
end

function Util.frostedBacking(parent, radius, overlayTransparency)
	local wall = new("ImageLabel", {
		Name = "Wallpaper",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = Novo.Theme.Wallpaper,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 1,
		Parent = parent,
	})
	Util.corner(radius, wall)
	local wash = new("Frame", {
		Name = "WpOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Novo.Theme.PanelDeep,
		BackgroundTransparency = overlayTransparency or Novo.Theme.T_Overlay,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = parent,
	})
	Util.corner(radius, wash)
	return wall, wash
end

Util.Motion = {
	Snap   = TweenInfo.new(0.16, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out),
	Quick  = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	Glide  = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	Settle = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
}

function Util.tween(inst, info, goal)
	local t = TweenService:Create(inst, info, goal)
	t:Play()
	return t
end

local function pointInside(inst, x, y)
	local pos, size = inst.AbsolutePosition, inst.AbsoluteSize
	return x >= pos.X and x <= pos.X + size.X
		and y >= pos.Y and y <= pos.Y + size.Y
end

local function overGrabBlocker(handle, x, y)
	for _, d in ipairs(handle:GetDescendants()) do
		if (d:IsA("ScrollingFrame") or d:IsA("TextBox")) and d.Visible then
			if pointInside(d, x, y) then
				return true
			end
		end
	end
	return false
end

function Util.draggable(handle, target)
	local dragging, startPos, startInput = false, nil, nil

	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if overGrabBlocker(handle, input.Position.X, input.Position.Y) then return end
		dragging = true
		startPos = target.Position
		startInput = input.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local delta = input.Position - startInput
		target.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end)
end

Novo.Util = Util
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local Window = {}
Novo.Window = Window
Novo.Pages = {}

local TABS = {
	{ id = "Home",      icon = Theme.Icon.Home,     size = 44 },
	{ id = "Commands",  icon = Theme.Icon.Commands, size = 26 },
	{ id = "Playerlist",icon = Theme.Icon.Players,  size = 26 },
	{ id = "Music",     icon = Theme.Icon.Music,    size = 26 },
	{ id = "Scripts",   icon = Theme.Icon.Scripts,  size = 26 },
	{ id = "Settings",  icon = Theme.Icon.Settings, size = 26 },
	{ id = "Plus",      icon = Theme.Icon.Plus,     size = 26 },
}

local MASK_SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local ICON_FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

function Window.build()
	local screen = new("ScreenGui", {
		Name = "NovoMain",
		DisplayOrder = 55,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	Novo.Guis[#Novo.Guis + 1] = screen

	local wrap = new("Frame", {
		Name = "Wrap",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(570, 418),
		BackgroundTransparency = 1,
		ZIndex = 11,
		Parent = screen,
	})
	local wrapScale = new("UIScale", { Scale = 1, Parent = wrap })

	local panel = new("Frame", {
		Name = "ContentPanel",
		Size = UDim2.fromOffset(570, 350),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 12,
		Parent = wrap,
	})
	Util.corner(Theme.R_Panel, panel)
	Util.surfaceShine(panel, 28, Theme.R_Panel, 0.88,
		{
			NumberSequenceKeypoint.new(0, 0.14),
			NumberSequenceKeypoint.new(0.30, 0.62),
			NumberSequenceKeypoint.new(0.62, 0.94),
			NumberSequenceKeypoint.new(1, 1),
		}, 40)

	local area = new("Frame", {
		Name = "ContentArea",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 16,
		Parent = panel,
	})

	local tabBg = new("ImageLabel", {
		Name = "GlobalTabBg",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Image = Theme.Wallpaper,
		ScaleType = Enum.ScaleType.Crop,
		Visible = false,
		ZIndex = 13,
		Parent = panel,
	})
	Util.corner(Theme.R_Panel, tabBg)

	local tabOverlay = new("Frame", {
		Name = "GlobalTabOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = Theme.T_Overlay,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = panel,
	})
	Util.corner(Theme.R_Panel, tabOverlay)

	local nav = new("Frame", {
		Name = "Navbar",
		Position = UDim2.new(0.5, 0, 0, 360),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.fromOffset(420, 56),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
		ZIndex = 50,
		Parent = wrap,
	})
	Util.corner(Theme.R_Nav, nav)
	local navStroke = Util.stroke(Theme.StrokeNav, 1, Theme.T_StrokeNav, Enum.ApplyStrokeMode.Border, nav)
	navStroke.Name = "NavStroke"
	Util.frostedBacking(nav, Theme.R_Nav, Theme.T_Overlay)

	local navShine = Util.surfaceShine(nav, UDim2.fromScale(1, 1), Theme.R_Nav, 0.92,
		{
			NumberSequenceKeypoint.new(0, 0.16),
			NumberSequenceKeypoint.new(0.42, 0.72),
			NumberSequenceKeypoint.new(1, 1),
		}, 51)
	navShine.Fill.Size = UDim2.new(1, 0, 0, 6)

	new("ImageLabel", {
		Name = "Dropshadow",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, 40, 1, 40),
		BackgroundTransparency = 1,
		Image = Theme.Shadow,
		ImageColor3 = Color3.new(0, 0, 0),
		ImageTransparency = 0.75,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Theme.ShadowSlice,
		ZIndex = 48,
		Parent = nav,
	})

	local mask = new("Frame", {
		Name = "NavMask",
		Size = UDim2.fromOffset(60, 56),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 51,
		Parent = nav,
	})
	local maskFill = new("Frame", {
		Size = UDim2.fromOffset(420, 56),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.95,
		BorderSizePixel = 0,
		ZIndex = 51,
		Parent = mask,
	})
	Util.corner(Theme.R_Nav, maskFill)

	local buttons = new("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 52,
		Parent = nav,
	})

	local icons = {}
	for i, tab in ipairs(TABS) do
		local btn = new("TextButton", {
			Position = UDim2.fromOffset((i - 1) * 60, 0),
			Size = UDim2.fromOffset(60, 56),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = true,
			ZIndex = 53,
			Parent = buttons,
		})
		local icon = new("ImageLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(tab.size, tab.size),
			BackgroundTransparency = 1,
			Image = tab.icon,
			ImageColor3 = Theme.TextDim,
			ImageTransparency = 0.75,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 54,
			Parent = btn,
		})
		icons[i] = icon
		btn.MouseButton1Click:Connect(function()
			Window.select(i)
		end)
	end

	Util.draggable(panel, wrap)
	Util.draggable(nav, wrap)

	Window.screen = screen
	Window.wrap = wrap
	Window.scale = wrapScale
	Window.panel = panel
	Window.area = area
	Window.tabBg = tabBg
	Window.tabOverlay = tabOverlay
	Window.nav = nav
	Window.mask = mask
	Window.maskFill = maskFill
	Window.icons = icons
	Window.tabs = TABS
	Window.current = nil
	Window.pageCache = {}

	Window.select(1, true)
	return screen
end

function Window.select(index, instant)
	if Window.current == index then return end
	local prev = Window.current
	Window.current = index

	local maskGoal = UDim2.fromOffset((index - 1) * 60, 0)
	local fillGoal = UDim2.fromOffset(-(index - 1) * 60, 0)
	if instant then
		Window.mask.Position = maskGoal
		Window.maskFill.Position = fillGoal
	else
		Util.tween(Window.mask, MASK_SLIDE, { Position = maskGoal })
		Util.tween(Window.maskFill, MASK_SLIDE, { Position = fillGoal })
	end

	for i, icon in ipairs(Window.icons) do
		local on = (i == index)
		local goal = {
			ImageTransparency = on and 0 or 0.75,
			ImageColor3 = on and Theme.TextBright or Theme.TextDim,
		}
		if instant then
			icon.ImageTransparency = goal.ImageTransparency
			icon.ImageColor3 = goal.ImageColor3
		else
			Util.tween(icon, ICON_FADE, goal)
		end
	end

	local isHome = (index == 1)
	Window.tabBg.Visible = not isHome
	Window.tabOverlay.Visible = not isHome

	if prev and Window.pageCache[prev] then
		Window.pageCache[prev].Visible = false
	end

	local id = Window.tabs[index].id
	local page = Window.pageCache[index]
	if not page then
		local builder = Novo.Pages[id]
		if builder then
			page = builder(Window.area)
			Window.pageCache[index] = page
		end
	end
	if page then
		page.Visible = true
	end
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local CAPTION   = Color3.fromRGB(150, 152, 166)
local SUBTITLE  = Color3.fromRGB(180, 180, 190)
local USERNAME  = Color3.fromRGB(140, 142, 158)
local CARD_DIM  = Color3.fromRGB(15, 15, 18)
local AVA_RING  = Color3.fromRGB(22, 22, 26)

local ICON_CLOCK    = "rbxassetid://8992234911"
local ICON_BED      = "rbxassetid://8992234911"
local ICON_BYPASSER = "rbxassetid://114697945255264"
local ICON_CHAT     = "rbxassetid://94277343080125"
local ICON_EXPAND   = "rbxassetid://82907879206637"

local STRIP = {
	{ value = "Fly",  caption = "Off", action = "fly" },
	{ icon = ICON_BYPASSER, caption = "Bypasser", action = "mic" },
	{ value = "ESP",  caption = "Panel", action = "esp" },
}

local function placeThumb(placeId)
	return ("https://www.roblox.com/asset-thumbnail/image?assetId=%d&width=768&height=432&format=png")
		:format(placeId)
end

local function headshot(userId, size)
	return ("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=%d&height=%d&format=png")
		:format(userId, size, size)
end

local function hoverLift(button, target, base, hover)
	button.MouseEnter:Connect(function()
		Util.tween(target, Util.Motion.Snap, { BackgroundTransparency = hover })
	end)
	button.MouseLeave:Connect(function()
		Util.tween(target, Util.Motion.Snap, { BackgroundTransparency = base })
	end)
end

local function label(props)
	if props.BackgroundTransparency == nil then
		props.BackgroundTransparency = 1
	end
	props.TextYAlignment = props.TextYAlignment or Enum.TextYAlignment.Center
	return new("TextLabel", props)
end

local function stripCell(parent, index, spec)
	local third = 1 / 3
	local cell = new("Frame", {
		Position = UDim2.fromScale(third * (index - 1), 0),
		Size = UDim2.new(third, 0, 1, 0),
		BackgroundTransparency = 1,
		ZIndex = 35,
		Parent = parent,
	})

	local value = label({
		Name = "Value",
		Position = UDim2.fromOffset(4, 9),
		Size = UDim2.new(1, -8, 0, 21),
		Text = spec.value or "",
		TextColor3 = Theme.TextBright,
		TextSize = 15,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Center,
		Visible = spec.value ~= nil,
		ZIndex = 36,
		Parent = cell,
	})

	if spec.icon then
		new("ImageLabel", {
			Name = "Icon",
			Position = UDim2.new(0.5, 0, 0, 19),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(18, 18),
			BackgroundTransparency = 1,
			Image = spec.icon,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 36,
			Parent = cell,
		})
	end

	local capt = label({
		Name = "Caption",
		Position = UDim2.fromOffset(4, 32),
		Size = UDim2.new(1, -8, 0, 14),
		Text = spec.caption,
		TextColor3 = CAPTION,
		TextSize = 10,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 36,
		Parent = cell,
	})

	local hit = new("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 37,
		Parent = cell,
	})

	hit.MouseEnter:Connect(function()
		Util.tween(value, Util.Motion.Snap, { TextTransparency = 0.25 })
	end)
	hit.MouseLeave:Connect(function()
		Util.tween(value, Util.Motion.Snap, { TextTransparency = 0 })
	end)

	return { cell = cell, value = value, caption = capt, hit = hit }
end

local function activityCard(parent, order, spec, onClick)
	local card = new("Frame", {
		Size = UDim2.new(1, -14, 0, 100),
		BackgroundTransparency = 1,
		LayoutOrder = order,
		ZIndex = 35,
		Parent = parent,
	})

	local thumb = new("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = CARD_DIM,
		BackgroundTransparency = 0,
		Image = spec.thumb,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 35,
		Parent = card,
	})
	Util.corner(Theme.R_Nav, thumb)

	local avatar = new("ImageLabel", {
		Position = UDim2.new(0, 10, 1, -10),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.fromOffset(32, 32),
		BackgroundTransparency = 1,
		Image = spec.headshot or ("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48"):format(spec.user),
		ZIndex = 38,
		Parent = card,
	})
	Util.corner(Theme.R_Pill, avatar)
	Util.stroke(AVA_RING, 2, 0, Enum.ApplyStrokeMode.Contextual, avatar)

	label({
		Position = UDim2.new(0, 50, 1, -10),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, -60, 0, 32),
		Text = spec.game,
		TextColor3 = Theme.TextBright,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 37,
		Parent = card,
	})
	label({
		Position = UDim2.new(0, 51, 1, -9),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(1, -60, 0, 32),
		Text = spec.game,
		TextColor3 = Color3.new(0, 0, 0),
		TextTransparency = 0.5,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 36,
		Parent = card,
	})

	card.MouseEnter:Connect(function()
		Util.tween(thumb, Util.Motion.Snap, { ImageTransparency = 0.15 })
	end)
	card.MouseLeave:Connect(function()
		Util.tween(thumb, Util.Motion.Snap, { ImageTransparency = 0 })
	end)

	if onClick then
		card.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				onClick()
			end
		end)
	end
	return card
end

Novo.Pages.Home = function(parent)
	local page = new("Frame", {
		Name = "Content_Home",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 22,
		Parent = parent,
	})

	local landing = new("Frame", {
		Name = "HomeLanding",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 30,
		Parent = page,
	})
	Util.corner(Theme.R_Panel, landing)

	local bg = new("ImageLabel", {
		Name = "HomeBg",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = Theme.Wallpaper,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 31,
		Parent = landing,
	})
	Util.corner(Theme.R_Panel, bg)

	local wash = new("Frame", {
		Name = "DarkOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		ZIndex = 32,
		Parent = landing,
	})
	Util.corner(Theme.R_Panel, wash)

	local displayName = LocalPlayer and LocalPlayer.DisplayName or "Player"
	local userName = LocalPlayer and LocalPlayer.Name or "Player"

	label({
		Position = UDim2.fromOffset(14, 14),
		Size = UDim2.new(1, -28, 0, 22),
		Text = "Welcome home, " .. displayName,
		TextColor3 = Theme.TextBright,
		TextSize = 17,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 34,
		Parent = landing,
	})
	label({
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -28, 0, 14),
		Text = "Novoline",
		TextColor3 = SUBTITLE,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 34,
		Parent = landing,
	})

	local clock = new("Frame", {
		Name = "HomeClock",
		Position = UDim2.new(1, -14, 0, 14),
		AnchorPoint = Vector2.new(1, 0),
		Size = UDim2.fromOffset(0, 36),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 34,
		Parent = landing,
	})
	Util.corner(Theme.R_Nav, clock)
	Util.padding(0, 0, 10, 14, clock)
	local clockLayout = Util.list(Enum.FillDirection.Horizontal, 8,
		Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center, clock)
	clockLayout.SortOrder = Enum.SortOrder.Name

	local iconSlot = new("Frame", {
		Name = "ClockIconSlot",
		Size = UDim2.fromOffset(24, 24),
		BackgroundTransparency = 1,
		ZIndex = 35,
		Parent = clock,
	})
	new("ImageLabel", {
		Name = "ClockGlyph",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = ICON_CLOCK,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 35,
		Parent = iconSlot,
	})
	new("ImageLabel", {
		Name = "BedGlyph",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = ICON_BED,
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 36,
		Parent = iconSlot,
	})

	local clockText = label({
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		Text = os.date("%I:%M %p"):gsub("^0", ""),
		TextColor3 = Theme.TextBright,
		TextSize = 15,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 35,
		Parent = clock,
	})
	task.spawn(function()
		while clockText.Parent do
			clockText.Text = os.date("%I:%M %p"):gsub("^0", "")
			task.wait(5)
		end
	end)

	local widgets = new("Frame", {
		Name = "WidgetRow",
		Position = UDim2.fromOffset(14, 60),
		Size = UDim2.new(1, -28, 0, 52),
		BackgroundTransparency = 1,
		ZIndex = 34,
		Parent = landing,
	})

	local strip = new("Frame", {
		Name = "ServerStrip",
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ZIndex = 34,
		Parent = widgets,
	})
	Util.corner(Theme.R_Card, strip)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, strip)
	local cells = {}
	for i, spec in ipairs(STRIP) do
		cells[spec.action or i] = stripCell(strip, i, spec)
	end

	local F = Novo.Features
	if F then
		local flyCell = cells.fly
		if flyCell then
			local function paintFly()
				local on = F.Fly.enabled
				flyCell.caption.Text = on and "On" or "Off"
				Util.tween(flyCell.value, Util.Motion.Snap, {
					TextColor3 = on and Theme.AccentLight or Theme.TextBright,
				})
			end
			flyCell.hit.MouseButton1Click:Connect(function()
				F.Fly.toggle()
			end)
			F.Fly.changed.Event:Connect(paintFly)
			paintFly()
		end

		if cells.mic then
			cells.mic.hit.MouseButton1Click:Connect(function()
				if Novo.Panels and Novo.Panels.toggle then
					Novo.Panels.toggle("VCBypass")
				else
					F.Mic.run()
				end
			end)
		end

		if cells.esp then
			cells.esp.hit.MouseButton1Click:Connect(function()
				if Novo.Panels and Novo.Panels.toggle then
					Novo.Panels.toggle("Esp")
				end
			end)
		end
	end

	local profile = new("Frame", {
		Name = "ProfileCard",
		Position = UDim2.fromOffset(0, 62),
		Size = UDim2.new(0.5, -5, 0, 212),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 34,
		Parent = widgets,
	})
	Util.corner(Theme.R_Card, profile)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, profile)

	local ring = new("Frame", {
		Name = "ProfileRing",
		Position = UDim2.new(0.5, 0, 0, 14),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.fromOffset(84, 84),
		BackgroundTransparency = 1,
		ZIndex = 35,
		Parent = profile,
	})
	Util.corner(Theme.R_Pill, ring)
	local ringStroke = Util.stroke(Theme.TextBright, 2, 0, Enum.ApplyStrokeMode.Contextual, ring)
	new("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Theme.AccentLight),
			ColorSequenceKeypoint.new(0.55, Theme.Accent),
			ColorSequenceKeypoint.new(1, Theme.AccentDark),
		}),
		Rotation = 45,
		Parent = ringStroke,
	})

	local avatar = new("ImageLabel", {
		Name = "ProfileAvatar",
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, -8, 1, -8),
		BackgroundTransparency = 1,
		Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100")
			:format(LocalPlayer and LocalPlayer.UserId or 1),
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 35,
		Parent = ring,
	})
	Util.corner(Theme.R_Pill, avatar)

	local dot = new("Frame", {
		Name = "StatusDot",
		Position = UDim2.new(0.5, 30, 0, 86),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(15, 15),
		BackgroundColor3 = Theme.Good,
		BorderSizePixel = 0,
		ZIndex = 37,
		Parent = profile,
	})
	Util.corner(Theme.R_Pill, dot)
	Util.stroke(Theme.StrokeDot, 3, 0, Enum.ApplyStrokeMode.Contextual, dot)

	label({
		Position = UDim2.fromOffset(0, 106),
		Size = UDim2.new(1, 0, 0, 16),
		Text = displayName,
		TextColor3 = Theme.TextBright,
		TextSize = 14,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 36,
		Parent = profile,
	})
	label({
		Position = UDim2.fromOffset(0, 124),
		Size = UDim2.new(1, 0, 0, 14),
		Text = userName,
		TextColor3 = USERNAME,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 36,
		Parent = profile,
	})

	local function statHolder(name, value)
		return label({
			Name = name,
			Size = UDim2.new(),
			BackgroundTransparency = 0,
			Text = value,
			TextColor3 = Color3.fromRGB(27, 42, 53),
			TextSize = 8,
			TextXAlignment = Enum.TextXAlignment.Center,
			Visible = false,
			ZIndex = 1,
			Parent = profile,
		})
	end
	statHolder("StatOnlineVal", "0")
	statHolder("StatInServerVal", "0")

	local chatBar = new("Frame", {
		Name = "ChatBar",
		Position = UDim2.new(0.5, 0, 1, -16),
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.new(1, -32, 0, 40),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ZIndex = 35,
		Parent = profile,
	})
	Util.corner(Theme.R_Button, chatBar)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, chatBar)

	new("ImageLabel", {
		Name = "ChatIcon",
		Position = UDim2.new(0, 12, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		Image = ICON_CHAT,
		ImageColor3 = CAPTION,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 36,
		Parent = chatBar,
	})
	local placeholder = label({
		Name = "ChatPlaceholder",
		Position = UDim2.new(0, 42, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -54, 0, 18),
		Text = "Chat...",
		TextColor3 = USERNAME,
		TextSize = 12,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 36,
		Parent = chatBar,
	})

	local inputHolder = new("Frame", {
		Name = "HomeChatInputContainer",
		Position = UDim2.new(0, 42, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(1, -54, 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = chatBar,
	})
	local input = new("TextBox", {
		Name = "HomeChatInput",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = "",
		PlaceholderText = "Message...",
		PlaceholderColor3 = Theme.TextMuted,
		TextColor3 = Theme.Text,
		TextSize = 12,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Visible = false,
		ZIndex = 37,
		Parent = inputHolder,
	})

	local chatOpen = new("TextButton", {
		Name = "HomeChatOpen",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 38,
		Parent = chatBar,
	})
	hoverLift(chatOpen, chatBar, Theme.T_Card, 0.78)
	chatOpen.MouseButton1Click:Connect(function()
		placeholder.Visible = false
		input.Visible = true
		input:CaptureFocus()
	end)
	input.FocusLost:Connect(function()
		if input.Text == "" then
			input.Visible = false
			placeholder.Visible = true
		end
	end)

	local feed = new("ScrollingFrame", {
		Name = "HomeChatFeed",
		Position = UDim2.fromOffset(12, 44),
		Size = UDim2.new(1, -24, 0, 114),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		ZIndex = 36,
		Parent = profile,
	})
	Util.list(Enum.FillDirection.Vertical, 9, nil, nil, feed)
	label({
		Size = UDim2.new(1, 0, 0, 30),
		Text = "Connected to chat. Say hi",
		TextColor3 = Theme.TextMuted,
		TextTransparency = 1,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		ZIndex = 36,
		Parent = feed,
	})

	label({
		Name = "HomeChatTitle",
		Position = UDim2.fromOffset(14, 12),
		Size = UDim2.new(1, -80, 0, 16),
		Text = "Chat",
		TextColor3 = Theme.TextBright,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		Visible = false,
		ZIndex = 39,
		Parent = profile,
	})

	local glass = new("Frame", {
		Name = "HomeChatBtnGlass",
		Position = UDim2.new(1, -8, 0, 8),
		AnchorPoint = Vector2.new(1, 0),
		Size = UDim2.fromOffset(64, 34),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 38,
		Parent = profile,
	})
	Util.corner(Theme.R_Card, glass)
	Util.stroke(Theme.StrokeSoft, 1, 1, Enum.ApplyStrokeMode.Contextual, glass)

	local function chipButton(name, xOffset, iconId, iconSize)
		local btn = new("TextButton", {
			Name = name,
			Position = UDim2.new(1, xOffset, 0, 12),
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.fromOffset(26, 26),
			BackgroundTransparency = 1,
			Text = "",
			TextSize = 8,
			AutoButtonColor = false,
			Visible = false,
			ZIndex = 39,
			Parent = profile,
		})
		new("ImageLabel", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(iconSize, iconSize),
			BackgroundTransparency = 1,
			Image = iconId,
			ImageColor3 = Theme.TextMuted,
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 40,
			Parent = btn,
		})
		return btn
	end
	chipButton("HomeChatOpenMain", -42, ICON_EXPAND, 18)
	chipButton("HomeChatClose", -12, Theme.Icon.Cross, 16)

	local activity = new("Frame", {
		Name = "FriendActivityCard",
		Position = UDim2.new(0.5, 5, 0, 62),
		Size = UDim2.new(0.5, -5, 0, 212),
		BackgroundColor3 = Theme.Panel,
		BackgroundTransparency = Theme.T_Card,
		BorderSizePixel = 0,
		ZIndex = 34,
		Parent = widgets,
	})
	Util.corner(Theme.R_Card, activity)
	Util.stroke(Theme.StrokeSoft, 1, Theme.T_StrokeSoft, Enum.ApplyStrokeMode.Contextual, activity)

	label({
		Position = UDim2.fromOffset(14, 12),
		Size = UDim2.new(1, -28, 0, 16),
		Text = "Friend Activity",
		TextColor3 = Theme.TextBright,
		TextSize = 13,
		FontFace = Theme.Font.Bold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 36,
		Parent = activity,
	})

	local scroll = new("ScrollingFrame", {
		Name = "ActivityScroll",
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -14, 1, -50),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ScrollBarThickness = 0,
		ScrollBarImageColor3 = Color3.fromRGB(160, 162, 178),
		ScrollBarImageTransparency = 1,
		CanvasSize = UDim2.fromOffset(0, 442),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ZIndex = 35,
		Parent = activity,
	})
	Util.list(Enum.FillDirection.Vertical, 14, nil, nil, scroll)

	local empty = label({
		Position = UDim2.fromOffset(14, 36),
		Size = UDim2.new(1, -28, 1, -50),
		Text = "Your friends will appear here when they're in-game.",
		TextColor3 = USERNAME,
		TextSize = 11,
		FontFace = Theme.Font.Medium,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextWrapped = true,
		Visible = false,
		ZIndex = 36,
		Parent = activity,
	})

	local function fillFriends()
		if not Novo.Features then return end
		local list = Novo.Features.Friends.online()

		for _, child in ipairs(scroll:GetChildren()) do
			if child:IsA("Frame") then child:Destroy() end
		end

		for i, friend in ipairs(list) do
			activityCard(scroll, i, {
				game = friend.location,
				thumb = placeThumb(friend.placeId),
				user = friend.userId,
				headshot = headshot(friend.userId, 48),
			}, function()
				Novo.Features.Friends.join(friend)
			end)
		end

		empty.Visible = #list == 0
		scroll.CanvasSize = UDim2.fromOffset(0, #list * 114)
	end

	task.spawn(function()
		while page.Parent do
			fillFriends()
			task.wait(#scroll:GetChildren() > 1 and 30 or 5)
		end
	end)

	return page
end
end

do
local Util  = Novo.Util
local Theme = Novo.Theme
local new   = Util.new

local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
local FADE  = TweenInfo.new(0.20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local SNAP  = Util.Motion.Snap

local SUBTITLE   = Color3.fromRGB(180, 180, 190)
local ROW_TINT   = Color3.fromRGB(88, 75, 10)
local PIN_GOLD   = Color3.fromRGB(255, 190, 30)
local PIN_TEXT   = Color3.fromRGB(220, 170, 30)
local SWITCH_RIM = Color3.fromRGB(18, 18, 20)
local THUMB_OFF_TOP = Color3.fromRGB(40, 40, 44)
local THUMB_ON_TOP  = Color3.fromRGB(91, 160, 245)
local THUMB_ON_BOT  = Color3.fromRGB(29, 67, 147)

local WHITE = Color3.fromRGB(255, 255, 255)

local PIN_ICON = "rbxassetid://102437792716891"

local ROW_STEP     = 40
local ROW_H        = 38
local FEATURED_TOP = 28
local ALL_TOP      = 336
local CANVAS_H     = 4060

local THUMB_OFF = UDim2.new(0, 15, 0.5, 0)
local THUMB_ON  = UDim2.new(0, 33, 0.5, 0)

local ROW_REST  = 1
local ROW_HOVER = 0.93
local ROW_PRESS = 0.88

local CATEGORIES = {
	{ label = "All",       width = 32 },
	{ label = "Toggles",   width = 57 },
	{ label = "Character", width = 67 },
	{ label = "Movement",  width = 73 },
	{ label = "Troll",     width = 41 },
	{ label = "Exploit",   width = 53 },
	{ label = "Misc",      width = 42 },
	{ label = "Custom",    width = 57 },
}

local FEATURED = {
	{ "reanim ", "Open reanim animations panel" },
	{ "togglefly [tf] ", "Toggle fly on/off" },
	{ "speed [ws, walkspeed] <n>", "Set walk speed" },
	{ "stationarywalk [swalk, statwalk] ", "Full-speed walk anims while moving slower", toggle = true },
	{ "vcbooster [vcboost, boostvc] <p>", "Open voice chat booster" },
	{ "chatedit [chateditor, fechat, fcedit] <cover> <text>", "Open FE chat editor" },
	{ "vcbypasser [vcb] ", "Open VC bypasser panel" },
}

local ALL = {
	{ "adonisbypass [adonis, ab] ", "Bypass Adonis admin detection" },
	{ "age <p>", "Show a player's account age" },
	{ "aimbot [aim] ", "Open Aimbot panel", toggle = true },
	{ "airwalk [aw] ", "Walk on air (Space to go up)", toggle = true },
	{ "anim [ani] <s>", "Play animation by name or ID" },
	{ "animbundle [ab, anims] ", "Open Animation Bundles menu" },
	{ "animlogger [al] ", "Toggle animation spy logger" },
	{ "annoy [an] <p>", "Teleport around a player" },
	{ "antiafk [aafk] ", "Prevent AFK kick", toggle = true },
	{ "antifling [af] ", "Disable others' collision", toggle = true },
	{ "antikick [ak] ", "Client-side anti-kick hook" },
	{ "antisit [as2] ", "Prevent being sat in a seat", toggle = true },
	{ "antiteleport [at] ", "Block TeleportService from moving you", toggle = true },
	{ "ass <n>", "Big ass (visual). Optional size 1-8" },
	{ "asseat [as] ", "Open asseat panel, make people eat your ass.", toggle = true },
	{ "asseat2 [as2] ", "Open asseat2 panel - weld method. Do not use on shitty executors.", toggle = true },
	{ "attach [att] <p>", "Weld yourself to a player" },
	{ "autoexecute [ae] <s>", "Toggle a command on/off the auto-run list" },
	{ "autograbtools ", "Auto-grab tools dropped into workspace", toggle = true },
	{ "automate [autoif] ", "Open automate rule builder" },
	{ "backpack [bp] <p>", "Ride on player's back" },
	{ "backpack2 <p>", "Ride on player's back - weld method. Do not use on shitty executors." },
	{ "bang [bng] ", "Open bang control panel" },
	{ "bang2 [bng2] ", "Open bang2 panel - weld method. Do not use on shitty executors." },
	{ "brightness <n>", "Set lighting brightness" },
	{ "btools [bt] ", "Give client building tools. Does not replicate." },
	{ "carpet [cp] <p>", "Lie under player" },
	{ "chat ", "Open cross-server chat panel" },
	{ "chatmute [cm] <p>", "Mute a player in your chat" },
	{ "clearprofiles [cpf] ", "Delete every saved Novoline profile" },
	{ "clearsettings [cs] ", "Disable active toggles and restore default settings" },
	{ "clearwaypoints [cwp] ", "Delete all saved waypoints" },
	{ "clearwearing ", "Remove all worn accessories" },
	{ "clickfling [cf] ", "Click a player to fling them (SkidFling)", toggle = true },
	{ "clip ", "Disable noclip" },
	{ "cobalt ", "Improved RemoteSpy" },
	{ "console ", "Open dev console" },
	{ "copycoords [copycoord, coords, copycframe] ", "Copy current xyz and cframe" },
	{ "copyemote [syncemote, copyanim] <p>", "Copy target player's animation" },
	{ "copyid [cid] <p>", "Copy a player's UserID to clipboard" },
	{ "copyname [cn] <p>", "Copy a player's username to clipboard" },
	{ "copyuser [cu] <p>", "Copy player username" },
	{ "creepywalk [cw] ", "Creepy looped walk/run anim", toggle = true },
	{ "day ", "Set time to day" },
	{ "delete [del, remove] <p>", "Hide a player's character" },
	{ "deletewaypoint [dwp] <n>", "Delete a named waypoint" },
	{ "dex ", "Load Dex Explorer" },
	{ "dick <n>", "Dick (visual). Optional length 0.5-6" },
	{ "disableanims ", "Disable character animations", toggle = true },
	{ "disablebinds <permanent|session-wise>", "Disable keybind execution", toggle = true },
	{ "disableproximityprompts ", "Disable all ProximityPrompts" },
	{ "disablesit [ds] ", "Prevent your character from sitting", toggle = true },
	{ "discord ", "Copy Discord invite" },
	{ "drift [ice, slide] <s>", "Sit and ice-slide with WASD", toggle = true },
	{ "drophats [dh] ", "Drop hats as physical objects" },
	{ "droptools [dt] ", "Drop all tools from your backpack" },
	{ "enableanims ", "Enable character animations" },
	{ "enablebinds ", "Enable keybind execution" },
	{ "enableproximityprompts ", "Enable all ProximityPrompts" },
	{ "enablesit ", "Re-enable sitting" },
	{ "equiptools [et] ", "Equip every tool from backpack", toggle = true },
	{ "esp [wallhack, wh] ", "Open ESP panel", toggle = true, on = true },
	{ "facebang [fb] ", "Open facebang control panel" },
	{ "facebang2 ", "Open facebang2 panel - weld method. Do not use on shitty executors." },
	{ "fakelag [lag] ", "Open fakelag panel", toggle = true },
	{ "fakeout [fo] ", "Briefly void yourself then snap back" },
	{ "fcgoto [fctp] <p>", "Move freecam to player" },
	{ "fcspeed <n>", "Set freecam nav speed" },
	{ "findfriendgroups ", "Find groups of friends in the server" },
	{ "fireclickdetectors ", "Fire all ClickDetectors in workspace" },
	{ "fireproximityprompts ", "Fire all proximity prompts" },
	{ "fireproximitypromptsfind <s>", "Fire proximity prompts matching name" },
	{ "firework ", "Launch into the air spinning like a firework then explode and reset" },
	{ "fling [fl] ", "Spin fling yourself", toggle = true },
	{ "float [plat, platform] ", "Spawn a platform beneath you (Q=down, E=up)", toggle = true },
	{ "fly [f] <s>", "Start flying; optional speed", toggle = true, bind = "F" },
	{ "flyspeed [fs, flysp] <s>", "Set fly speed (default 1)" },
	{ "fov [cam] <n>", "Set field of view" },
	{ "fps ", "Show current framerate" },
	{ "freecam [fc] ", "Enter free camera", toggle = true },
	{ "freecamspeed [fcs] <n>", "Set freecam nav speed" },
	{ "freeze [fr] ", "Anchor all your character parts (client)", toggle = true },
	{ "friend [fr2] <p>", "Send friend request" },
	{ "friends [fr] ", "Open friends online panel" },
	{ "ftp [mousetp] ", "Teleport to mouse (F key)", toggle = true },
	{ "fullbright ", "Maximize all light ranges", toggle = true },
	{ "gamepass ", "Open purchase toggler / gamepass event catcher" },
	{ "gamma <n>", "Set lighting exposure/gamma" },
	{ "generate <n>", "Generate an item" },
	{ "globalshadows [gs] ", "Enable global shadows", toggle = true },
	{ "goto [tp, to] <p>", "Teleport to player" },
	{ "gotowaypoint [gwp, wp] <n>", "Teleport to a saved waypoint" },
	{ "grabtools [gt] ", "Grab dropped tools from workspace" },
}

local function switchGlow(parent, transparency)
	local ok, shadow = pcall(function()
		return new("UIShadow", {
			Color = Theme.Accent,
			Transparency = transparency,
			Parent = parent,
		})
	end)
	return ok and shadow or nil
end

local function buildCaption(parent, opts)
	local holder = new("Frame", {
		Name = "Caption",
		Position = UDim2.new(0, 0, 0, opts.y),
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = opts.visible ~= false,
		ZIndex = 13,
		Parent = parent,
	})

	if opts.rule then
		new("Frame", {
			Name = "Rule",
			Position = UDim2.new(0, 10, 0, 0),
			Size = UDim2.new(1, -20, 0, 1),
			BackgroundColor3 = Theme.Divider,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 13,
			Parent = holder,
		})
	end

	if opts.icon then
		new("ImageLabel", {
			Name = "Glyph",
			Position = UDim2.new(0, 10, 0.5, 0),
			Size = UDim2.fromOffset(opts.iconSize, opts.iconSize),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			Image = opts.icon,
			ImageColor3 = opts.iconColor,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 14,
			Parent = holder,
		})
	end

	new("TextLabel", {
		Name = "Label",
		Position = UDim2.new(0, opts.textX, 0.5, 0),
		Size = opts.textSize,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = opts.text,
		TextColor3 = opts.color,
		TextSize = 10,
		TextTransparency = opts.textTransparency or 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		FontFace = Theme.Font.Bold,
		ZIndex = 14,
		Parent = holder,
	})

	return holder
end

local function buildRow(parent, data, y)
	local hasSwitch = data.toggle == true
	local textInset = hasSwitch and -140 or -84
	local chipX = hasSwitch and -88 or -32

	local row = new("Frame", {
		Name = "Row",
		Position = UDim2.new(0, 6, 0, y),
		Size = UDim2.new(1, -14, 0, ROW_H),
		BackgroundColor3 = WHITE,
		BackgroundTransparency = ROW_REST,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 13,
		Parent = parent,
	})
	Util.corner(Theme.R_Button, row)
	new("UIGradient", {
		Color = ColorSequence.new(WHITE),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.32),
			NumberSequenceKeypoint.new(0.42, 0.62),
			NumberSequenceKeypoint.new(1, 0.92),
		}),
		Rotation = 90,
		Parent = row,
	})

	local tint = new("Frame", {
		Name = "PinTint",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = ROW_TINT,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 13,
		Parent = row,
	})
	Util.corner(Theme.R_Button, tint)

	new("TextLabel", {
		Name = "Title",
		Position = UDim2.new(0, 10, 0, 5),
		Size = UDim2.new(1, textInset, 0, 16),
		BackgroundTransparency = 1,
		Text = data[1],
		TextColor3 = Theme.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Bold,
		ZIndex = 14,
		Parent = row,
	})

	new("TextLabel", {
		Name = "Desc",
		Position = UDim2.new(0, 10, 0, 22),
		Size = UDim2.new(1, textInset, 0, 12),
		BackgroundTransparency = 1,
		Text = data[2],
		TextColor3 = Theme.TextMuted,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Medium,
		ZIndex = 14,
		Parent = row,
	})

	local pin = new("ImageButton", {
		Name = "Pin",
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(16, 16),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = PIN_ICON,
		ImageColor3 = Theme.TextMuted,
		ImageTransparency = 0.4,
		ScaleType = Enum.ScaleType.Stretch,
		AutoButtonColor = false,
		ZIndex = 16,
		Parent = row,
	})

	local track = new("Frame", {
		Name = "SwitchTrack",
		Position = UDim2.new(1, -32, 0.5, 0),
		Size = UDim2.fromOffset(48, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = Theme.PanelDeep,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Visible = hasSwitch,
		ZIndex = 16,
		Parent = row,
	})
	Util.corner(Theme.R_Pill, track)
	Util.stroke(SWITCH_RIM, 1, Theme.T_Stroke, Enum.ApplyStrokeMode.Contextual, track)

	local on = data.on == true

	local thumb = new("Frame", {
		Name = "SwitchThumb",
		Position = on and THUMB_ON or THUMB_OFF,
		Size = UDim2.fromOffset(26, 18),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = WHITE,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 18,
		Parent = track,
	})
	Util.corner(Theme.R_Pill, thumb)
	local thumbGrad = new("UIGradient", {
		Color = on
			and ColorSequence.new(THUMB_ON_TOP, THUMB_ON_BOT)
			or ColorSequence.new(THUMB_OFF_TOP, Theme.Panel),
		Transparency = NumberSequence.new(0, 0),
		Rotation = 90,
		Parent = thumb,
	})
	local glow = switchGlow(thumb, on and 0.28 or 0.94)

	local thumbScale = new("UIScale", { Scale = 1, Parent = track })

	local switchHit = new("TextButton", {
		Name = "SwitchHit",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 18,
		Parent = track,
	})

	local hit = new("TextButton", {
		Name = "Hit",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = false,
		ZIndex = 14,
		Parent = row,
	})

	local chip = new("Frame", {
		Name = "Bind",
		Position = UDim2.new(1, chipX, 0.5, 0),
		Size = UDim2.fromOffset(48, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = row,
	})
	Util.corner(Theme.R_Button, chip)

	local bound = data.bind ~= nil
	local chipLabel = new("TextLabel", {
		Name = "Label",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = data.bind or "+ bind",
		TextColor3 = bound and Theme.Text or Theme.TextFaint,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextStrokeTransparency = 1,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Theme.Font.Medium,
		ZIndex = 16,
		Parent = chip,
	})

	local chipHit = new("TextButton", {
		Name = "Hit",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		TextSize = 8,
		AutoButtonColor = true,
		ZIndex = 17,
		Parent = chip,
	})

	local hovered, held = false, false
	local function paint()
		local goal = ROW_REST
		if held then
			goal = ROW_PRESS
		elseif hovered then
			goal = ROW_HOVER
		end
		Util.tween(row, SNAP, { BackgroundTransparency = goal })
	end

	hit.MouseEnter:Connect(function()
		hovered = true
		paint()
	end)
	hit.MouseLeave:Connect(function()
		hovered, held = false, false
		paint()
	end)
	hit.MouseButton1Down:Connect(function()
		held = true
		paint()
	end)
	hit.MouseButton1Up:Connect(function()
		held = false
		paint()
	end)

	local pinned = false
	pin.MouseEnter:Connect(function()
		if pinned then return end
		Util.tween(pin, SNAP, { ImageTransparency = 0.05 })
	end)
	pin.MouseLeave:Connect(function()
		if pinned then return end
		Util.tween(pin, SNAP, { ImageTransparency = 0.4 })
	end)
	pin.MouseButton1Click:Connect(function()
		pinned = not pinned
		Util.tween(pin, FADE, {
			ImageTransparency = pinned and 0 or 0.4,
			ImageColor3 = pinned and PIN_GOLD or Theme.TextMuted,
		})
		Util.tween(tint, FADE, { BackgroundTransparency = pinned and 0.88 or 1 })
	end)

	chipHit.MouseEnter:Connect(function()
		Util.tween(chip, SNAP, { BackgroundTransparency = 0.9 })
		Util.tween(chipLabel, SNAP, { TextColor3 = Theme.Text })
	end)
	chipHit.MouseLeave:Connect(function()
		Util.tween(chip, SNAP, { BackgroundTransparency = 1 })
		Util.tween(chipLabel, SNAP, { TextColor3 = bound and Theme.Text or Theme.TextFaint })
	end)

	local state = on
	local function applySwitch(animate)
		local info = animate and Util.Motion.Quick or SNAP
		if animate then
			Util.tween(thumb, info, { Position = state and THUMB_ON or THUMB_OFF })
		else
			thumb.Position = state and THUMB_ON or THUMB_OFF
		end
		thumbGrad.Color = state
			and ColorSequence.new(THUMB_ON_TOP, THUMB_ON_BOT)
			or ColorSequence.new(THUMB_OFF_TOP, Theme.Panel)
		if glow then
			Util.tween(glow, FADE, { Transparency = state and 0.28 or 0.94 })
		end
	end

	switchHit.MouseButton1Down:Connect(function()
		Util.tween(thumbScale, SNAP, { Scale = 0.94 })
	end)
	switchHit.MouseButton1Up:Connect... (215 KB left)
