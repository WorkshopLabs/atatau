-------------------------------------------------
-- Island of the Moon Game Studio
-- www.islandofthemoon.com
--
-- Template project for UCATEC Game Jam 2013
--
-- Copyright (C) 2013 @islandofthemoon
-- MIT License http://opensource.org/licenses/MIT
-------------------------------------------------
local os = require("os")

local widget     = require("widget")
local storyboard = require("storyboard")

local scene = storyboard.newScene()

local _W = display.contentWidth
local _H = display.contentHeight

local background
local background2
local title

local playBtn
local playBtnTr

local salirBtn
local salirBtnTr

local creditoBtn
local creditoBtnTr

local trTitle
local trPlay

local sonidoIntro
local backgroundMusicChannel

local BloqueadoresTr
local bloqueadoresImg

local poliImg
local poliTr

local menutablaImg
local menutablaTr

local sonidoEfecto01
local sonidoEfecto01Play

local creditosImg

local function showCreditos()
  transition.to(CreditosImg, {
    time       = 200,
    transition = easing.inQuad,
    alpha      =1
  })
end

local function creditohide()
    CreditosImg.alpha = 0
end

local function salir()
    os.exit()
end

local function startGame()
  BloqueadoresTr = transition.to(bloqueadoresImg, {
    time       = 400,
    transition = easing.inQuad,
    x          = 1300
  })
  poliTr = transition.to(poliImg, {
    time       = 400,
    transition = easing.inQuad,
    x          = -1300
    --, onComplete = hideLogo
  })

  playBtnTr = transition.to(playBtn, {
    time       = 700,
    transition = easing.inQuad,
    x          = -1300
    --, onComplete = hideLogo
  })

  
  salirBtnTr = transition.to(salirBtn, {
    time       = 400,
    transition = easing.inQuad,
    x          = 1300
    --, onComplete = hideLogo
  })

  menutablaTr = transition.to(menutablaImg, {
    time       = 400,
    transition = easing.inQuad,
    y          = -1300
    --, onComplete = hideLogo
  })

  trPlay = transition.to(playBtn, {
    delay      = 40,
    time       = 200,
    transition = easing.inQuad,
    x          = 1300,
    onComplete = function()
      storyboard.gotoScene( "game" )
    end
  })
end

function scene:createScene( event )
  local group = self.view
  


  sonidoIntro = audio.loadStream('sound/estadoemergencia.mp3');
  backgroundMusicChannel = audio.play( sonidoIntro  )

  sonidoEfecto01 = audio.loadStream('sound/Discharge.mp3');

  background2 = display.newImage(group,'images/inicio.png');
  background2:setReferencePoint(display.CenterReferencePoint)

  bloqueadoresImg = display.newImage(group,'images/bloqueadores.png')
  bloqueadoresImg:setReferencePoint(display.CenterReferencePoint)
  bloqueadoresImg.alpha = 0

  poliImg = display.newImage(group,'images/poli.png')
  poliImg:setReferencePoint(display.CenterReferencePoint)
  poliImg.alpha = 0

  menutablaImg= display.newImage(group,'images/menutabla.png')
  menutablaImg:setReferencePoint(display.CenterReferencePoint)
  menutablaImg.alpha = 0
  menutablaImg.x = _W/2
  menutablaImg.y = _H/2+65

  
  ------------------------------------------------------------
  -- Botones
  ------------------------------------------------------------
  playBtn = widget.newButton
  {
      width = 175,
      height = 51,
      id = "button_1",
      label = "",
      onEvent = startGame,
      defaultFile = "images/bloquear01.png",
      overFile = "images/bloquear02.png"
  }
  group:insert(playBtn)
  playBtn.alpha = 0

  salirBtn = widget.newButton
  {
      width = 175,
      height = 51,
      id = "button_1",
      label = "",
      onEvent = salir,
      defaultFile = "images/salir01.png",
      overFile = "images/salir02.png"
  }
  group:insert(salirBtn)
  salirBtn.alpha = 0

  creditoBtn= widget.newButton
  {
      width = 175,
      height = 51,
      id = "button_1",
      label = "",
      onEvent = showCreditos,
      defaultFile = "images/credito01.png",
      overFile = "images/credito02.png"
  }
  group:insert(creditoBtn)
  creditoBtn.alpha = 0




  CreditosImg= widget.newButton
  {
      width = 273,
      height = 350,
      id = "button_1",
      label = "",
      onEvent = creditohide,
      defaultFile = "images/creditos2.png",
      --overFile = "images/credito02.png"
  }
  group:insert(CreditosImg)
  CreditosImg:setReferencePoint(display.CenterReferencePoint)
  CreditosImg.x = _W/2
  CreditosImg.y = _H/2+30
  CreditosImg.alpha = 0


end




local function showBtCredito()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
  creditoBtn:setReferencePoint(display.TopCenterReferencePoint)
  creditoBtn.x = _W/2
  creditoBtn.y = 250
  creditoBtn.alpha = 1
  transition.from(creditoBtn, { 
    time       = 200,
    transition = easing.inQuad,
    x          = -400
  })
end

local function showBtSalir()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
  salirBtn:setReferencePoint(display.TopCenterReferencePoint)
  salirBtn.x = _W/2
  salirBtn.y = 200
  salirBtn.alpha = 1
  transition.from(salirBtn, {
    time       = 200,
    transition = easing.inQuad,
    x          = -400,
    onComplete = showBtCredito
  })
end

local function showBtBloquear()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
  playBtn:setReferencePoint(display.TopCenterReferencePoint)
  playBtn.x = _W/2
  --playBtn.x = 0
  playBtn.y = 150
  playBtn.alpha = 1
  transition.from(playBtn, {
    time       = 200,
    transition = easing.inQuad,
    x          = -400,
    onComplete = showBtSalir
  })
end

local function showMenu()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
  transition.to(menutablaImg, {
    time       = 200,
    transition = easing.inQuad,
    alpha      =1,
    onComplete = showBtBloquear
  })
end

local function showPoli()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
  transition.to(poliImg, {
    time       = 300,
    transition = easing.inQuad,
    alpha      = 1,
    onComplete = showMenu
  })
end

local function showBloqueadores()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
  transition.to(bloqueadoresImg, {
    time       = 300,
    transition = easing.inQuad,
    alpha      =1,
    onComplete = showPoli
  })
end





function scene:enterScene( event )
  showBloqueadores()
  --showPoli()
	storyboard.purgeScene( "splash" )
	storyboard.purgeScene( "pause" )
  
  --title:setReferencePoint(display.TopCenterReferencePoint)
  --title:setTextColor(28,28,28)
  --title.x = _W/2
  --title.y = 40

  
--
--  transition.from(title, {
--    delay      = 80,
--    time       = 200,
--    transition = easing.inQuad,
--    x          = -400
--  })
  
end

function scene:exitScene( event )
  transition.cancel(BloqueadoresTr)
  transition.cancel(trPlay)
  transition.cancel(poliTr)
  transition.cancel(menutablaTr)
  
end

function scene:destroyScene( event )
	print( "((destroying menu view))" )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene