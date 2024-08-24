function conky_run_shell_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()

    return result:gsub("^%s*(.-)%s*$", "%1")
end

function conky_cpu_model()
    local command = "grep model /proc/cpuinfo | cut -d : -f2 | tail -1 | sed 's/\\s//'"
    return conky_run_shell_command(command)
end

function conky_check_nvidia()
    local command = "command -v nvidia-smi > /dev/null 2>&1 && echo 1 || echo 0"
    return conky_run_shell_command(command):gsub("%s+", "")
end

function conky_gpu_details(property)
    local command = string.format("nvidia-smi --query-gpu=%s --format=csv | tail -n 1", property)
    return conky_run_shell_command(command)
end

function conky_gpu_name()
    return conky_gpu_details("name")
end

function conky_gpu_utilization()
    return conky_gpu_details("utilization.gpu")
end

function conky_gpu_temperature()
    return conky_gpu_details("temperature.gpu")
end

function conky_gpu_frequency()
    return conky_gpu_details("clocks.gr")
end

function conky_gpu_memory()
    return conky_gpu_details("memory.used,memory.total")
end

function conky_gpu_power()
    return conky_gpu_details("power.draw,power.limit")
end

function conky_active_ethernet_interface()
    local command = "ip -o link show | awk '/ether/ && !/lo/ {print $2; exit}' | sed 's/://'"
    local result = conky_run_shell_command(command)
    if result and result ~= "" then
        return result
    else
        return ""
    end
end

function conky_active_wireless_interface()
    local command = "ip -o link show | awk '/wlan/ {print $2; exit}' | sed 's/://'"
    local result = conky_run_shell_command(command)
    if result and result ~= "" then
        return result
    else
        return ""
    end
end

function conky_active_ethernet_interface_ip()
    local interface = conky_active_ethernet_interface()
    if interface and interface ~= "" then
        local command = string.format("ip -o -4 addr show dev %s | awk '{print $4}' | awk -F/ '{print $1}'", interface)
        return conky_run_shell_command(command)
    else
        return "No active interface"
    end
end

function conky_active_wireless_interface_ip()
    local interface = conky_active_wireless_interface()
    if interface and interface ~= "" then
        local command = string.format("ip -o -4 addr show dev %s | awk '{print $4}' | awk -F/ '{print $1}'", interface)
        return conky_run_shell_command(command)
    else
        return "No active interface"
    end
end
