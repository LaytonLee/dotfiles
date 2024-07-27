# turn on proxy
function proxyon() {
        local terminal_proxy=false
        local system_proxy=false

        while getopts "p:ats" arg; do
                case $arg in
                        p)
                                local proxy_type="${OPTARG}"
                                ;;
                        a)
                                local terminal_proxy=true
                                local system_proxy=true
                                ;;
                        t)
                                local terminal_proxy=true
                                ;;
                        s)
                                local system_proxy=true
                                ;;
                        ?)
                                echo "** Error: Unrecognized command"
                                return
                esac
        done

        if [[ -z "$proxy_type" ]] ; then
                echo -e "** Error: Please specify a specific proxy type"
                return
        elif [[ "$proxy_type" != "xray" ]] && [[ "$proxy_type" != "clash" ]] ; then
                echo -e "** Error: Invalid proxy type"
                return
        fi

        if [[ -z "$3" ]] ; then
                vared -p 'Do you mean turn on both system and terminal proxy? [Y/n] ' -c option

                if [[ "$option" = "Y" ]] ; then
                        system_proxy=true
                        terminal_proxy=true
                else
                        return
                fi
        fi

        if [[ "$proxy_type" = "clash" ]] ; then
                local proxy_ip="127.0.0.1"
                local http_proxy_port="7890"
                local socks_proxy_port="7890"
        fi

        if [[ "$proxy_type" = "xray" ]]; then
               local proxy_ip="127.0.0.1"
               local http_proxy_port="10801"
               local socks_proxy_port="10800"
        fi

        if [[ "$terminal_proxy" = true ]]; then
	        export proxy="http://$proxy_ip:$http_proxy_port"
	        export http_proxy="$proxy"
	        export https_proxy="$proxy"
	        export all_proxy="$proxy"
	        export no_proxy="localhost, 127.0.0.1, ::1"
                echo -e "Terminal proxy has enabled."
        fi

        if [[ "$system_proxy" = true ]] ; then
                networksetup -setwebproxy Wi-Fi "$proxy_ip" "$http_proxy_port"
                networksetup -setsecurewebproxy Wi-Fi "$proxy_ip" "$http_proxy_port"
                networksetup -setsocksfirewallproxy Wi-Fi "$proxy_ip" "$socks_proxy_port"

                networksetup -setwebproxystate Wi-Fi on
                networksetup -setsecurewebproxystate Wi-Fi on
                networksetup -setsocksfirewallproxystate Wi-Fi on
	        echo -e "System proxy has enabled"
        fi
}


# turn off proxy
function proxyoff(){
        local terminal_proxy=false
        local system_proxy=false

        if [[ -z "$1" ]]; then
                vared -p 'Do you mean turn off both terminal and system proxy? [Y/n] ' -c option
                if [[ "$option" = "Y" ]] ; then
                        terminal_proxy=true
                        system_proxy=true
                else
                        return
                fi
        fi

        while getopts "ats" arg; do
                case $arg in
                        a)
                                terminal_proxy=true
                                system_proxy=true
                                ;;
                        t)
                                terminal_proxy=true
                                ;;
                        s)
                                system_proxy=true
                                ;;
                        ?)
                                echo "** Error: Unrecognized command"
                                return
                esac
        done

        if [[ "$terminal_proxy" = true ]] ; then
                unset http_proxy https_proxy all_proxy
                echo -e "Terminal proxy has disabled"
        fi

        if [[ "$system_proxy" = true ]] ; then
                networksetup -setwebproxystate Wi-Fi off
                networksetup -setsecurewebproxystate Wi-Fi off
                networksetup -setsocksfirewallproxystate Wi-Fi off
                echo -e "System proxy has disabled"
        fi
}
