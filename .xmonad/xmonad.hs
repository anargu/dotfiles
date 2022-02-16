-- Copyright (C) 2020-2021 Aditya Shakya <adi1090x@gmail.com>
-- Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
--
-- Xmonad config for Archcraft 

-- ## Modules ## -------------------------------------------------------------------
import XMonad

import XMonad.Actions.Navigation2D
import XMonad.Actions.OnScreen

import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops as E
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
-- awaiting for xmonad-contrib 0.17.xx
-- import XMonad.Hooks.RescreenHook

import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Spiral
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ResizableTile
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)

import Graphics.X11.ExtraTypes.XF86
import System.Exit
import Control.Monad
import Data.Monoid
import Data.Maybe

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


-- -- ## Module Util FixedView ## ---------------------------------------------------------------
--
-- import Data.List
-- import Data.Maybe
-- import qualified XMonad.StackSet as W
--
-- -- Get the screen that a workspace is fixed to.
-- workspaceScreen :: (WorkspaceId -> Int) -> WorkspaceId -> WindowSet -> W.Screen WorkspaceId (Layout Window) Window ScreenId ScreenDetail
-- workspaceScreen f ws s =
--     screens !! index
--       where
--         screens = sortOn W.screen $ W.screens s
--         index = if length screens < f ws then 0 else f ws
--
-- -- Focus the monitor that a workspace is fixed to, without viewing the workspace.
-- focusScreen :: (WorkspaceId -> Int) -> WorkspaceId -> WindowSet -> WindowSet
-- focusScreen f ws s = W.view (W.tag . W.workspace $ workspaceScreen f ws s) s
--
-- -- View a workspace on a predefined monitor.
-- fixedView :: (WorkspaceId -> Int) -> WorkspaceId -> WindowSet -> WindowSet
-- fixedView f ws s
--     -- Workspace already has focus, switch to last used workspace for this screen.
--     | W.currentTag s == ws =
--         let toShow = find (\h -> W.screen (workspaceScreen f (W.tag h) s) == W.screen (W.current s)) (W.hidden s)
--         in maybe s (\a -> W.view (W.tag a) s) toShow
--     -- Workspace does not have focus (visible or hidden).
--     | otherwise = W.view ws . focusScreen f ws $ s
-- -- ## **END** Module Util FixedView ## ---------------------------------------------------------------


-- ## Startup hook ## ---------------------------------------------------------------
myStartupHook = do
  spawn "bash ~/.xmonad/bin/autostart.sh"

-- ## Applications ## ---------------------------------------------------------------
-- Terminal
myTerminal      	= "~/.xmonad/bin/xmoterm.sh"
kittyTerminal     = "~/.xmonad/bin/xmoterm.sh -kitty"

-- Apps
file_manager		= spawn "pcmanfm"
text_editor			= spawn "geany"
web_browser			= spawn "firefox"

-- Rofi Menus
rofi_asroot 		= spawn "~/.xmonad/rofi/bin/asroot"
rofi_launcher 		= spawn "~/.xmonad/rofi/bin/launcher"
rofi_mpd 			= spawn "~/.xmonad/rofi/bin/mpd"
rofi_network 		= spawn "~/.xmonad/rofi/bin/network"
rofi_network_menu 	= spawn "~/.xmonad/rofi/bin/network_menu"
rofi_powermenu 		= spawn "~/.xmonad/rofi/bin/powermenu"
rofi_screenshot 	= spawn "~/.xmonad/rofi/bin/screenshot"
rofi_windows 		= spawn "~/.xmonad/rofi/bin/windows"

-- ## Settings ## -------------------------------------------------------------------

-- focus follows the mouse pointer
myFocusFollowsMouse 	:: Bool
myFocusFollowsMouse 	= True

-- clicking on a window to focus
myClickJustFocuses 		:: Bool
myClickJustFocuses 		= False

-- Width of the window border in pixels
myBorderWidth   		= 2

-- Border colors for focused & unfocused windows
-- myFocusedBorderColor 	= "#BB553F"
myFocusedBorderColor 	= "#00e67e"
-- myNormalBorderColor  	= "#E6DFE0"
myNormalBorderColor  	= "#E6DFE0"

-- modMask : modkey you want to use
-- mod1Mask : left alt Key
-- mod4Mask : Windows or Super Key
myModMask       		= mod4Mask

