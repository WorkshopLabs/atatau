-------------------------------------------------
-- Island of the Moon Game Studio
-- www.islandofthemoon.com
--
-- Template project for UCATEC Game Jam 2013
--
-- MIT License http://opensource.org/licenses/MIT
-------------------------------------------------
-- Splash
-- El splash se muestra al iniciar el juego
-- -----------------------------------------------
local physics    = require( "physics" )
local widget     = require("widget")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local _W = display.contentWidth
local _H = display.contentHeight
local background
local ball
local pauseBtn

local touch = false
local xTouch = 0
local yTouch = 0
local paused = false

local crearPolicia
local comprobarCantidad

local playerScore = 0

local cantidadDePoliciasCreados = 0
local cantidadDePoliciasVivos = 0
local cantidadDePoliciasEliminados = 0

local startTime = 0

local group 
local ifUserLose
--RP
  



--Herramientas

local timepoBarril = 0
local tiempoTronco = 0
local tiempoLlanta = 0
local tiempoGasificacion = 60

local boolean swBotella = true
local boolean swLlanta = true
local boolean swTronco = true
local number2 = 0
function contt()
  number2 = number2 + 1
  if number2 == 5 then
         gasificar()

  end
end
timer.performWithDelay(1000, contt, 0)

local nube
function  gasificar()
   nube = display.newImage("nube.png")
   nube.myName = "nube"
   nube.x = 100
   nube.y = 200
   nube.alpha = 0
   physics.addBody( nube, "static", { density = 1.0, friction = 0.8, bounce = 0.2, radius = 15 } )
   transition.to( nube, { time=1000, alpha=0.7 } )
   Runtime:addEventListener( "collision", nube )
  -- body
end
--


-- Set Variables

motionx   = 0; -- Variable used to move character along x axis
speed     = 1; -- Set Walking Speed
playerInAir = true; -- Set a boolean of whether our guy is in the air or not
lifes     = 10; -- Set lifes to 



local function onTouch(e)
  if e.phase ~= "ended" then
    touch = true
    xTouch = e.x
    yTouch = e.y
  else
    touch = false
  end
end

local function onEnterFrame()
  deltaTime = os.time() - startTime
  -- iterar polis
   --poli:animate()
  --
  comprobarCantidad()
  fn_lifes()
  fn_counter()
  fn_points()
  ifUserLose()

end

local function pauseGame()
  if not paused then
    physics.pause()
    physics.pause()
    paused = true
    storyboard.showOverlay( "pause", {
        effect = "fade",
        time = 400
    })
  end
end


local markTime = os.time()
local startTime = os.time()
local deltaTime = 0
local txt_counter = display.newText( 0, 0, 0, native.systemFont, 20 )
local txt_lifes = display.newText( 0, 0, 0, native.systemFont, 20 )
local txt_points = display.newText( 0, 0, 0, native.systemFont, 20 )

function scene:createScene( event )

group = self.view

--VINI

local barra = display.newImage("barra.png")
barra.x = 35
barra.y= 35
barra.alpha = 0.5
barra.myName = "barra"

local llanta = display.newImage("llanta.png")
llanta.x = 35
llanta.y = 35
                physics.addBody( llanta, "static", { density = 1.0, friction = 0.8, bounce = 0.2, radius = 15 } )
