-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- OmaKeys: Vimac-style keyboard mouse (grid + AT-SPI/vision hints).
o.launch_on_start((os.getenv("HOME") or "") .. "/.local/bin/omakeys daemon")
