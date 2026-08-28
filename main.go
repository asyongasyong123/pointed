package main

import (
    "io"
    "log"
    "net"
    "os"
)

func handleClient(clientConn net.Conn, targetAddr string) {
    defer clientConn.Close()
    log.Println("✅ Koneksyon gikan sa:", clientConn.RemoteAddr(), "→ Padung:", targetAddr)

    remoteConn, err := net.Dial("tcp", targetAddr)
    if err != nil {
        log.Println("❌ Dili makakonektar:", err)
        return
    }
    defer remoteConn.Close()

    go func() {
        io.Copy(remoteConn, clientConn)
        remoteConn.CloseWrite()
    }()

    io.Copy(clientConn, remoteConn)
}

func main() {
    listenAddr := ":" + os.Getenv("PORT")
    targetHost := os.Getenv("V2RAY_SERVER_IP")
    targetPort := os.Getenv("TARGET_PORT")
    
    if targetPort == "" {
        targetPort = "80" // default port 80 — mas dali mogana
    }
    
    targetAddr := targetHost + ":" + targetPort

    log.Println("🚀 Go Proxy — Tulay Naka!")
    log.Println("📍 Naminaw sa port:", os.Getenv("PORT"))
    log.Println("🎯 Ipadung padung sa:", targetAddr)

    listener, err := net.Listen("tcp", listenAddr)
    if err != nil {
        log.Fatal("❌ Dili makasugod:", err)
    }
    defer listener.Close()

    for {
        clientConn, err := listener.Accept()
        if err != nil {
            continue
        }
        go handleClient(clientConn, targetAddr)
    }
}