llanta.myName = "llanta"
llanta:addEventListener( "touch", onTouch )
--physics.addBody(llanta,   "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})

local botella = display.newImage("botella.png")
botella.x = 35+70
botella.y = 35
                physics.addBody( botella, "static", { density = 1.0, friction = 0.8, bounce = 0.2, radius = 15 } )
botella.myName = "botella"
botella:addEventListener( "touch", onTouch )
--physics.addBody(botella,"static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})

 local tronco = display.newImage("tronco.png")
 tronco.x = 35+70+70
 tronco.y = 35
                 physics.addBody( tronco, "static", { density = 1.0, friction = 0.8, bounce = 0.2, radius = 15 } )
 tronco.xScale = 0.5
 tronco.yScale = 0.5
  tronco:addEventListener( "touch", onTouch )
tronco.myName = "tronco"

--VINI



  --RP: empieza counter
function fn_counter()
local timePassed = os.time() - markTime

txt_counter.x = 320
txt_counter.y = 15
txt_counter:setTextColor( 255, 255, 255 )
txt_counter.text = timePassed

  -- Runtime:addEventListener( "markTime", markTime )
 -- Runtime:addEventListener( "timePassed", timePassed )
end

  --RP: counter de puntos
function fn_points()

txt_points.x = 0
txt_points.y = 0
txt_points:setTextColor( 255, 255, 255 )
txt_points.text = cantidadDePoliciasEliminados

  -- Runtime:addEventListener( "markTime", markTime )
 -- Runtime:addEventListener( "timePassed", timePassed )
end


--RP:Termina counter
function fn_lifes()

  txt_lifes.x = 20
  txt_lifes.y = 305
  txt_lifes:setTextColor( 255, 255, 255 )
  txt_lifes.text = lifes
end
--timer.performWithDelay(1000, fn_lifes, 0)
--

--crearManifestacion
local sheetData =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet = graphics.newImageSheet("images/personaje1.png" , sheetData)
  local sequenceData = {
  {name = "fly", frames={1,2,3,1},  count=3, time=250, loopCount = 0 }
  }   
 local ryu = display.newSprite (spriteSheet, sequenceData)
  ryu.x = 450
  ryu.y = 80
  ryu:setSequence("fly")
   ryu:play()

   

local sheetData2 =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet2 = graphics.newImageSheet("images/personaje2.png" , sheetData2)
  local sequenceData2 = {
  {name = "fly2", frames={1,2,3,1},  count=3, time=300, loopCount = 0 }
  }   
 local ryu2 = display.newSprite (spriteSheet2, sequenceData2)
  ryu2.x = 450
  ryu2.y = 130
  ryu2:setSequence("fly2")
   ryu2:play()

local sheetData3 =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet3 = graphics.newImageSheet("images/personaje3.png" , sheetData3)
  local sequenceData3 = {
  {name = "fly3", frames={1,2,3,1},  count=3, time=300, loopCount = 0 }
  }   
 local ryu3 = display.newSprite (spriteSheet3, sequenceData3)
  ryu3.x = 450
  ryu3.y = 180
  ryu3:setSequence("fly3")
   ryu3:play()


local sheetData4 =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet4 = graphics.newImageSheet("images/personaje4.png" , sheetData4)
  local sequenceData4 = {
  {name = "fly4", frames={1,2,3,1},  count=3, time=400, loopCount = 0 }
  }   
 local ryu4 = display.newSprite (spriteSheet4, sequenceData4)
  ryu4.x = 450
  ryu4.y = 230
  ryu4:setSequence("fly4")
   ryu4:play()


  local spriteSheet5 = graphics.newImageSheet("images/personaje1.png" , sheetData)
   local sequenceData5 = {
  {name = "fly4", frames={1,2,3,1},  count=3, time=500, loopCount = 0 }
  }   
 local ryu5 = display.newSprite (spriteSheet5, sequenceData5)
  ryu5.x = 450
  ryu5.y = 280
  ryu5:setSequence("fly")
   ryu5:play()



local sheetData6 =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet6 = graphics.newImageSheet("images/personaje3.png" , sheetData6)
  local sequenceData6 = {
  {name = "fly6", frames={1,2,3,1},  count=3, time=200, loopCount = 0 }
  }   
 local ryu6 = display.newSprite (spriteSheet6, sequenceData6)
  ryu6.x = 470
  ryu6.y = 100
  ryu6:setSequence("fly6")
   ryu6:play()

   local sheetData7 =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet7 = graphics.newImageSheet("images/personaje1.png" , sheetData7)
  local sequenceData7 = {
  {name = "fly7", frames={1,2,3,1},  count=3, time=350, loopCount = 0 }
  }   
 local ryu7 = display.newSprite (spriteSheet7, sequenceData7)
  ryu7.x = 470
  ryu7.y = 150
  ryu7:setSequence("fly7")
   ryu7:play()

   local sheetData8 =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet8 = graphics.newImageSheet("images/personaje2.png" , sheetData8)
  local sequenceData8 = {
  {name = "fly8", frames={1,2,3,1},  count=3, time=550, loopCount = 0 }
  }   
 local ryu8 = display.newSprite (spriteSheet8, sequenceData8)
  ryu8.x = 470
  ryu8.y = 200
  ryu8:setSequence("fly8")
   ryu8:play()

   local sheetData9 =  { width = 52 , height= 236/4 , count = 1 , numFrames = 3 }
  local spriteSheet9 = graphics.newImageSheet("images/personaje3.png" , sheetData9)
  local sequenceData9 = {
  {name = "fly9", frames={1,2,3,1},  count=3, time=300, loopCount = 0 }
  }   
 local ryu9 = display.newSprite (spriteSheet9, sequenceData9)
  ryu9.x = 470
  ryu9.y = 250
  ryu9:setSequence("fly9")
   ryu9:play()
--TerminarManifestacion







  --Crear roca
  ball = display.newImage("roca.png",400,200)
  ball.myName = "piedra"
   group:insert( ball, true )
   ball.x = 400
   ball.y = 200
  --physics.addBody( ball, "dynamic", { density = 1.0, friction = 0.3, bounce = 0.2, radius = 20 } )
   
   function ball:touch( event )
    if event.phase == "began" then
        PosIniY =  event.y
        PosIniX = event.x
        self.markX = self.x  
        self.markY = self.y  
    elseif event.phase == "moved" then
        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY     
        self.x, self.y = x, y 
        elseif event.phase == "ended" then
          local temp = display.newImage("roca.png",400,200)
          physics.addBody( temp, "dynamic", { density = 1.0, friction = 0.8, bounce = 0.2, radius = 15 } )
          temp.x = PosIniX
          temp.y = PosIniY
          temp.myName = "piedra"
          temp:applyForce((PosIniX- event.x)*5, (PosIniY - event.y )*5, ball.x, ball.y)
          ball.x = 400
          ball.y = 200
          
        end                     
    return true
end
  ball:addEventListener( "touch", ball )
--terminaCrear roca





  local group = self.view
  local numCops = 10;
 -- background = display.newRect(group, 0,0, _W,_H)
  background = display.newImage("fodo.jpg")
  background:addEventListener("touch", onTouch)


background:toBack()




--RP:Background begins

-- Create a table to store all the fish and register this table as the 
-- "enterFrame" listener to animate all the fish.
local bounceAnimation = {
  container = display.getCurrentStage(),
  reflectX = true,
}





--RP:Background ends

  -- Empezar el motor de física
 
  -- Objetos paredes
  local paredSuperior = display.newRect(group, 0, -10, _W, 10 )
  paredSuperior.myName = "paredSuperior"  
  local paredInferior = display.newRect(group, 0, _H, _W, 10 )
  paredInferior.myName = "paredInferior"
  local paredIzquierda = display.newRect(group, -10, 0, 10, _H )
  paredIzquierda.myName = "paredIzquierda"
  local paredDerecha = display.newRect(group, _W, 0, 10, _H )
paredDerecha.myName = "paredDerecha"


  -- Cuerpos paredes
  physics.addBody(paredSuperior,  "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})
  physics.addBody(paredInferior,  "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})
  physics.addBody(paredIzquierda, "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})
  physics.addBody(paredDerecha,   "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})

 --  -- Barra
 -- local barra = display.newRect(group, 0, 0 , 220, 50)
 -- physics.addBody(barra,   "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})

  -- -- Pelota
  -- ball = display.newCircle(group, _W/2,_H/2,20)
  -- physics.addBody( ball, "dynamic", { density = 1.0, friction = 0.3, bounce = 0.2, radius = 20 } )


--RP
physics.start()


 crearPolicia = function()
 local dir = math.random(1,4)
 --local guy = display.newImage( "poli.png" )


--

local sheetData =  { width = 52 , height= 232/5 , count = 1 , numFrames = 5 }
  local spriteSheet = graphics.newImageSheet("poli2.png" , sheetData)
  local sequenceData = {
  {name = "guy", frames={1,2,3,4,5},  count=5, time=1000, loopCount = 0 }
  }   
 local guy = display.newSprite (spriteSheet, sequenceData)
   guy.y = math.random(40,300)
  guy.x = -30
  guy:setSequence("guy")
   guy:play()

--


  guy.myName = "guy"
 
  physics.addBody(guy,   "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})

  cantidadDePoliciasCreados = cantidadDePoliciasCreados + 1
  cantidadDePoliciasVivos = cantidadDePoliciasVivos + 1
  group:insert(guy)
  guy.animate = function( self )
    if guy.x then
    guy.x = guy.x + dir

    if guy.x > 450 then
      Runtime:removeEventListener("enterFrame", guy.animate)
      guy:removeSelf()
       cantidadDePoliciasVivos = cantidadDePoliciasVivos - 1
      cantidadDePoliciasEliminados = cantidadDePoliciasEliminados + 1
      lifes = lifes - 1
    end
  end
  end

  

  Runtime:addEventListener("enterFrame", guy.animate)
   Runtime:addEventListener("enterFrame", guy)

 return guy
end

comprobarCantidad = function()
  if cantidadDePoliciasVivos > 2 then

  else
  crearPolicia()
  crearPolicia()
  crearPolicia()
  crearPolicia()
  crearPolicia()


  end

end

 Runtime:addEventListener("comprobarCantidad", comprobarCantidad)

local function onComplete( event )
  print( "index => ".. event.index .. "    action => " .. event.action )

  local action = event.action
  if "clicked" == event.action then
    if 2 == event.index then
      -- Open url if "Learn More" was clicked by the user
      system.openURL( "http://www.chitopolo.com" )
    end
  elseif "cancelled" == event.action then
    -- our cancelAlert timer function dismissed the alert so do nothing
  end
end



 ifUserLose = function()
  
  if lifes < 0 then
    -- Show alert
    local alert = native.showAlert( "Game Over",  "Lo sentimos, has perdido tu puntaje es: 35 Segundos "  , { "OK", "Conozca mas!" }, onComplete )

    -- Dismisses alert after 10 seconds
    local function cancelAlert()
      native.cancelAlert( alert )
    end

  end
end




--RP: FACDEPOLISDEBOLAS 
--******************
-- Add Game Functionality
  
-- Stop character movement when no arrow is pushed
local function stop (event)
  if event.phase =="ended" then
    motionx = 0;
  end   
end
Runtime:addEventListener("touch", stop )

-- -- Move character
-- local function moveguy (event)
--   guy.x = guy.x + motionx  
-- end
-- Runtime:addEventListener("enterFrame", moveguy)


-- When right arrow is touched, move character right
function right()
  motionx = speed;
end
--right:addEventListener("touch",right)
timer.performWithDelay( 800, right, 0 )
-- Make character jump


-- Detect whether the player is in the air or not
function onCollision( event )
 
print(event.object1.myName)

print(event.object2.myName)



-- Remove coin when it reaches the ground
  if(event.object1.myName == "paredDerecha" and event.object2.myName == "guy") then
    lifes = lifes - 1;
    event.object2:removeSelf();
  end


  if(event.object1.myName == "guy" and event.object2.myName == "piedra") then
    playerScore = playerScore + 1
     cantidadDePoliciasVivos = cantidadDePoliciasVivos - 1
    event.object1:removeSelf()
    print("Si lo toco al policia")
  end


end
Runtime:addEventListener( "collision", onCollision )



-- End Game Functionality
--******************

--RP: termina facdepolisdebolas



  -- Botón pausa
  pauseBtn = widget.newButton
  {
      width = 50,
      height = 50,
      id = "button_1",
      label = "||",
      onEvent = pauseGame,
  }
  pauseBtn:setReferencePoint(display.TopRightReferencePoint)
  pauseBtn.x = _W
  group:insert(pauseBtn)

end




function scene:overlayEnded( event )
    physics.start()
    paused = false
end


--RP



--RP


scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "enterScene", scene )
Runtime:addEventListener( "enterFrame", onEnterFrame )
scene:addEventListener( "overlayEnded" )

-- Codigo RP:Objetos para mover


local function printTouch( event )
  if event.target then 
    local bounds = event.target.stageBounds
    print( "event(" .. event.phase .. ") ("..event.x..","..event.y..") bounds: "..bounds.xMin..","..bounds.yMin..","..bounds.xMax..","..bounds.yMax )
  end 
end

local function onTouch( event )
  local t = event.target

  -- Print info about the event. For actual production code, you should
  -- not call this function because it wastes CPU resources.
  printTouch(event)

  local phase = event.phase
  if "began" == phase then
    -- Make target the top-most object
    local parent = t.parent
    parent:insert( t )
    display.getCurrentStage():setFocus( t )

    -- Spurious events can be sent to the target, e.g. the user presses 
    -- elsewhere on the screen and then moves the finger over the target.
    -- To prevent this, we add this flag. Only when it's true will "move"
    -- events be sent to the target.
    t.isFocus = true

    -- Store initial position
    t.x0 = event.x - t.x
    t.y0 = event.y - t.y
     

        if t.myName=="botella" and swBotella ==true then
           
           transition.to( t, { time=500, xScale= 1.3  , yScale = 1.3 } )
        end
        if t.myName=="llanta" and swLlanta ==true then
           transition.to( t, { time=500, xScale= 1.3  , yScale = 1.3 } )
        end
        if t.myName=="tronco" and swTronco ==true then
           transition.to( t, { time=500, xScale= 1  , yScale = 1 } )
        end

  elseif t.isFocus then
    if "moved" == phase then
      -- Make object move (we subtract t.x0,t.y0 so that moves are
      -- relative to initial grab point, rather than object "snapping").
       
        if t.myName=="botella" and swBotella ==true then
           t.x = event.x - t.x0
           t.y = event.y - t.y0

        end
        if t.myName=="llanta" and swLlanta ==true then
           t.x = event.x - t.x0
           t.y = event.y - t.y0
        end
        if t.myName=="tronco" and swTronco ==true then
           t.x = event.x - t.x0
           t.y = event.y - t.y0
        end
    elseif "ended" == phase then
                 
              if t.myName=="botella" and swBotella ==true and t.y>35+68 then
                t.x = 35+70
                 t.y = 35
                 transition.to( t, { time=500, xScale= 1  , yScale = 1 } )
                local temporal1 = display.newImage("botella.png")
                temporal1.x = event.x
                temporal1.y = event.y
                temporal1.xScale =1.3
                temporal1.yScale =1.3
                physics.addBody(temporal1,   "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})
              end
     

     if t.myName=="botella" and swBotella ==true and t.y<35+68 then
                 t.x = 35+70
                 t.y = 35
                 transition.to( t, { time=500, xScale= 1  , yScale = 1 } )
      end
       
              if t.myName=="llanta" and swBotella ==true and t.y>35+68 then
                  t.x = 35
                 t.y = 35
                 transition.to( t, { time=500, xScale= 1  , yScale = 1 } )
                local temporal2 = display.newImage("llanta.png")
                temporal2.x = event.x
                temporal2.y = event.y
                temporal2.xScale =1.3
                temporal2.yScale =1.3
                temporal2.myName = "llanta"
                physics.addBody(temporal2,   "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})
                Runtime:addEventListener( "collision", temporal2 )

        end
         if t.myName=="llanta" and swBotella ==true and t.y<35+68 then
                  t.x = 35
                 t.y = 35
                 transition.to( t, { time=500, xScale= 1  , yScale = 1 } )
       end
              if t.myName=="tronco" and swBotella ==true and t.y>35+68 then

                t.x = 35+70+70
                t.y = 35
                transition.to( t, { time=500, xScale= 0.5  , yScale = 0.5 } )        
                local temporal3 = display.newImage("tronco.png")
                temporal3.x = event.x
                temporal3.y = event.y
                temporal3.xScale =1
                temporal3.yScale =1
                physics.addBody(temporal3,   "static", {density = 1.0, friction = 0, bounce = 0.8, isSensor = false})
        end
        if t.myName=="tronco" and swBotella ==true and t.y<35+68 then

  t.x = 35+70+70
                 t.y = 35
                 transition.to( t, { time=500, xScale= 0.5  , yScale = 0.5 } )   
end
 
 
               


      display.getCurrentStage():setFocus( nil )
      t.isFocus = false
    end
  end
  -- Important to return true. This tells the system that the event
  -- should not be propagated to listeners of any objects underneath.
  return true
end







-- listener used by Runtime object. This gets called if no other display object
-- intercepts the event.
local function printTouch2( event )
  print( "event(" .. event.phase .. ") ("..event.x..","..event.y..")" )
end

Runtime:addEventListener( "touch", printTouch2 )
--Termina Codigo RP:Objetos para mover


function scene:destroyScene( event )
  print( "((destroying game view))" )
  physics.stop()
end

return scene



