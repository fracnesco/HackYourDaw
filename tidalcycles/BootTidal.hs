:set -XOverloadedStrings
:set prompt ""

import Sound.Tidal.Context

import System.IO (hSetEncoding, stdout, utf8)

hSetEncoding stdout utf8

-- total latency = oLatency + cFrameTimespan
:{
customTarget = Target {oName = "Max", -- Give your target a name
                      oAddress = "127.0.0.1", -- the target network address
                      oPort = 2020, -- the target network port
                      oLatency = 0.2, -- the latency (to smooth network jitter
                      oSchedule = Live,
                      oWindow = Nothing,
                      oHandshake = False,
                      oBusPort = Nothing
                      }
:}

tidal <- startTidal (customTarget {oLatency = 0.2, oAddress = "127.0.0.1", oPort = 2020}) (defaultConfig {cFrameTimespan = 1/20})


:{
let p = streamReplace tidal
    hush = streamHush tidal
    list = streamList tidal
    mute = streamMute tidal
    unmute = streamUnmute tidal
    solo = streamSolo tidal
    unsolo = streamUnsolo tidal
    once = streamOnce tidal
    first = streamFirst tidal
    asap = once
    nudgeAll = streamNudgeAll tidal
    all = streamAll tidal
    resetCycles = streamResetCycles tidal
    setcps = asap . cps
    xfade i = transition tidal True (Sound.Tidal.Transition.xfadeIn 4) i
    xfadeIn i t = transition tidal True (Sound.Tidal.Transition.xfadeIn t) i
    histpan i t = transition tidal True (Sound.Tidal.Transition.histpan t) i
    wait i t = transition tidal True (Sound.Tidal.Transition.wait t) i
    waitT i f t = transition tidal True (Sound.Tidal.Transition.waitT f t) i
    jump i = transition tidal True (Sound.Tidal.Transition.jump) i
    jumpIn i t = transition tidal True (Sound.Tidal.Transition.jumpIn t) i
    jumpIn' i t = transition tidal True (Sound.Tidal.Transition.jumpIn' t) i
    jumpMod i t = transition tidal True (Sound.Tidal.Transition.jumpMod t) i
    mortal i lifespan release = transition tidal True (Sound.Tidal.Transition.mortal lifespan release) i
    interpolate i = transition tidal True (Sound.Tidal.Transition.interpolate) i
    interpolateIn i t = transition tidal True (Sound.Tidal.Transition.interpolateIn t) i
    clutch i = transition tidal True (Sound.Tidal.Transition.clutch) i
    clutchIn i t = transition tidal True (Sound.Tidal.Transition.clutchIn t) i
    anticipate i = transition tidal True (Sound.Tidal.Transition.anticipate) i
    anticipateIn i t = transition tidal True (Sound.Tidal.Transition.anticipateIn t) i
    forId i t = transition tidal False (Sound.Tidal.Transition.mortalOverlay t) i
    d1 = p 1 . (|< orbit 0)
    d2 = p 2 . (|< orbit 1)
    d3 = p 3 . (|< orbit 2)
    d4 = p 4 . (|< orbit 3)
    d5 = p 5 . (|< orbit 4)
    d6 = p 6 . (|< orbit 5)
    d7 = p 7 . (|< orbit 6)
    d8 = p 8 . (|< orbit 7)
    d9 = p 9 . (|< orbit 8)
    d10 = p 10 . (|< orbit 9)
    d11 = p 11 . (|< orbit 10)
    d12 = p 12 . (|< orbit 11)
    d13 = p 13
    d14 = p 14
    d15 = p 15
    d16 = p 16
    --parameters
    pitch = pF "pitch"
    begin = pF "begin"
    res = pF "res"
    vel = pF "vel"
    cutoff = pF "cutoff"
    drive = pF "drive"
    filtertype = pS "filter"
    legato = pF "legato"
    --synth parameters
    pitchbend = pF "pitchbend"
    modwheel = pF "modwheel"
    aftertouch = pF "aftertouch"
    pbend = pitchbend
    modw = modwheel
    atouch = aftertouch
    --macro
    macro1 = pF "macro1"
    macro2 = pF "macro2"
    macro3 = pF "macro3"
    macro4 = pF "macro4"
    macro5 = pF "macro5"
    macro6 = pF "macro6"
    macro7 = pF "macro7"
    macro8 = pF "macro8"
    allmacro x = macro1 x #macro2 x #macro3 x #macro4 x #macro6 x #macro7 x #macro8 x
    allmacrorand = macro1 rand #macro2 (slow 1.1 rand) #macro3 (slow 1.3 rand) #macro4 (slow 1.4 rand) #macro5 (slow 1.5 rand) #macro6 (slow 1.6 rand) #macro7 (slow 1.7 rand) #macro8 (slow 1.8 rand)
    --sends
    send1 = pF "send1"
    send2 = pF "send2"
    send3 = pF "send3"
    send4 = pF "send4"
    send5 = pF "send5"
    send6 = pF "send6"
    send7 = pF "send7"
    send8 = pF "send8"
    sendA = pF "send1"
    sendB = pF "send2"
    sendC = pF "send3"
    sendD = pF "send4"
    sendE = pF "send5"
    sendF = pF "send6"
    sendG = pF "send7"
    sendH = pF "send8"
    allsend x = send1 x #send2 x #send3 x #send4 x #send6 x #send7 x #send8 x
    allsendrand = send1 rand #send2 (slow 1.1 rand) #send3 (slow 1.3 rand) #send4 (slow 1.4 rand) #send5 (slow 1.5 rand) #send6 (slow 1.6 rand) #send7 (slow 1.7 rand) #send8 (slow 1.8 rand)

:}

:{
let setI = streamSetI tidal
    setF = streamSetF tidal
    setS = streamSetS tidal
    setR = streamSetR tidal
    setB = streamSetB tidal
:}

:set prompt "tidal> "
:set prompt-cont ""