-- Workspaces (ewmh)
myWorkspaces    		= ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
myWorkspacesAlt    	= ["1", "2", "3", "4"]

myWorkspacesNum = show <$> [1..9] ++ [0]

myWorkspaceScreens ws
    | ws >= "7" = 1
    | ws == "0" = 1
    | otherwise = 0

wsToScreen nScreens
  | nScreens == 1 = 0
  | nScreens == 2 = 1

-- ## Key Bindings ## -------------------------------------------------------------------
myKeys nScreens conf@(XConfig {XMonad.modMask = super}) = M.fromList $

    -- launch terminal
    [ ((super, xK_Return), 			spawn $ "~/.xmonad/bin/xmoterm.sh -kitty") --spawn $ XMonad.terminal conf)
    , ((super .|. shiftMask, 		xK_Return), spawn "~/.xmonad/bin/xmoterm.sh -f")

	-- launch applications
    , ((super .|. shiftMask, 		xK_f), 		file_manager)
    , ((super .|. shiftMask, 		xK_e), 		text_editor)
    , ((super .|. shiftMask, 		xK_w), 		web_browser)

    -- launch rofi menus
    , ((mod1Mask,           		xK_F1), 	rofi_launcher)
    , ((super,               		xK_n), 		rofi_network_menu)
    , ((super,               		xK_x), 		rofi_powermenu)
    , ((mod1Mask .|. controlMask, 	xK_m), 		rofi_mpd)
    , ((mod1Mask .|. controlMask, 	xK_n), 		rofi_network)
    , ((mod1Mask .|. controlMask, 	xK_s), 		rofi_screenshot)
    , ((mod1Mask .|. controlMask, 	xK_r), 		rofi_asroot)
    , ((mod1Mask .|. controlMask, 	xK_w), 		rofi_windows)

    -- Audio keys
    , ((0,         xF86XK_AudioPlay), 			spawn "mpc toggle")
    , ((0,         xF86XK_AudioPrev), 			spawn "mpc prev")
    , ((0,         xF86XK_AudioNext), 			spawn "mpc next")
    , ((0,         xF86XK_AudioStop), 			spawn "mpc stop")
    , ((0,         xF86XK_AudioRaiseVolume), 	spawn "volume --inc")
    , ((0,         xF86XK_AudioLowerVolume), 	spawn "volume --dec")
    , ((0,         xF86XK_AudioMute), 			spawn "volume --toggle")

    -- Brightness keys
    , ((0,         xF86XK_MonBrightnessUp), 	spawn "brightness --inc")
    , ((0,         xF86XK_MonBrightnessDown), 	spawn "brightness --dec") 

    -- Screenshot
    , ((0, 							xK_Print), 	spawn $ "takeshot --now")
    , ((mod1Mask, 					xK_Print), 	spawn $ "takeshot --in5")
    , ((shiftMask, 					xK_Print), 	spawn $ "takeshot --in10")
    , ((controlMask,				xK_Print), 	spawn $ "takeshot --win")
    , ((mod1Mask .|. controlMask  , xK_Print), 	spawn $ "takeshot --area")

    -- Close focused window
    , ((super, 		xK_c), 						kill)
    , ((super, 		xK_Escape), 				spawn "xkill")
    
    -- Lockscreen
    , ((mod1Mask .|. controlMask, 	xK_l), 		spawn "~/.xmonad/bin/xmolock.sh")

    -- Change gaps on the fly
    , ((super .|. controlMask, 	xK_g), sendMessage $ ToggleGaps)               					-- toggle all gaps
    , ((super .|. shiftMask, 	xK_g), sendMessage $ setGaps [(L,50), (R,50), (U,80), (D,50)]) 	-- reset the GapSpec
    
    , ((super .|. controlMask, 	xK_t), sendMessage $ IncGap 10 L)     -- increment the left-hand gap
    , ((super .|. shiftMask, 	xK_t), sendMessage $ DecGap 10 L)     -- decrement the left-hand gap
    
    , ((super .|. controlMask, 	xK_y), sendMessage $ IncGap 10 U)     -- increment the top gap
    , ((super .|. shiftMask, 	xK_y), sendMessage $ DecGap 10 U)     -- decrement the top gap
    
    , ((super .|. controlMask, 	xK_u), sendMessage $ IncGap 10 D)     -- increment the bottom gap
    , ((super .|. shiftMask, 	xK_u), sendMessage $ DecGap 10 D)     -- decrement the bottom gap

    , ((super .|. controlMask, 	xK_i), sendMessage $ IncGap 10 R)     -- increment the right-hand gap
    , ((super .|. shiftMask, 	xK_i), sendMessage $ DecGap 10 R)     -- decrement the right-hand gap

	-- Window Manager Specific -----------------------------------------

    -- Resize viewed windows to the correct size
    , ((super,                   xK_r), 		refresh)

    -- Move focus to the master window
    , ((super,               	xK_m), 		windows W.focusMaster)

    -- Swap the focused window and the master window
    , ((super,               	xK_s), 		windows W.swapMaster)

    -- Push window back into tiling
    , ((super,               	xK_t),		withFocused $ windows . W.sink)

    -- Rotate through the available layout algorithms
    , ((super,               xK_space), 		sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((super .|. shiftMask, xK_space), 		setLayout $ XMonad.layoutHook conf)

    -- Move focus to the next window
    , ((super,                 xK_Tab), 		windows W.focusDown)

    -- -- Move focus to the next window
    , ((super,               	xK_j), 		windows W.focusDown)
    , ((super,                xK_Left), 		windows W.focusDown)
    --
    -- -- Move focus to the previous window
    , ((super,               	xK_k), 		windows W.focusUp)
    , ((super,               xK_Right), 		windows W.focusUp)

    , ((super,                 xK_l), sendMessage $ Go R)
    , ((super,                 xK_h ), sendMessage $ Go L)
    , ((super,                 xK_k   ), sendMessage $ Go U)
    , ((super,                 xK_j ), sendMessage $ Go D)

    , ((super,                 xK_f ), sendMessage $ (Toggle "Full"))

    -- Swap the focused window with the next window
    -- , ((super .|. shiftMask, 	xK_j),		windows W.swapDown)
    -- , ((super .|. shiftMask, 	xK_Left),	windows W.swapDown)

    -- Swap the focused window with the previous window
    -- , ((super .|. shiftMask, 	xK_k),		windows W.swapUp)
    -- , ((super .|. shiftMask, 	xK_Right),	windows W.swapUp)
    --

    -- Shrink the master area
    , ((super .|. shiftMask,  xK_h),		sendMessage Shrink)
    , ((super .|. controlMask,   xK_Left),	sendMessage Shrink)

    , ((super .|. shiftMask,  xK_j),		sendMessage MirrorShrink)
    , ((super .|. controlMask,   xK_Down),	sendMessage MirrorShrink)

    -- Expand the master area
    , ((super .|. shiftMask,  xK_l),		sendMessage Expand)
    , ((super .|. controlMask,   xK_Right),	sendMessage Expand)

    , ((super .|. shiftMask,  xK_k),		sendMessage MirrorExpand)
    , ((super .|. controlMask,   xK_Up),	sendMessage MirrorExpand)

    -- Increment the number of windows in the master area
    , ((super, 					xK_comma),		sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((super,					xK_period),		sendMessage (IncMasterN (-1)))

    -- Restart xmonad
    , ((super, 						 xK_q),		spawn "xmonad --recompile; xmonad --restart")

    ]
    ++

	-- Workspace Specific ---------------------------------------------------------------

    -- keyBindings conf = let modm = modMask conf in fromList $
    -- {- lots of other keybindings -}
    --
    -- [((m .|. super, k), windows $ onCurrentScreen f i)
    --     | (i, k) <- zip (workspaces' conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    -- [ ((super, ws),   windows $ fixedView myWorkspaceScreens ws) | ws <- myWorkspacesNum ]
    -- [ ((super, ws),   windows $ fixedView myWorkspaceScreens ws) | ws <- myWorkspaces ]

    [
      -- ((super .|. 0, xK_1), windows $ viewOnScreen 0 "1"),
      -- ((super .|. 0, xK_2), windows $ viewOnScreen 0 "2"),
      -- ((super .|. 0, xK_3), windows $ viewOnScreen 0 "3"),
      -- ((super .|. 0, xK_4), windows $ viewOnScreen 0 "4"),
      -- ((super .|. 0, xK_5), windows $ viewOnScreen 0 "5"),

      -- ((super .|. 0, xK_6), windows $ viewOnScreen (wsToScreen nScreens) "6"),
      -- ((super .|. 0, xK_7), windows $ viewOnScreen (wsToScreen nScreens) "7"),
      -- ((super .|. 0, xK_8), windows $ viewOnScreen (wsToScreen nScreens) "8"),
      -- ((super .|. 0, xK_9), windows $ viewOnScreen (wsToScreen nScreens) "9"),
      -- ((super .|. 0, xK_0), windows $ viewOnScreen (wsToScreen nScreens) "10"),
      --
      -- ((super .|. shiftMask, xK_1), windows $ W.shift "1"),
      -- ((super .|. shiftMask, xK_2), windows $ W.shift "2"),
      -- ((super .|. shiftMask, xK_3), windows $ W.shift "3"),
      -- ((super .|. shiftMask, xK_4), windows $ W.shift "4"),
      -- ((super .|. shiftMask, xK_5), windows $ W.shift "5"),
      --
      -- ((super .|. shiftMask, xK_6), windows $ W.shift "6"),
      -- ((super .|. shiftMask, xK_7), windows $ W.shift "7"),
      -- ((super .|. shiftMask, xK_8), windows $ W.shift "8"),
      -- ((super .|. shiftMask, xK_9), windows $ W.shift "9"),
      -- ((super .|. shiftMask, xK_0), windows $ W.shift "10")

      ((super .|. 0, xK_1), windows $ viewOnScreen 0 "0_1"),
      ((super .|. 0, xK_2), windows $ viewOnScreen 0 "0_2"),
      ((super .|. 0, xK_3), windows $ viewOnScreen 0 "0_3"),
      ((super .|. 0, xK_4), windows $ viewOnScreen 0 "0_4"),

      ((super .|. 0, xK_7), windows $ viewOnScreen (wsToScreen nScreens) "1_1"),
      ((super .|. 0, xK_8), windows $ viewOnScreen (wsToScreen nScreens) "1_2"),
      ((super .|. 0, xK_9), windows $ viewOnScreen (wsToScreen nScreens) "1_3"),
      ((super .|. 0, xK_0), windows $ viewOnScreen (wsToScreen nScreens) "1_4"),

      --
      ((super .|. shiftMask, xK_1), windows $ W.shift "0_1"),
      ((super .|. shiftMask, xK_2), windows $ W.shift "0_2"),
      ((super .|. shiftMask, xK_3), windows $ W.shift "0_3"),
      ((super .|. shiftMask, xK_4), windows $ W.shift "0_4"),

      ((super .|. shiftMask, xK_7), windows $ W.shift "1_1"),
      ((super .|. shiftMask, xK_8), windows $ W.shift "1_2"),
      ((super .|. shiftMask, xK_9), windows $ W.shift "1_3"),
      ((super .|. shiftMask, xK_0), windows $ W.shift "1_4")
      

      -- ((super .|. 0, xK_1), windows $ viewOnScreen 0 "0_1"),
      -- ((super .|. 0, xK_2), windows $ viewOnScreen (wsToScreen nScreens) "1_1"),
      --
      -- ((super .|. 0, xK_3), windows $ viewOnScreen 0 "0_2"),
      -- ((super .|. 0, xK_4), windows $ viewOnScreen (wsToScreen nScreens) "1_2"),
      --
      -- ((super .|. 0, xK_7), windows $ viewOnScreen 0 "0_3"),
      -- ((super .|. 0, xK_8), windows $ viewOnScreen (wsToScreen nScreens) "1_3"),
      --
      -- ((super .|. 0, xK_9), windows $ viewOnScreen 0 "0_4"),
      -- ((super .|. 0, xK_0), windows $ viewOnScreen (wsToScreen nScreens) "1_4"),
      --
      --
      -- --
      -- ((super .|. shiftMask, xK_1), windows $ W.shift "0_1"),
      -- ((super .|. shiftMask, xK_2), windows $ W.shift "1_1"),
      --
      -- ((super .|. shiftMask, xK_3), windows $ W.shift "0_2"),
      -- ((super .|. shiftMask, xK_4), windows $ W.shift "1_2"),
      --
      -- ((super .|. shiftMask, xK_7), windows $ W.shift "0_3"),
      -- ((super .|. shiftMask, xK_8), windows $ W.shift "1_3"),
      --
      -- ((super .|. shiftMask, xK_9), windows $ W.shift "0_4"),
      -- ((super .|. shiftMask, xK_0), windows $ W.shift "1_4")

    ]

    -- ++ [ ("M-S-" ++ ws, windows $ W.shift ws)                      | ws <- myWorkspaces ]

    -- -- mod-[1..9], Switch to workspace N
    -- -- mod-shift-[1..9], Move client to workspace N
    -- [((m .|. super, k), windows $ f i)
    --     | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]
    --     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{y,u,i}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{y,u,i}, Move client to screen 1, 2, or 3
    [((m .|. super, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_y, xK_u, xK_i] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- ## Mouse Bindings ## ------------------------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = super}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((super, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((super, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((super, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

-- ## Layouts ## -------------------------------------------------------------------------
myLayout = windowNavigation $ avoidStruts $ toggleLayouts (noBorders Full) (tiled ||| Mirror tiled ||| Full)
	where
		-- default tiling algorithm partitions the screen into two panes
		tiled   = ResizableTall nmaster delta ratio []

		-- The default number of windows in the master pane
		nmaster = 1

		-- Default proportion of screen occupied by master pane
		ratio   = 1/2

		-- Percent of screen to increment by when resizing panes
		delta   = 3/100


-- myLayout = avoidStruts(tiled ||| Mirror tiled ||| Full)
-- 	where
-- 		-- default tiling algorithm partitions the screen into two panes
-- 		tiled   = Tall nmaster delta ratio
--
-- 		-- The default number of windows in the master pane
-- 		nmaster = 1
--
-- 		-- Default proportion of screen occupied by master pane
-- 		ratio   = 1/2
--
-- 		-- Percent of screen to increment by when resizing panes
-- 		delta   = 3/100

-- ## Window rules ## --------------------------------------------------------------------
myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doCenterFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    ]
    where
		myCFloats = ["alacritty-float", "MPlayer", "mpv",
					"Gimp", "feh", "Viewnior", "Gpicview",
					"Kvantum Manager", "qt5ct", "VirtualBox Manager", "qemu", "Qemu-system-x86_64",
					"Lxappearance", "Nitrogen", "Arandr", "Pavucontrol", "Xfce4-power-manager-settings", "Nm-connection-editor"]
		myTFloats = ["Downloads", "Save As...", "About : Aditya Shakya", "Getting Started"]
		myRFloats = []
		myIgnores = ["desktop_window"]

-- ## Event handling ## -------------------------------------------------------------------
-- myEventHook = ewmhDesktopsEventHook
myEventHook = handleEventHook def <+> E.fullscreenEventHook

-- ## Logging ## --------------------------------------------------------------------------
myLogHook = return ()
-- screensChanged = do
--   actualScreens <- countScreens
--   workspaceScreens <- reader $ length . nub . fmap unmarshallS . workspaces . config
--   return $ actualScreens /= workspaceScreens
--
-- myLogHook = whenX screensChanged restartXmonad
--   where restartXmonad = trace "Restarting xmonad" >> restart "xmonad" True

-- ## Main Function ## --------------------------------------------------------------------

-- myNavigation2DConfig = def { layoutNavigation = [("Full", sideNavigation)] }

-- Run xmonad with all the configs we set up.

-- [when rescreen] (plug/unplug monitor)
-- myAfterRescreenHook = do
--   restart "xmonad" True
--
-- rescreenCfg = def{
--     afterRescreenHook = myAfterRescreenHook
-- }

main = do
  nScreens <- countScreens
  xmonad $ fullscreenSupport
              $ docks
              -- $ navigation2D def
              --                (xK_k, xK_h, xK_j, xK_l)
              --                [(mod4Mask,               windowGo  ),
              --                 (mod4Mask .|. shiftMask, windowSwap)]
              --                False
              -- $ withNavigation2DConfig myNavigation2DConfig
              $ ewmh (defaults nScreens)


defaults nScreens = def {
      -- configs
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- workspaces         = myWorkspaces,
        workspaces         = withScreens 2 myWorkspacesAlt,
        -- workspaces         = withScreens 1 myWorkspaces,

        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys nScreens,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        manageHook = myManageHook,
        layoutHook = gaps [(L,0), (R,0), (U,0), (D,0)] $ spacingRaw False (Border 10 0 10 0) True (Border 0 10 0 10) True $ myLayout,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
      -- [when rescreen] (plug/unplug monitor)
        -- rescreenHook       = rescreenCfg
    }
