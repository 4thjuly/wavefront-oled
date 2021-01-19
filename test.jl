using Sockets, Printf

const OledLib = "liboled"

const FONT12 = cglobal((:Font12, OledLib), Cvoid)
const FONT24 = cglobal((:Font24, OledLib), Cvoid)

clear(col = 0x0000) = @ccall OledLib.OLED_Clear(col::Cushort)::Cvoid
display() = @ccall OledLib.OLED_Display()::Cvoid
drawString24pt(x, y, msg) = @ccall OledLib.GUI_DisString_EN(x::Cushort, y::Cushort, msg::Cstring, FONT24::Ptr{Cvoid}, 0x00::Cushort, 0xFF::Cushort)::Cvoid
drawString12pt(x, y, msg) = @ccall OledLib.GUI_DisString_EN(x::Cushort, y::Cushort, msg::Cstring, FONT12::Ptr{Cvoid}, 0x00::Cushort, 0xFF::Cushort)::Cvoid

function init() 
    @ccall OledLib.DEV_ModuleInit()::Cvoid
    @ccall OledLib.OLED_Init(0::Cint)::Cvoid	
end


function displayIP()
    ip = ip"0.0.0.0"
    try
        ip = getipaddr()
    catch exc
        # no ip
    end

    ipstr = string(ip)
    drawString12pt(0, 0, ipstr)
    display()
end

function displayRTT()
    start = time_ns()
    socket = connect(ip"192.168.139.1", 80)
    finish = time_ns()
    close(socket)
    emsStr = @sprintf("%.2f ms", (finish-start) / 1_000_000)
    drawString12pt(0, 10, emsStr)
    display()
end

function main()
    init()

    clear(0xff)
    display()
    sleep(1)

    clear()
    display()
    sleep(1)

    clear()
    drawString12pt(0, 0, "Starting")
    display()

    while true
        clear()
        displayIP()
        displayRTT()
        sleep(1)
    end
end

main()

